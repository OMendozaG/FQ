unit FQ.Flow;

interface

uses
	System.SysUtils, System.Classes, Generics.Collections, StrUtils, FQ, FQ.GVar;

type TRunOnThread = class(TThread)
public
     Flow: Pointer;
     FreeAtEnd:Boolean;
protected
    procedure Execute; override;
end;

type TFlow = class
	public
    	SectionName:String;
        Result: TGVar;
        PreventFreeOfResult:Boolean;
        Parent: TFQ;
        Semaphore:Boolean;
        StopThread:Boolean;
        PID:String;
        StartAtLineName: String;

        TID:Integer;
    	Pos:integer;
        PosMax:integer;
        Runned:Boolean;

        Env: TDictionary<String, TGVar>;
        EnvParams:String;

        constructor Create(const FQParentPointer:Pointer; const Name:String; const LineName:String = '');
        destructor Destroy(); override;
        procedure DeclareEnv(const Line:string); overload;
        procedure DeclareEnv(const Params:TDictionary<String, TGVar>; FreeDictionary:Boolean=false); overload;
        procedure Run();
        function RunOnThread(const SelfFree:Boolean=True; ThreadPriority:Integer=3):integer;

        function GetCurrentLineName(const WithPid:Boolean = True):string;

        procedure SetEnv(const Name:string; const Data:TGVar);
        procedure UnsetEnv(const Name:string);
        
        procedure ArrayAssociate(const C:Char; const Line:string);
        procedure ArrayExpand(const C:Char; Name:string);
        procedure ArrayContract(const C:Char; const Name:string);
        function ArrayGetNext(const C:String; const Name:String): Integer;
        function ArrayGetLast(const C:String; const Name:String): Integer;

        procedure SolveLine(const Line:String);
        function SolvePart(const Line:String; const SelfClear:Boolean = False): TGVar;
        function SolveData(const Line:String; const SelfClear:Boolean = False): TGVar;
        function SolveVar(const C:Char; const Name:String; const PreventNotification:Boolean = False): TGVar;
        function SolveArrayName(const C:Char; const Line:String; const ForSet: Boolean = False): String;
        function SolveComparation(const Line:String):Boolean;
        function SolveOperation(Line:String):String;

    private
        Script:TDictionary<Integer, String>;
        ScriptLinesName:TDictionary<Integer, String>;
        FlowFunctions:TDictionary<String, Integer>;

        function EnvArrayGetNext(const C:String; const Name:String): Integer;
        function FindClaspClose(const From:Integer; const WantElse:Boolean = False): integer;
        function FindClaspBucle(const From:Integer): integer;

end;

implementation

uses FQ.FQF;

constructor TFlow.Create(const FQParentPointer:Pointer; const Name:String; const LineName:String = '');
begin
	//Definimos los valores default
       	Parent := FQParentPointer;
        SectionName := LowerCase(Name);

        Semaphore := False;
        PID := Parent.GetPID();
        Runned := False;
        StartAtLineName := LineName;
        PreventFreeOfResult := False;
        StopThread := False;

        if (not Parent.Script.ContainsKey(SectionName)) then exit;

        Script := TDictionary<Integer, String>.create(Parent.Script[SectionName]);
        ScriptLinesName := TDictionary<Integer, String>.create(Parent.ScriptLinesName.Items[SectionName]);
        FlowFunctions := TDictionary<String, Integer>.create();

        Env := TDictionary<String, TGVar>.create();
        EnvParams := '';

        Result := TGVar.Create();

        Pos := -1;
        PosMax := Script.Count - 1;
end;

destructor TFlow.Destroy();
var
	K:String;
begin
	//Limpiamos los objetos utilizados por el camino
    	Script.Free;
        ScriptLinesName.Free;
        FlowFunctions.Free;


        if ((not Env.ContainsKey('result')) and (not PreventFreeOfResult)) then
        	Result.Free
        else if ((PreventFreeOfResult) and (Env.ContainsKey('result'))) then
             Env['result'] := TGVar.Create;

        for K in Env.Keys do Env[K].Free;
        Env.Free;

		inherited;
end;

procedure TFlow.DeclareEnv(const Line:string);
var
	K:String;
	Elements:TDictionary<String, TGVar>;
begin
	//Partimos los parametros de line y los solucionamos
    	Elements := TFQF(Parent.FQF).GetParams(Line, Self);
    	DeclareEnv(Elements);

        for K in Elements.Keys do Elements[K].Free;
        Elements.Free;
end;

procedure TFlow.DeclareEnv(const Params:TDictionary<String, TGVar>; FreeDictionary:Boolean=false);
var
	K:string;
begin
    //Seteamos el env
    for K in Params.Keys do begin

	    SetEnv(K, Params[K].Duplicate());
        ArrayExpand('$', K);
    end;

    if (Assigned(Parent.OnStack)) then begin
    	for K in Params.Keys do
	    	EnvParams := EnvParams + K + ':' + '"' + Params[K].GetValue + '",';
        EnvParams := EnvParams.Substring(0, EnvParams.Length-1);
    end;

    if (FreeDictionary) then begin
    	for K in Params.Keys do Params[K].Free;
    	Params.Free;
    end;

end;

procedure TFlow.Run();
var
	LastPos:integer;
begin
	//Prevenimos doble ejecución
    	if (Runned) then begin
        	if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName+'Error: Cannot run same flow two or more times.', 2);
            exit;
        end;
    	Runned := True;

	//Definimos los valores default
        Pos := 0;

        Result.Free;
        Result := TGVar.Create();

    //Y runeamos el asunto
       	if (Assigned(Parent.OnStack)) then Parent.DoStack(PID, SectionName, True, '', EnvParams, StartAtLineName);
        if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName+'Runing Flow ["' + SectionName + '"]', 4);

        while (Pos <= PosMax) do begin
            if (Parent.BreakStack) then begin
            	if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Flow Killed by Global Stack Break.', 3);
            	Break;
            end;

            if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Runing Line [' + Parent.LineFormat(Script[Pos]) + ']', 5);

            LastPos := Pos;
            try
            	SolveLine(Script[Pos]);
            except on E : Exception do begin
            	if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Exception: [' + E.ClassName + ': ' + E.Message + ']', 1);
                if (Pos = LastPos) then Pos := Pos + 1;
                if (Parent.BreakFlowOnException) then break;
                continue;
            end; end;
        end;

        try
        if (Env.ContainsKey('result')) then begin
        	Result.Free;
          	Result := Env['result'];
            if (Result.GVarType = 3) then ArrayContract('$', 'result');
        end; except end;

        Pos := LastPos;
        if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'End Flow. Result: ["' + Result.GetValue + '"]', 4);
        if (Assigned(Parent.OnStack)) then Parent.DoStack(PID, SectionName, False, Result.GetValue, EnvParams, StartAtLineName);
end;

procedure TRunOnThread.Execute;
begin

	TFLow(Flow).Semaphore := True;
    TFLow(Flow).Run;
    TFLow(Flow).Semaphore := False;


    TFLow(Flow).Parent.ThreadLock_ThreadAdd.Acquire;
	if TFLow(Flow).Parent.Threads.ContainsKey(TFLow(Flow).TID) then
	    TFLow(Flow).Parent.Threads.Remove(TFLow(Flow).TID);
    TFLow(Flow).Parent.ThreadLock_ThreadAdd.Release;


    Self.Terminate;
    if FreeAtEnd then TFLow(Flow).Free;
end;

function TFlow.RunOnThread(const SelfFree:Boolean=True; ThreadPriority:Integer=3):integer;
var
	RunOnThread:TRunOnThread;
begin
	//Definimos los valores default
        if (Semaphore) then Exit;

        RunOnThread := TRunOnThread.Create(True);

        Parent.ThreadLock_ThreadAdd.Acquire;
        TID := Parent.GetTID;
        Parent.Threads.Add(TID, RunOnThread);
        Parent.ThreadLock_ThreadAdd.Release;

        RunOnThread.Flow := Self;
        RunOnThread.FreeAtEnd := SelfFree;
        RunOnThread.FreeOnTerminate := True;



        {$IFDEF MSWINDOWS}
            if ((ThreadPriority < 0) or (ThreadPriority > 6)) then ThreadPriority := 3;
            RunOnThread.Priority :=  TThreadPriority(ThreadPriority);
        {$ENDIF MSWINDOWS}
        RunOnThread.Start;

        Result := TID;

end;

function TFlow.GetCurrentLineName(const WithPid:Boolean = True):string;
begin
	Result := '';

	if (WithPid) then Result := Result + '[' + PID + '] ';
    if (ScriptLinesName.ContainsKey(Pos)) then
		Result := Result + '[' + ScriptLinesName[Pos]+'] '
    else if (Pos = -1) then
    	Result := Result + '[' + SectionName + '@External] '
    	else Result := Result + '[' + SectionName + '@k:' + IntToStr(Pos) +'] ';
end;

function TFlow.FindClaspClose(const From:Integer; const WantElse:Boolean = False): integer;
var
	Ce:Char;
	OnClasp,L:Integer;
	GotoP:integer;
    Elseif:string;
begin
	//Buscamos el siguiente claspClose y retornamos su punto
    	Result := From + 1;
        OnClasP := 0;
        for GotoP := From + 1 to PosMax do begin

        	L := Script[GotoP].Length;
        	if (Script[GotoP].Chars[L-1] = '{') then    //or ((L >= 2) and (Script[GotoP].Chars[L-2] = '{'))
            	OnClasP := OnClasP + 1
            else if (Script[GotoP].Chars[0] = '}') then
            	OnClasP := OnClasP - 1;

        	if (OnClasp = -1) then break;            
    	end;

        Result := GotoP;
        
        if ((WantElse) and (GotoP + 1 <= PosMax) and (Script[GotoP + 1].Substring(0, 4) = 'else')) then begin
        	if (Script[GotoP + 1].Substring(0, 5) = 'else{') then begin
            	GotoP := GotoP + 2;
                Result := GotoP;
            end else if (Script[GotoP + 1].Substring(0, 6) = 'elseif') then begin 
				Pos := GotoP + 1;
                ElseIf := Script[Pos].Substring(4);
                if (ElseIf <> '') then SolveLine(ElseIf);
                Result := Pos;
            end;
        end;
end;


function TFlow.FindClaspBucle(const From:Integer): integer;
var
	C:Char;
    Found:Boolean;
	GotoP,L:Integer;
begin
	//Buscamos el siguiente claspClose y retornamos su punto
    	GotoP := From - 1;
        while GotoP >= 0 do begin

            C := Script[GotoP].Chars[0];
            L := Script[GotoP].Length;

            if (Script[GotoP].Chars[L-1] = '{') then begin  // or ((L >= 2) and (Script[GotoP].Chars[L-2] = '{')))
                if (((C = 'w') and (Script[GotoP].Substring(0,5) = 'while'))
                    or ((C = 'f') and (Script[GotoP].Substring(0,3) = 'for'))
                    or ((C = 'f') and (Script[GotoP].Substring(0,7) = 'foreach'))) then begin

                        if FindClaspClose(GotoP) > From then  begin Found := true; break; end;
                end;
            end;

            GotoP := GotoP - 1;
    	end;

        if (Found) then
			Result := GotoP
        else Result := From + 1;
end;

function TFlow.EnvArrayGetNext(const C:String; const Name:String): Integer;
var
	GArray:TDictionary<String, TGVar>;
begin
	Result := 0;
	if (C = '$') then begin
		if (Env.ContainsKey(Name)) and (Env[Name].GVarType = 3) then
        	GArray := Env[Name].GetArray else exit;
    end else if (C = '@') then begin
		if (Parent.Env.ContainsKey(Name)) and (Parent.Env[Name].GVarType = 3) then
        	GArray := Parent.Env[Name].GetArray else exit;
    end;

    while (GArray.ContainsKey(IntToStr(Result))) do Result := Result + 1;
end;

procedure TFlow.SetEnv(const Name:string; const Data:TGVar);
begin
    UnsetEnv(Name);

	Env.AddOrSetValue(Name, Data);

	if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Var setted ["$'+Name+'"="' + Data.GetValue + '"]', 5);
    if (Assigned(Parent.OnVarSet)) then Parent.DoVarSet(PID, '$' + Name, Data.GetValue, GetCurrentLineName(False));
end;

procedure TFlow.UnsetEnv(const Name:string);
var
	K:string;
begin
 	if (Env.ContainsKey(Name)) then begin
        if (Env[Name].GVarType = 3) then begin
        	for K in Env[Name].GetArray.Keys do UnsetEnv(Name+'['+K+']');
        end;

    	Env[Name].Free;
        Env.Remove(Name);
        if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Var unsetted ["$'+Name+'"]', 6);
    end;
end;

procedure TFlow.ArrayAssociate(const C:Char; const Line:string);
var
	I:Integer;
	Current, Next:string;
    NextLC:string;
	Elements:TDictionary<Integer, String>;
begin
	if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Array ARRAS: ["' + C + Line + '"]', 5);

    Elements := Parent.SplitOut(Line, ['['], True, True, True);
    if (Elements.Count = 0) then begin
        Elements.Free;
        Exit;
    end;

    for I := 0 to Elements.Count-2 do begin
    	if (I = 0) then
        	Current := LowerCase(Elements[I])
        else Current := Current + '[' + NextLC + ']';


        if (I + 1 <= Elements.Count-1) then	Next := Elements[I+1].Substring(0, Elements[I+1].Length-1);
        NextLC := LowerCase(Next);

        SolveVar(C, Current).SetArray(Next, SolveVar(C, Current + '[' + NextLC + ']').clone);
    end;

    Elements.Free;
end;

procedure TFlow.ArrayExpand(const C:Char; Name:string);
var
	K,KLC:String;
	GVar:TGVar;
begin
    //Expandimos el array
    	Name := LowerCase(Name);
		GVar := SolveVar(C, Name);
        if (GVar = nil) then Exit;

    	if (GVar.GVarType = 3) then begin
        	if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Array AREXP: ["' + C + Name + '"]', 5);

        	for K in GVar.ArrayKeys do begin
            	KLC := LowerCase(K);

                if (C = '$') then begin
                	SetEnv(Name + '[' + KLC + ']', GVar.GetArray[KLC]);
                    GVar.GetArray[KLC] := GVar.GetArray[KLC].clone; //TGVar.Create
                end else if (C = '@') then begin
                    Parent.SetEnv(Name + '[' + KLC + ']', GVar.GetArray[KLC]);
                    GVar.GetArray[KLC] := GVar.GetArray[KLC].clone;  //TGVar.Create
                end;

                if (GVar.GetArray[KLC].GVarType = 3) then ArrayExpand(C, Name + '[' + KLC + ']');
            end;


        end;
end;

procedure TFlow.ArrayContract(const C:Char; const Name:string);
var
	K,KLC:String;
	GVar:TGVar;
begin
    //Expandimos el array
		GVar := SolveVar(C, Name);
        if (GVar = nil) then Exit;

        if (GVar.GVarType = 3) then begin
        	if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Array ARCOP: ["' + C + Name + '"]', 5);

            if (not GVar.ObjectOwner) then GVar.ArrayMitosis(False);

        	for K in GVar.ArrayKeys do begin
            	KLC := LowerCase(K);

                if (GVar.GetArray[KLC].GVarType = 3) then ArrayContract(C, Name + '[' + KLC + ']');

                if (C = '$') then begin
                	GVar.GetArray[KLC].Free;
                    GVar.GetArray[KLC] := SolveVar(C, Name + '[' + KLC + ']');
                    Env[Name + '[' + KLC + ']'] := TGVar.Create;
                end else if (C = '@') then begin
                  	GVar.GetArray[KLC].Free;
                    GVar.GetArray[KLC] := SolveVar(C, Name + '[' + KLC + ']');
                    Parent.Env[Name + '[' + KLC + ']'] := TGVar.Create;
                end;

            end;
        end;
end;

function TFlow.ArrayGetNext(const C:String; const Name:String): Integer;
var
	GArray:TDictionary<String, TGVar>;
begin
	Result := -1;
	if (C = '$') then begin
		if (Env.ContainsKey(Name)) and (Env[Name].GVarType = 3) then
        	GArray := Env[Name].GetArray else Exit;
    end else if (C = '@') then begin
		if (Parent.Env.ContainsKey(Name)) and (Parent.Env[Name].GVarType = 3) then
        	GArray := Parent.Env[Name].GetArray else Exit;
    end;

    Result := 0;
    while (GArray.ContainsKey(IntToStr(Result))) do Result := Result + 1;
end;

function TFlow.ArrayGetLast(const C:String; const Name:String): Integer;
var
	GArray:TDictionary<String, TGVar>;
begin
	Result := -1;
	if (C = '$') then begin
		if (Env.ContainsKey(Name)) and (Env[Name].GVarType = 3) then
        	GArray := Env[Name].GetArray else Exit;
    end else if (C = '@') then begin
		if (Parent.Env.ContainsKey(Name)) and (Parent.Env[Name].GVarType = 3) then
        	GArray := Parent.Env[Name].GetArray else Exit;
    end;

    Result := 0;
    while (GArray.ContainsKey(IntToStr(Result))) do Result := Result + 1;
    Result := Result - 1;
end;

procedure TFlow.SolveLine(const Line:String);
var
	C, J:Char;
    I:Integer;
    Elements:TDictionary<Integer, String>;
    Name, Element, Extra, Last, Params:String;
    L, PosSplitter:integer;
    GVar:TGVar;
    SubFlow:TFlow;
begin
	//Interpretamos una linea
    	if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Line LSLVE: ["' + Parent.LineFormat(Line) + '"]', 5);
        if (StopThread) then begin
            Pos := PosMax;
            Exit;
        end;

        
    	L := Line.Length;
    	C := Line.Chars[0];

        //VARIABLE
        if ((C = '@') or (C = '$') or (C = '%')) then begin
        	//VARIABLE: SET
                if (L < 4) then begin
                    Pos := Pos + 1;
                    Exit;
                end;
                PosSplitter := Parent.IndexOfOut(Line, ['='], True, True, True);
                if (PosSplitter > 0) then begin

                    Name := Line.Substring(1, PosSplitter-1);
                    Params := Line.Substring(PosSplitter+1, L - PosSplitter-2);


                    J := Name.Chars[Name.Length-1];
                    if ((J = '.') or (J = '+') or (J = '-') or (J = '*') or (J = '/')) then begin
                    	//Shorcut set
                        if (C = '%') then begin
                            if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Warning: Line Ignored. Reason: Invalid command for Const [' + Parent.LineFormat(Line) + ']', 2);
                            Pos := Pos + 1;
                            Exit;
                        end;

                    	Name := Name.Substring(0, Name.Length-1);
                        if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Line VARCRP: ["' + Name + '"/"' + Params + '"]', 6);

					  	SolveLine(C + Name + '=' + C + Name + J + '(' + Params + ');');
                      	Exit;
                    end;



                    //VARIABLE: OBJ SET
                   {     PosSplitter := Parent.IndexOfOut(Name, '::', True, True, True);
                        if (PosSplitter > 0) then begin

                        end;    }

        
                    if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Line VASET: ["' + Name + '"//"' + Params + '"]', 6);

                    //SI ES UN ARRAY RESOLVEMOS EL NOMBRE
                        PosSplitter := Parent.IndexOfOut(Name, ['['], True, True, True);
                        if (PosSplitter > 0) then begin
                            Name := SolveArrayName(C, Name, True);
                        end else begin
                            J := Name.Chars[0];
                            if ((J = '$') or (J = '@') or (J = '%') or (J = '(')) then Name := LowerCase(SolvePart(Name, True).GetValue);
                        end;

                    //Y ahora hacemos el set de la data
                        GVar := SolvePart(Params);
                        GVar.ObjectGive := false;

                        if (C = '$') then begin
                        	if (GVar.GVarType = 3) then GVar.ArrayMitosis(True);
                            SetEnv(LowerCase(Name), GVar);
                            if (PosSplitter > 0) then ArrayAssociate(C, Name);
                            if (GVar.GVarType = 3) then ArrayExpand(C, Name);
                        end else if (C = '@') then begin
                        	if (GVar.GVarType = 3) then GVar.ArrayMitosis(True);
                        	Parent.SetEnv(LowerCase(Name), GVar);
                            if (PosSplitter > 0) then ArrayAssociate(C, Name);
                            if (GVar.GVarType = 3) then ArrayExpand(C, Name);
                        end else if (C = '%') then begin         
                        	if (not Parent.Con.ContainsKey(LowerCase(Name))) then begin
                            	Parent.SetCon(LowerCase(Name), GVar.GetValue());
                                GVar.Free;
                            end else begin
                            	if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Cannot assign a previously defined constant', 6);
                                GVar.Free;
                            end;
                        end;

                    //End del set
                        Pos := Pos + 1;
                        exit;
                end;

        	//VARIABLE: OBJ RUN
                PosSplitter := Parent.IndexOfOut(Line, '::', True, True, True);
                if (PosSplitter > 0) then begin

                	if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Line VAOBR: ["' + Line + '"]', 6);

                    Pos := Pos + 1;
                    exit;
                end;

        	//VARIABLE: ShortCut
            	Params := Line.Substring(L - 3, 2);
                if ((Params = '--') or (Params = '++')) then begin
                    Name := Line.Substring(1, PosSplitter-1);
                	if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Line VASHC: ["' + Name + '"/"' + Params + '"]', 6);

                    Name := Line.substring(1, L - 4);

                    SolveLine(C + Name + '=' + C + Name + Params.Chars[0] + '1;');
                    Exit;
                end;
        end;

        
        //END BLOCK
        if (C = '}')  then begin
            if (Line = '}') then begin
	            Pos := Pos + 1;
	            Exit;
            end else begin
            	Extra := Line.Substring(1);

				if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Block command BLCLR: ["' + Extra + '"]', 6);
                Script[Pos] := '}';
                Pos := StrToInt(Extra);
                Exit;
            end;
        end;

        //START BLOCK
        if (Line.Chars[L-1] = '{') then begin
			if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Line SBLCK: ["' + Line + '"]', 6);

            if ((C = 'i') and (Line.Chars[1] = 'f')) then begin
                //If
                	Extra := Line.Substring(2, L-2-1);
                    if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Block BLOIF: ["' + Extra + '"]', 6);

                    if (not SolvePart(Extra, True).GetBool) then begin
						if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'IF BIFNO', 6);
                        Pos := FindClaspClose(Pos, True);
                        Exit;
                    end else begin
                    	if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'IF BIFYE', 6);
                        Pos := Pos + 1;
                        Exit;
                    end;

            end else if ((C = 'e') and (L > 7) and (Line.Substring(0, 6) = 'elseif')) then begin
                //ElseIf
                    if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Block ELIFG', 6);
                    Pos := FindClaspClose(Pos, False);
                    Exit;

            end else if ((C = 'e') and (L = 5) and (Line.Substring(0, 5) = 'else{')) then begin
                //Else
                    if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Block ELSIG', 6);
                    Pos := FindClaspClose(Pos, False);
                    Exit;

            end else if ((C = 'w') and (L > 6) and (Line.Substring(0, 5) = 'while')) then begin
                //While
					PosSplitter := FindClaspClose(Pos, False);
                	Extra := Line.Substring(5, L-5-1);

                    if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Block BLOWH: ["' + Extra + '"]', 6);

                    if (not SolvePart(Extra, True).GetBool) then begin
						if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'While BWHNO', 6);
                        Pos := PosSplitter;
                        Script[Pos] := '}';
                        Exit;
                    end else begin
                    	if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'While BWHYE', 6);
                        Script[PosSplitter] := '}' + IntToStr(Pos);
                        Pos := Pos + 1;
                        Exit;
                    end;

            end else if ((C = 'f') and (L > 5) and (Line.Substring(0, 4) = 'for(')) then begin
                //For
                	Extra := Line.Substring(4);
                    Extra := Extra.Substring(0, Parent.IndexOfOut(Extra, [')'], True, True, True));
                    Last := Line.Substring(Extra.Length+5);
                	Last := Last.Substring(0, Last.Length-1);

                    Elements := Parent.SplitOut(Extra, [','], True, True, True);

                    if (Elements.Count <> 3) then begin
                        if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Block ignored. Reason: Inavlid for sentence [' + Parent.LineFormat(Line) + ']', 1);
                    	Pos := FindClaspClose(Pos);
                    	Elements.Free;
                        Exit;
                    end;

                    I := Pos;
                    if (Last <> '*') then begin
                    	if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Block FORFI: ["' + Elements[0] + '"]', 6);
                        Script[Pos] := 'for('+Extra+')*{';
                        SolveLine(Elements[0]+';');
                        Pos := I;
                    end else begin
                    	if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Block FORIT: ["' + Elements[2] + '"]', 6);
                        SolveLine(Elements[2]+';');
                        Pos := I;
                    end;

                    if (not SolvePart(Elements[1], True).GetBool) then begin
                    	if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Block FORNO: ["' + Elements[1] + '"]', 6);
                        Script[Pos] := 'for('+Extra+'){';
                    	Pos := FindClaspClose(Pos);
                        Script[Pos] := '}';

                    end else begin
                    	if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Block FORYE: ["' + Elements[1] + '"]', 6);
                        Script[FindClaspClose(Pos)] := '}'+inttostr(Pos);
                        Pos := Pos + 1;
                    end;
                    Elements.Free;
                    Exit;


            end else if ((C = 'f') and (L > 9) and (Line.Substring(0, 8) = 'foreach(')) then begin
                //Foreach
                	Extra := Line.Substring(8);
                    Extra := Extra.Substring(0, Parent.IndexOfOut(Extra, [')'], True, True, True));
                    Last := Line.Substring(Extra.Length+9);
                	Last := Last.Substring(0, Last.Length-1);
                    Elements := Parent.SplitOut(Extra, [','], True, True, True);

                    if (Elements.Count <> 2)  then begin
                        if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Block ignored. Reason: Inavlid foreach sentence [' + Parent.LineFormat(Line) + ']', 1);
                    	Pos := FindClaspClose(Pos);
                    	Elements.Free;
                        Exit;
                    end;

                    GVar := SolvePart(Elements[0]);
                    if (GVar.GVarType <> 3) then begin
                        if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Block ignored. Reason: Assigned element is not an array [' + Parent.LineFormat(Line) + ']', 1);
                    	Pos := FindClaspClose(Pos);
                    	Elements.Free;
                        GVar.Free;
                        Exit;
                    end;

                    if (Last <> '') then
                    	I := StrToInt(Last) + 1
                    else I := 0;
                    Script[Pos] := 'foreach('+Extra+')'+IntToStr(I)+'{';

                    if (I >= GVar.ArrayKeys.Count) then begin
                    	Script[Pos] := 'foreach('+Extra+')'+'{';
                        Pos := FindClaspClose(Pos);
                        Script[Pos] := '}';

                        if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Block FOREN: ["' + Elements[0] + '"]', 6);

                    end else begin
                        Script[FindClaspClose(Pos)] := '}'+inttostr(Pos);
                       // Pos := Pos + 1;

                        if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Block FOREY: ["' + Elements[1] + '"]', 6);

                        PosSplitter := Parent.IndexOfOut(Elements[1], ':', True, True, True);
                        Extra := Elements[1].Substring(PosSplitter + 1);
                        Name := '';
                        if (PosSplitter > 0) then Name := Elements[1].Substring(0, PosSplitter);

                        //Name
                        if (Name <> '') then begin

                            C := Name.Chars[0];
                            Name := Name.Substring(1);
                            J := Name.Chars[0];
                            if ((J = '$') or (J = '@') or (J = '%') or (J = '(')) then Name := LowerCase(SolvePart(Name, True).GetValue);

                            if (C = '$') then
                                SetEnv(Name, TGVar.Create(GVar.ArrayKeys[I]))
                            else if (C = '@') then Parent.SetEnv(Extra, TGVar.Create(GVar.ArrayKeys[I]))
                            else if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Ignored foreach name assign. Reason: Cannot assing to another element diferent to var or global: ["' + Elements[0] + '"]', 6);
                        end;

                        //Value (EN el solve pOS + 1)
                        C := Extra.Chars[0];
                        Extra := Extra.Substring(1);

                         if ((C = '$') or (C = '@')) then begin
                         	SolveLine(C+Extra+'='+Elements[0]+'['''+GVar.ArrayKeys[I]+'''];');

                         end else begin
                         	Pos := Pos + 1;
                         	if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Ignored foreach value assign. Reason: Cannot assing to another element diferent to var or global: ["' + Elements[0] + '"]', 6);
                         end;
                	end;

                    GVar.Free;
                    Elements.Free;
                    Exit;

            end else if ((C = 't') and (L > 6) and (Line.Substring(0, 6) = 'thread')) then begin
                //Thread
                	Parent.ThreadLock_ThreadAdd.Acquire;

					PosSplitter := FindClaspClose(Pos, False);
                    Extra := SectionName+':'+'thread['+inttostr(Pos)+']';


                    Params := '';
                    Element := '';

                    I := Parent.IndexOfOut(Line, ':', True, True, True);
                    if (I >= 0) then begin
                    		Element := line.Substring(6, I-6);
                    end else begin
                    	I := 5;
                        if (Line.Substring(I+1,1) <> '(') then begin
                        	Element := Line.Substring(6, L-6-1);
                        end;
                    end;


                    if (Line.Substring(I+1,1) = '(') then begin
						Params := Line.Substring(I+2, L-4-I);
                    end;

                    if (Parent.Script.ContainsKey(Extra)) then begin
                    	Parent.Script[Extra].Free;
                        Parent.Script.Remove(Extra);
                    end;

                    if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Thread THREX ["'+Extra+'"/"'+Params+'"]', 6);

                    L := 0;
                    Elements := TDictionary<Integer, String>.create;
                    for I := Pos + 1 to PosSplitter - 1 do begin
                    	Elements.Add(L, Script[I]);
                        L := L + 1;
                    end;
                    Parent.Script.Add(Extra, Elements);


                    if (Parent.ScriptLinesName.ContainsKey(Extra)) then begin
                    	Parent.ScriptLinesName[Extra].Free;
                        Parent.ScriptLinesName.Remove(Extra);
                    end;
                    L := 0;
                    Elements := TDictionary<Integer, String>.create;
                    for I := Pos + 1 to PosSplitter - 1 do begin
                    	Elements.Add(L, ScriptLinesName[I]);
                        L := L + 1;
                    end;
                    Parent.ScriptLinesName.Add(Extra, Elements);
                    Parent.ThreadLock_ThreadAdd.Release;

                    SubFlow := TFlow.Create(Parent, Extra, GetCurrentLineName());
                    if (Params <> '') then SubFlow.DeclareEnv(TFQF(Parent.FQF).GetParams(Params, Self, PID), True);
                    I := SubFlow.RunOnThread();

                    if (Element <> '') then
	                    SolveLine(Element+'='+IntToStr(I)+';');

                    Pos := PosSplitter;

                    Exit;

            end else begin
            	if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Warning: Line Ignored. Reason: Invalid block command [' + Parent.LineFormat(Line) + ']', 2);
                Pos := Pos + 1;
                Exit;
            end;

        end;

        //FUNCOBJ RUN
        PosSplitter := Parent.IndexOfOut(Line, '::', True, True, True);
	    if ((PosSplitter > 0) and (CharInSet(C, ['a'..'z', '#']))) then begin

        	if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Line FUOBN: ["' + Line + '"]', 6);

        	Pos := Pos + 1;
            Exit;
        end;

        //FUNC RUN
        if (CharInSet(C, ['a'..'z', '#'])) then begin
        	Element := Line.Substring(0, L-1);

            if (C = '#') then begin
            	Element := Element.Substring(2);
                PosSplitter := Parent.IndexOfOut(Element,[')'], True, True, True, True);
                Element := LowerCase(SolvePart(Element.Substring(0, PosSplitter), True).GetValue) + Element.Substring(PosSplitter + 1);
            end;

            PosSplitter := Parent.IndexOfOut(Element, ['('], True, True, True, True);
            Name := Element.substring(0, PosSplitter);
            Params := Element.substring(PosSplitter + 1, Element.Length - Name.Length - 2);

            if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Line FURUN: ["' + Name + '"//"' + Params + '"]', 6);

            C := Name.Chars[0];
            //Funciones de linea
                if ((c = 'n') and (name = 'next')) then begin
                    //NEXT
                	Pos := FindClaspBucle(Pos);
                    if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Block CNEXT: ["' + inttostr(Pos) + '"]', 6);
                    exit;

                end else if ((c = 'b') and (name = 'break')) then begin
					//BREAK
                	L := FindClaspBucle(Pos);

                    if (Script[L].Substring(0,4) = 'for(') then begin
						Extra := Script[L].Substring(4);
                        Extra := 'for(' + Extra.Substring(0, Parent.IndexOfOut(Extra, [')'], True, True, True) + 1);
                        Script[L] := Extra + '{';
                    end else if (Script[L].Substring(0,8) = 'foreach(') then begin
						Extra := Script[L].Substring(8);
                        Extra := 'foreach(' + Extra.Substring(0, Parent.IndexOfOut(Extra, [')'], True, True, True) + 1);
                        Script[L] := Extra + '{';
                    end;

                    if (L > Pos) then Pos := L
                    else begin
                    	Pos := FindClaspClose(L);
                        if (Script[Pos] <> '}') then
                        	Script[Pos] := '}';
                    end;
                    if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Block CBREA: ["' + inttostr(Pos) + '"]', 6);
                    exit;

                end else if ((c = 'e') and (name = 'exit')) then begin
					//Exit
                	if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Flow escaped', 3);
                	Pos := PosMax + 1;

                    exit;

                end else if ((c = 'u') and (name = 'unset')) then begin
                    //Object Move
                    if (Params.Length < 2) then exit;
                    C := Params.Chars[0];
                    Params := Params.Substring(1);
                    Params := SolveArrayName(C, Params);
                    if (Parent.IndexOfOut(Params, ['['], True, True, True) > 0) then begin
                    	Elements := Parent.SplitOut(Params, ['['], True, True, True);

                        if (Elements.Count > 1) then begin
                        	Extra := Elements[0];
                            for I := 1 to Elements.Count-2 do Extra := Extra + '['+ Elements[I];
                        	SolveVar(C, Extra).RemoveArray(Elements[Elements.Count-1].Substring(0, Elements[Elements.Count-1].Length-1));
                        end;

                        Elements.Free;
                    end;
                    if (C = '$') then
						UnsetEnv(Params)
                    else Parent.UnsetEnv(Params);

                    Pos := Pos + 1;
                    Exit;
                end;

            //Funciones FQF
            	TFQF(Parent.FQF).Run(Name, Params, Self).Free;
            
        	Pos := Pos + 1;
            Exit;
        end;


        //OtherShit
        	if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Line ignored. Reason: Invalid command [' + Parent.LineFormat(Line) + ']', 1);
            Pos := Pos + 1;
            Exit;
end;

function TFlow.SolvePart(const Line:String; const SelfClear:Boolean = False): TGVar;
var
    I,O:Integer;
    Elements: TDictionary<Integer, String>;
    Operations: TDictionary<Integer, TArray<String>>;
    HaveOp:Boolean;
    TempValue:String;
    OperatorsSplitter:array[0..3] of string;
begin
	//Resultamos default
		if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Part PSLVE: ["' + Parent.LineFormat(Line) + '"]', 6);

        //Miramos si solo es una parte
    	Elements := Parent.SplitOut(Line, ['.'], True, True, True);
        if (Elements.count = 0) then begin
			if (Parent.IndexOfOut(Line, ['*', '/', '+', '-'], True, True, True) < 0) then
        		Result := SolveData(Line, SelfClear)
        	else Elements.Add(0, Line);
        end;

        //Y ahora, si son más de una
        if (Elements.count > 0) then begin
        	Result := TGVar.Create('', SelfClear);
            HaveOp := False;
            OperatorsSplitter[0] := '*';
            OperatorsSplitter[1] := '/';
            OperatorsSplitter[2] := '+';
            OperatorsSplitter[3] := '-';

            for I := 0 to Elements.count-1 do begin
            	Operations := Parent.SplitOut(OperatorsSplitter, Elements[I], True, True, True, True);
                if (Operations.Count > 1) then HaveOp := True;
                TempValue := '';
                for O := 0 to Operations.Count-1 do begin
                	TempValue := TempValue + SolvePart(Operations[O][0], True).GetValue + Operations[O][1];
                end;
                if (HaveOp) then TempValue := SolveOperation(TempValue);

                Result.SetValue(Result.GetValue(True) + TempValue);
                Operations.free;
                HaveOp := False;
            end;

        end;


        //Y end
	        Elements.Free;

end;

function TFlow.SolveData(const Line:String; const SelfClear:Boolean = False): TGVar;
var
	L, I, PosSplitter:Integer;
	C:Char;
    GVar:TGVar;
    List:TStringList;
    Name, Element, Params:String;
begin
	//Resultamos la data
    	if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Data DSLVE: ["' + Parent.LineFormat(Line) + '"]', 6);

    Result := TGVar.Create('', SelfClear);

	L := Line.Length;
    if (L < 1) then exit;
    C := Line.Chars[0];

    //TERNARIO
    PosSplitter := Parent.IndexOfOut(Line, ['?'], True, True, True);
    if (PosSplitter >= 0) then begin
    	if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Data BCOMP: ["' + Line + '"]', 6);

    	Name := Line.Substring(0, PosSplitter);
        I := Parent.IndexOfOut(ReverseString(Line), [':'], True, True, True);

        I := Line.Length - (I + 1);

        if (I >= 0) then begin
	        Element := Line.Substring(PosSplitter + 1, I - PosSplitter - 1);
            Params := Line.Substring(I+1);
        end else begin
           if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Error: Binary without false value', 1);
           Pos := Pos + 1;
           Exit;
        end;

        if (SolvePart(Name, True).GetBool) then begin
        	Result.Free;
            Result := SolvePart(Element, SelfClear);
        end else if (Params <> '') then begin
        	Result.Free;
            Result := SolvePart(Params, SelfClear);
    	end;

    	//Result.SetValue(SolveComparation(Line));

        Exit;
    end;

    //COMPARACIÓN
    if (Parent.IndexOfOut(Line, ['=', '!', '>', '<', '&', '|'], True, True, True) >= 0) then begin
    	if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Data DCOMP: ["' + Line + '"]', 6);
    	Result.SetValue(SolveComparation(Line));

        Exit;
    end;

    //VARIABLE
    if ((C = '$') or (C = '@') or (C = '%')) then begin
    	if (L < 2) then exit;

        //VARIABLE: OBJ RUN
        	PosSplitter := Parent.IndexOfOut(Line, '::', True, True, True);
            if (PosSplitter > 0) then begin

            if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Data DVFOE: ["' + Line + '"]', 6);

                Exit;
            end;

    	Name := Line.Substring(1);

        PosSplitter := Parent.IndexOfOut(Name, ['['], True, True, True);
        if (PosSplitter > 0) then Name := SolveArrayName(C, Name);      

        if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Data DVVAL: ["' + Name + '"]', 6);

		if (C = '$') and (Env.ContainsKey(Name)) then
        	Result.Assign(Env[Name])
        else if (C = '@') and (Parent.Env.ContainsKey(Name)) then
        	Result.Assign(Parent.Env[Name])
        else if (C = '%') and (Parent.Con.ContainsKey(Name)) then
        	Result.Assign(Parent.Con[Name])
        else if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Acces to undefined variable, global or const [' + C + Name + ']', 3); 
    end;

    //STRING
    if (C = '''') then begin
    	if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Data DSTRV: ["' + Line.Substring(1, L - 2) + '"]', 6);
        
		Result.SetValue(Line.Substring(1, L - 2));
        Exit;
    end;

    //FUNCOBJ RUN
    PosSplitter := Parent.IndexOfOut(Line, '::', True, True, True);
    if ((PosSplitter > 0) and (CharInSet(C, ['a'..'z', '#']))) then begin
    
    	if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Data DFOBN: ["' + Line + '"]', 6);

        Exit;
    end;

    //FUNC RUN
    if (CharInSet(C, ['a'..'z', '#'])) then begin
    	Element := Line;

        if (C = '#') then begin
        	Element := Element.Substring(2);
            PosSplitter := Parent.IndexOfOut(Element,[')'], True, True, True, True);
            Element := LowerCase(SolvePart(Element.Substring(0, PosSplitter), True).GetValue) + Element.Substring(PosSplitter + 1);
        end;

        PosSplitter := Parent.IndexOfOut(Element, ['('], True, True, True, True);
        Name := Element.substring(0, PosSplitter);
        Params := Element.substring(PosSplitter + 1, Element.Length - Name.Length -2);

        if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Data DFRUV: ["' + Name + '"//"' + Params + '"]', 6);            

        C := Name.Chars[0];
        //Funciones de VALOR interceptadas
        	if ((c = 't') and (name = 'true')) then begin
            	//TRUE
                Result.SetValue(True);
                Exit;

        	end else if ((c = 'f') and (name = 'false')) then begin
            	//FALSE
                Result.SetValue(False);
                Exit;

        	end else if ((c = 'n') and (name = 'null')) then begin
            	//NULL
                Result.SetNil;
                Exit;

            end else if ((c = 'a') and (name = 'array')) then begin
            	//Array Define
                if (Params.Length <= 0) then begin
                	Result.Free;
                    Result := TGVar.CreateAsArray(SelfClear);
                    Exit;
                end;

            	List := TStringList.Create;
                Result.free;

                Result := TGVar.CreateAsArray(TFQF(Parent.FQF).GetParamsVariable(Params, List, Self, Pid), List, SelfClear);
                List.Free;
                 Exit;

            end else if ((c = 'i') and (name = 'isset')) then begin
            	//ISSET
                if (Params.Length < 2) then exit;
                C := Params.Chars[0];
                Params := Params.Substring(1);
                Params := SolveArrayName(C, Params);
            	if (SolveVar(C, Params, True) = nil) then
                	Result.SetValue('0')
                else Result.SetValue('1');
				Exit;

            end else if ((c = 'm') and (name = 'move')) then begin
                //MOVE
                if (Params.Length < 2) then exit;
                C := Params.Chars[0];
                Params := Params.Substring(1);
                Params := SolveArrayName(C, Params);
                GVar := SolveVar(C, Params);
                if (GVar = nil) then exit;
                if ((GVar.GVarType <> 2) or (not GVar.ObjectOwner)) then begin
                	Result.Assign(GVar);
                	if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Warning: Cannot move var or global without object owner content [' + C + Name + ']', 3);
                    Exit;
        		end;

                GVar.ObjectGive := True;
                Result.Assign(GVar);
				Exit;
            end;


        //Funciones FQF
        	Result.Free;
        	Result := TFQF(Parent.FQF).Run(Name, Params, Self);
            Result.FreeOnGet := SelfClear;
            Result.ObjectGive := True;

            Exit;
    end;

    //PARENTESIS
    if (C = '(') then begin
    	Result.Free;
        if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Data DPARE: ["' + Line.Substring(1, Line.Length-2) + '"]', 6);
        Result := SolvePart(Line.Substring(1, Line.Length-2), SelfClear);

        Exit;
    end;

    //NUMERICO
	if (Parent.OnlyChars(Line, ['0'..'9', '/', '*', '+', '-', '(', ')', ',', '.'])) then begin
    	if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Data DNUME: ["' + StringReplace(Line, '.', '', [rfReplaceAll]) + '"]', 6);
    	Result.SetValue(StringReplace(Line, '.', '', [rfReplaceAll]));

        Exit;
    end;
end;

function TFlow.SolveVar(const C:Char; const Name:String; const PreventNotification:Boolean = False): TGVar;
begin
	if (C = '$') and (Env.ContainsKey(Name)) then
      	Result := Env[Name]
    else if (C = '@') and (Parent.Env.ContainsKey(Name)) then
    	Result := Parent.Env[Name]
    else if (C = '%') and (Parent.Con.ContainsKey(Name)) then
    	Result := Parent.Con[Name]
    else begin
    	Result := nil;
		if (not PreventNotification) then
    		if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Acces to undefined variable, global or const [' + C + Name + ']', 3);
    end;
end;


function TFlow.SolveArrayName(const C:Char; const Line:String; const ForSet: Boolean = False): String;
var
	J:Char;
	I:Integer;
	ResultNC, Last, Item:string;
	Elements:TDictionary<Integer, String>;
begin

	if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Concrete ANSLV: ["' + Parent.LineFormat(Line) + '"]', 5);

    if ((C <> '$') and (C <> '@')) then begin
    	Result := Line;
	    Exit;
    end;

    Elements := Parent.SplitOut(Line, ['['], True, True, True);
    if (Elements.Count = 0) then begin
        Result := Line;
        Elements.Free;
        Exit;
    end;

    for I := 0 to Elements.Count-2 do begin        
    	Item := Elements[I];

		if (I = 0) then begin
			J := Item.Chars[0];
        	if ((J = '$') or (J = '@') or (J = '%') or (J = '(')) then Item := LowerCase(SolvePart(Item, True).GetValue);
		end else begin
        	Item := Item.Substring(0, Item.Length-1);
            if (Item = '') then begin
            	if (ForSet) then
            		Item := IntToStr(ArrayGetNext(C, Result))
                else Item := IntToStr(ArrayGetLast(C, Result));
            end else Item := SolvePart(Item, True).GetValue;
        end;

        if (I = 0) then begin
			Result := Item;
            if (ForSet) then ResultNC := Item;
		end else begin
        	Result := Result + '[' + LowerCase(Item) + ']';
            if (ForSet) then ResultNC := ResultNC + '[' + Item + ']';
        end;

        if (ForSet) then begin
			if (C = '$') then begin
            	if ((not Env.ContainsKey(Result)) or (Env[Result].GVarType <> 3)) then begin
					SetEnv(Result, TGVar.CreateAsArray);
                end;
                
            end else if (C = '@') then begin
            	if ((not Parent.Env.ContainsKey(Result)) or (Parent.Env[Result].GVarType <> 3)) then begin
					Parent.SetEnv(Result,  TGVar.CreateAsArray());   
                end;
                
            end;
        end;
    end;

	if (Elements.Count > 1) then begin
        Item := Elements[Elements.Count-1];

        Item := Item.Substring(0, Item.Length-1);
        if (Item = '') then begin
        	if (ForSet) then
            	Item := IntToStr(ArrayGetNext(C, Result))
            else Item := IntToStr(ArrayGetLast(C, Result));
        end else Item := SolvePart(Item, True).GetValue;

        Result := Result + '[' + LowerCase(Item) + ']';
		if (ForSet) then ResultNC := ResultNC + '[' + Item + ']';
    end;

    if (ForSet) then Result := ResultNC;
    

    Elements.Free;
end;

function TFLow.SolveComparation(const Line:String):Boolean;
var
    I:Integer;
    Current:Boolean;
    Elements, SubElements: TDictionary<Integer, TArray<String>>;
    CondSplitter:array[0..1] of string;
    CompSplitter:array[0..5] of string;
    NegateThis:Boolean;
begin
	//Separamos las partes por comparaciones
    	CondSplitter[0] := '&&';
        CondSplitter[1] := '||';

    	CompSplitter[0] := '==';
        CompSplitter[1] := '!=';
        CompSplitter[2] := '>=';
        CompSplitter[3] := '<=';
        CompSplitter[4] := '>';
        CompSplitter[5] := '<';

		Elements := Parent.SplitOut(CondSplitter, Line, True, True, True, True);

        Result := False;
        try
        for I := 0 to Elements.count-1 do begin
            if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Comapare CMPSO ["' + Elements[I][0] + '"]', 5);

            if (Elements[I][0].chars[0] = '!') then begin
            	Elements[I][0] := Elements[I][0].substring(1);
                NegateThis := True;
            end else NegateThis := false;

            SubElements := Parent.SplitOut(CompSplitter, Elements[I][0], True, True, True);
            try
                if (SubElements.Count = 2) then begin
                	if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Comapare CMPOP ["' + SubElements[0][0] + '"/"' + SubElements[0][1] + '"/"' + SubElements[1][0] + '"]', 6);
					if (SubElements[0][1] = '==') then begin
                    	if (SolvePart(SubElements[0][0], True).GetValue = SolvePart(SubElements[1][0], True).GetValue) then
                        	Current := True else Current := False;

					end else if (SubElements[0][1] = '!=') then begin
                    	if (SolvePart(SubElements[0][0], True).GetValue <> SolvePart(SubElements[1][0], True).GetValue) then
                        	Current := True else Current := False;

					end else if (SubElements[0][1] = '>=') then begin
                    	if (SolvePart(SubElements[0][0], True).GetNumeric >= SolvePart(SubElements[1][0], True).GetNumeric) then
                        	Current := True else Current := False;

					end else if (SubElements[0][1] = '<=') then begin
                    	if (SolvePart(SubElements[0][0], True).GetNumeric <= SolvePart(SubElements[1][0], True).GetNumeric) then
                        	Current := True else Current := False;

					end else if (SubElements[0][1] = '>') then begin
                    	if (SolvePart(SubElements[0][0], True).GetNumeric > SolvePart(SubElements[1][0], True).GetNumeric) then
                        	Current := True else Current := False;

                    end else if (SubElements[0][1] = '<') then begin
                    	if (SolvePart(SubElements[0][0], True).GetNumeric < SolvePart(SubElements[1][0], True).GetNumeric) then
                        	Current := True else Current := False;

                    end else Current := False;

                end else if (SubElements.Count = 0) then begin
                	Current := SolvePart(Elements[I][0], True).GetBool;

                end else begin
                	if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Warning: Ignored comparison. Reason: Multiple comparators without operator ["' + Line + '"]', 2);
                    Exit;
                end;

                if NegateThis then Current := not Current;

                if (not Current) and (Elements[I][1] = '&&') then begin
                	Result := False;

                    Exit;
                end;

                if (Current) and ((Elements[I][1] = '||') or (Elements[I][1] = '')) then begin
                	Result := True;

                    Exit;
                end;

            finally

	            SubElements.Free;
            end;
        end;

    	finally Elements.Free; end;
end;

function TFLow.SolveOperation(Line:String):String;
	function GetLeftVal(var Line:String; const OpPos: integer; const Charset: TSysCharSet = ['.','*', '/', '+', '-']) : string;
    var
    	I:Integer;
    begin
      Result := ReverseString(Line.Substring(0, OpPos));
      I := Parent.IndexOfOut(Result, Charset, True, False, False, True);

      if (Result.length > I) and (Result.Chars[I] = '-') then I  := I + 1;

      Result := ReverseString(Result.Substring(0, I));
    end;
	function GetRightVal(const Line:String; const OpPos: integer; const Charset: TSysCharSet = ['.','*', '/', '+', '-']) : string;
    var
    	Positive:string;
    begin
    	Positive := '';
    	Result := Line.Substring(OpPos + 1);
        if (Result.Length > 0) and ((Result.Chars[0] = '-') or (Result.Chars[0] = '+')) then begin
        	Positive := Result.Chars[0];
            Result := Result.Substring(1);
        end;
        Result := Positive + Result.Substring(0, Parent.IndexOfOut(Result, Charset, True, False, False, True));
    end;
    procedure SolveNegative(var Line:string; var IsNegative:Boolean);
    begin
    	if ((Line.Length > 0) and (Line.Chars[0] = '-')) then begin
    		Line := Line.Substring(1);
            IsNegative := true;
        end else IsNegative := false;
    end;
    procedure RestoreNegative(var Line:string; var OpPos:Integer; var IsNegative:Boolean);
    begin
    	if (IsNegative) then begin
    		Line := '-' + Line;
            if (OpPos > -1) then
				OpPos := OpPos + 1;
            IsNegative := false;
        end;
    end;
    function GrantNumeric(const Line:string):string;
    var
        Val:string;
        I:Integer;
        Negative:Boolean;
        HasError:Boolean;
    begin
    	try
            Result := '0';
           	HasError := False;
        	if (Line = '') then exit;

            Val := Line;
            Negative := False;


            if (Val.Chars[0] = '-') then begin
                Negative := True;
                Val := Val.Substring(1);
                if (Val = '') then begin HasError := True; exit; end;
            end;

            I := Val.IndexOf(',');
            if (Val.IndexOf(',', I+1) >= 0) then begin HasError := True; exit; end;
            if (not Parent.OnlyChars(Val, ['0'..'9', ','])) then begin HasError := True; exit; end;

            Result := Val;

            if (Negative) then Result := '-' + Result;
        finally
			if (HasError) then
            	if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Warning: Invalid data for math operator. Changed by zero ["'+Line+'"]', 2);
        end;
    end;
var
	Op:char;
	K,F,Q:Integer;
    A,B,C,D: String;
    V: Variant;
    IsNegative:Boolean;
    Operators:string;
    Charset:TSysCharset;
	Parts:TDictionary<Integer, TDictionary<Integer, String>>;
begin
	Operators := '*/+-';
    K := 0;
    IsNegative := False;
    if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Math SMATH: ["'+Line+'"]', 5);
    while (K < Operators.Length) do begin
    	if (Operators.Chars[K] = '-') then Charset := ['.', '*', '/', '+', '-'];

        if (Op = '-') then SolveNegative(Line, IsNegative);
        Op := Operators.Chars[K];
        F := Parent.IndexOfOut(Line, [Op], False, False, False);
        if (Op = '*') then begin
        	Q := Parent.IndexOfOut(Line, ['/'], False, False, False);
            if (Q > -1) and (Q < F) then begin F := Q; Op := '/'; end;
        end;
        if (Op = '-') then RestoreNegative(Line, F, IsNegative);

        while (F > -1) do begin
			A := GrantNumeric(GetLeftVal(Line, F));
            C := GrantNumeric(GetRightVal(Line, F));

            D := Line.substring(F + C.Length+1);
            if ((Op = '*') or (Op = '/'))
            	and ((d.Length > 0) and ((d.Chars[0] = '*') or (d.Chars[0] = '/')))
                and ((a.Length > 0) and (a.Chars[0] = '-'))  then begin
                A := a.Substring(1);
            end;

            if (C = '-') then begin
            	Line := Line.substring(0, F - A.Length) + A + Op + '-1*' + Line.substring(F + C.Length+1);
            	K := -1;
                F := -1;
                continue;
            end;

            if ((A = '') or (C = '')) then begin K := 10; break; end;

            try
            	if (Op = '+') then
                	B := FloatToStr(StrToFloat(A) + StrToFloat(C))
                else if (Op = '-') then
                	B := FloatToStr(StrToFloat(A) - StrToFloat(C))
                else if (Op = '*') then
                	B := FloatToStr(StrToFloat(A) * StrToFloat(C))
                else if (Op = '/') then
                	B := FloatToStr(StrToFloat(A) / StrToFloat(C));
            except
            	B := '';
            end;

            D := Line.substring(0, F - A.Length);
            if ((D.Length > 0) and (b.Length > 0) and (b.Chars[0] <> '-') and ((d.Chars[d.Length-1] <> '+') and (d.Chars[d.Length-1] <> '-') and (d.Chars[d.Length-1] <> '*') and (d.Chars[d.Length-1] <> '/'))) then begin
            	D := D + '+';
            end;

            if (Assigned(Parent.OnLog)) then Parent.DoLog(GetCurrentLineName + 'Math OPSOL: ["'+A+Op+C+' = '+b+'"]', 5);

            Line := D + B + Line.substring(F + C.Length+1);

            if (Op = '-') then SolveNegative(Line, IsNegative);
            Op := Operators.Chars[K];
            F := Parent.IndexOfOut(Line, [Op], False, False, False);
            if (Op = '*') then begin
            	Q := Parent.IndexOfOut(Line, ['/'], False, False, False);
                if (Q > -1) and (Q < F) then begin F := Q; Op := '/'; end;
            end;
            if (Op = '-')  then RestoreNegative(Line, F, IsNegative);
        end;
        K := K + 1;
    end;

    Result := Line;
end;

end.
