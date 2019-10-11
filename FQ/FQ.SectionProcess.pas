unit FQ.SectionProcess;

interface

uses
	System.SysUtils, System.Classes, Generics.Collections, FQ;

type TSectionProcess = class
	public
        SectionName:String;
        SectionLines:TDictionary<Integer, String>;
        SectionLinesName:TDictionary<Integer, String>;

    	constructor Create(const FQParentPointer:Pointer; const Name: string; const ScriptData:String; const CryptKey:String = ''; const PreventReProcess:Boolean=False); overload;
        constructor Create(const FQParentPointer:Pointer; const Name: String; const ScriptData:TDictionary<Integer, String>; const PreventReProcess:Boolean=False); overload;
        constructor Create(const FQParentPointer:Pointer; const Name: String; const PreparedLines:TDictionary<Integer, String>; const PreparedLinesName:TDictionary<Integer, String>); overload;
        destructor Destroy(); override;

    private
		Parent:TFQ;
        Data:String;

    	PreValidated:Boolean;

        procedure AddToScript();
        procedure ProcessString();
        function ValidateLine(const LineName:String; const Line:String): Boolean;
        procedure ProcessFunctions();
end;

implementation


constructor TSectionProcess.Create(const FQParentPointer:Pointer; const Name: String; const ScriptData:String; const CryptKey:String = ''; const PreventReProcess:Boolean=False);
begin
	//Definimos los valores default
       	Parent := FQParentPointer;

        SectionName := LowerCase(Name);
	   	Data := ScriptData;
        if (CryptKey <> '') then Data := Parent.Crypt(CryptKey, Data);
        PreValidated := PreventReProcess;

        SectionLines := TDictionary<Integer, String>.Create;
        SectionLinesName := TDictionary<Integer, String>.Create;

    //Ahora lanzamos el proceso de limpieza
		ProcessString();
        ProcessFunctions();
        AddToScript();

        Self.Free;
end;

constructor TSectionProcess.Create(const FQParentPointer:Pointer; const Name: String; const ScriptData:TDictionary<Integer, String>; const PreventReProcess:Boolean=False);
var
	K:integer;
begin
	//Definimos los valores default
       	Parent := FQParentPointer;

        SectionName := LowerCase(Name);

        SectionLines := TDictionary<Integer, String>.Create;
        SectionLinesName := TDictionary<Integer, String>.Create;

    //Ahora lanzamos el proceso de limpieza
    	K := 0;
        if (PreventReProcess) then begin
        	while (ScriptData.ContainsKey(K)) do begin
            	SectionLines.Add(K, ScriptData[K]);
                K := K + 1;
            	SectionLinesName.Add(K,  inttostr(K));
            end;
        end else begin
        	Data := '';
        	while (ScriptData.ContainsKey(K)) do begin
            	Data := Data + ScriptData[K] + char(13);
                K := K + 1;
            end;
            ProcessString();
            ProcessFunctions();
            AddToScript();
        end;

        Self.Free;
end;

constructor TSectionProcess.Create(const FQParentPointer:Pointer; const Name: String; const PreparedLines:TDictionary<Integer, String>; const PreparedLinesName:TDictionary<Integer, String>);
var
	K:integer;
begin
	//Definimos los valores default
       	Parent := FQParentPointer;

        SectionName := LowerCase(Name);
        SectionLines := TDictionary<Integer, String>.create(PreparedLines);
        SectionLinesName := TDictionary<Integer, String>.create(PreparedLinesName);
        ProcessFunctions();
        AddToScript();

        Self.Free;
end;

destructor TSectionProcess.Destroy();
begin
	//Limpiamos los objetos utilizados por el camino
    	inherited;

		SectionLines.Free;
        SectionLinesName.Free;
end;

procedure TSectionProcess.AddToScript();
var
	Max,Setted,Count:integer;
begin
	//Añadimos la sección procesada al script
        if (Parent.Script.ContainsKey(SectionName)) then begin
			Parent.Script[SectionName].Free;
            Parent.ScriptLinesName[SectionName].Free;
        end;

        Parent.Script.AddOrSetValue(SectionName, TDictionary<Integer, String>.create());
        Parent.ScriptLinesName.AddOrSetValue(SectionName, TDictionary<Integer, String>.create());

    	Count := 0;
        Max := SectionLines.Count;
        Setted := 0;
        while (Setted < Max) do begin
        	if (SectionLines.ContainsKey(Count)) then begin
            	Parent.Script[SectionName].Add(Setted, SectionLines[Count]);
                Parent.ScriptLinesName[SectionName].Add(Setted, SectionLinesName[Count]);
                Setted := Setted+1;
            end;

            Count := Count + 1;
        end;

        if (Assigned(Parent.OnLog)) then Parent.DoLog('[FQ] Added Section ['+SectionName+' (' + IntToStr(SectionLines.Count)+')]', 0);
end;

procedure TSectionProcess.ProcessString();
var
	Cp,C,Cn:Char;
	Pos,PosMax:Integer;
    OnString, OnBlockComment, OnLineComment:Boolean;
    OnClasp:Integer;
    LineName,LineId:integer;
    LineSublineName:integer;
	Line, S: String;
begin

	Line := '';
    LineId := 0;
    LineName := 1;
    LineSublineName := 0;
    OnClasp := 0;

    Pos := -1;
	PosMax := Data.Length - 1;
    if (PosMax < 0) then exit;

    Cp := ' ';
    C := ' ';
    Cn := ' ';

    OnString := False;
    OnLineComment := False;
    OnBlockComment := False;

	while (Pos <= PosMax) do begin
    	Pos := Pos + 1;

        Cp := C;
        if (not OnString) then C := LowerCase(Data.Chars[Pos]).Chars[0] else C := Data.Chars[Pos];
        if (Pos + 1 <= PosMax) then Cn := Data.Chars[Pos + 1] else Cn := ' ';


        //El char es un salto de linea limpiamos lo que toque
			if ((not OnString) and (C = char(13))) then begin

                LineName := LineName + 1;
                LineSublineName := 0;

                OnLineComment := False;

            	continue;
        	end;


        //Miramos que no sea un espacio o trash
        	if ((not OnString) and (Ord(C) <= 32)) then continue;

        //Miramos si inicia un comentario de linea/bloque o si termina
        	if ((not OnString) and (not OnLineComment)) then begin
  	      		if ((C = '/') and (Cn = '/') and (not OnBlockComment)) then OnLineComment := True;
        		if ((C = '/') and (Cn = '*') and (not OnBlockComment)) then OnBlockComment := True;
            	if ((Cp = '*') and (C = '/') and (OnBlockComment)) then begin OnBlockComment := False; continue; end;
            end;
            if ((OnLineComment) or (OnBlockComment)) then continue;

            
        //Miramos si abre, cierra o lo que sea una string
            if (C = '''') then begin
                if (not OnString) then OnString := True
                else if (OnString) then begin
                    if (Cn = '''') then begin
                        Line := Line + C + Cn;
                        Pos := Pos + 1; continue;
                    end else OnString := False;
                end;
            end;

            
        //Vale! no es un comentario y ha llegado aqui asi que hay que añadir lo que quiera que sea
			Line := Line + C;

            
        //Miramos si es un RompeLinea
        	if ((not OnString) and ((C = ';') or (C = '{') or (C = '}'))) then begin
            	//Sacamos el nombre de la linea y contabilizamos clasp
	            	if (LineSublineName = 0) then
	                	S := SectionName + '@' + IntToStr(LineName) else S := SectionName + '@' + IntToStr(LineName) + '.' + IntToStr(LineSublineName);

                    if (C = '{') then OnClasp := OnClasp + 1
                    else if (C = '}') then OnClasp := OnClasp - 1;


                //Miramos si es un clasp close: Si sobra o si en su linea hay mas cosas
                	if (C = '}') then begin
                		if (OnClasp = -1) then begin
                        	if (Assigned(Parent.OnLog)) then Parent.DoLog('[' + S + '] Ignored Line. Reason: Unwanted block end [' + Parent.LineFormat(Line) + ']', 1);

                        	OnClasp := 0;
                        	Line := '';
                        	continue;
                    	end;

                        if (Line.Length > 1) then begin
							if (Assigned(Parent.OnLog)) then Parent.DoLog('[' + S + '] Ignored Line. Reason: Missing operator or semicolon [' + Parent.LineFormat(Line) + ']', 1);

                            Line := '}';
                        end;
                    end;

                //Miramos si la linea es valida y la añadimos
                    if ((PreValidated) or (ValidateLine(S, Line))) then begin
                    	SectionLines.Add(LineId, Line);
	                	SectionLinesName.Add(LineId,  S);
                    	LineId := LineId + 1;
                    end;

                //Y pasamos a la siguiente "linea de script"
	                LineSublineName := LineSublineName + 1;
	                Line := '';
            end;
    end;

    //¡Ha terminado! Miramos si hay texto en Line, lo que significaria que acaba sin un rompelinea osease que hay trash
    	if (Line.Length > 0) then begin
        	if (LineSublineName = 0) then
            	S := SectionName + '@' + IntToStr(LineName) else S := SectionName + '@' + IntToStr(LineName) + '.' + IntToStr(LineSublineName);
             
            if (ValidateLine(S, Line)) then
                if (Assigned(Parent.OnLog)) then Parent.DoLog('[' + S + '] Ignored End Line. Reason: Missing operator or semicolon [' + Parent.LineFormat(Line) + ']', 1);
        end;


    //Miramos si acaba con sobras de clasp y si es así lo solucionamos a lo loco
    	if (OnClasp > 0) then begin
			if (Assigned(Parent.OnLog)) then Parent.DoLog('[' + SectionName + '] Mising Block End. Patch: (' + IntToStr(3) + ') Clasp closure added at end to maintain integrity', 1);
            for Pos := 0 to OnClasp do begin
				SectionLines.Add(LineId, '}');
                SectionLinesName.Add(LineId,  SectionName + '@' + 'Patch Line [' + IntToStr(Pos) + ']');
                LineId := LineId + 1;
            end;
        end;
end;

function TSectionProcess.ValidateLine(const LineName:String; const Line:String): Boolean;
var
	C, Cn: Char;
	Pos, PosMax:Integer;
    OnString:Boolean;
    OnParentesis, OnBrace:Integer;
begin
	Result := False;

    //Primero Chequeamos que la linea sea correcta, parentesis, strings y brazos concordantes
        OnString := False;
        OnParentesis := 0;
        OnBrace := 0;

        Pos := -1;
        PosMax := Line.Length - 1;
        if (PosMax < 0) then exit;

        C := ' ';
        Cn := ' ';

        while (Pos <= PosMax) do begin
            Pos := Pos + 1;

            C := Line.Chars[Pos];
            if (Pos + 1 <= PosMax) then Cn := Line.Chars[Pos + 1] else Cn := ' ';

            if (C = '''') then begin
                if (not OnString) then OnString := True
                else if (OnString) then begin
                    if (Cn = '''') then begin
                        Pos := Pos + 1; continue;
                    end else OnString := False;
                end;

            end else if (not OnString) then begin
                if (C = '(') then OnParentesis := OnParentesis + 1
                else if (C = ')') then OnParentesis := OnParentesis - 1
                else if (C = '[') then OnBrace := OnBrace + 1
                else if (C = ']') then OnBrace := OnBrace - 1
            end;
        end;

        if (OnString) then begin
            if (Assigned(Parent.OnLog)) then Parent.DoLog('[' + LineName + ']  Ignored Line. Reason: Unterminated string [' + Parent.LineFormat(Line) + ']', 1);
            Exit;
        end;
        if (OnParentesis > 0) then begin
            if (Assigned(Parent.OnLog)) then Parent.DoLog('[' + LineName + ']  Ignored Line. Reason: Parenthesis need to be closed [' + Parent.LineFormat(Line) + ']', 1);
            Exit;
        end;
        if (OnParentesis < 0) then begin
            if (Assigned(Parent.OnLog)) then Parent.DoLog('[' + LineName + ']  Ignored Line. Reason: Unwated parenthesis close [' + Parent.LineFormat(Line) + ']', 1);
            Exit;
        end;
        if (OnBrace > 0) then begin
            if (Assigned(Parent.OnLog)) then Parent.DoLog('[' + LineName + ']  Ignored Line. Reason: Brace need to be closed [' + Parent.LineFormat(Line) + ']', 1);
            Exit;
        end;
        if (OnBrace < 0) then begin
            if (Assigned(Parent.OnLog)) then Parent.DoLog('[' + LineName + ']  Ignored Line. Reason: Unwated brace close [' + Parent.LineFormat(Line) + ']', 1);
            Exit;
        end;


    //TODO: Chequear concatenadores
    //TODO: Chequear linea válida
    //TODO: Mirar que el raw sea solo para nombres y esoç
    //TODO la linea no puedes er % por que eso seria un set de const
    //TODO: Cuando haya brazos hay que hacer el get y mirar que todos empiezan por [ y caban por ]
    //Todo: Chequear que los parametros si tienen nombre sea [a-z0-9];
    //tODO: Revisar que las comparaciones solo tienen un comparador >= ==...
    //todo: una vez partida la linea en & hay que mirar que no salga de los parentesis, strings etc no solo que acabe y que empiece, una cosa por parte.
    //todo vigila que despues de thread no haya nada o parentesis y parametros
    Result := True;
end;

procedure TSectionProcess.ProcessFunctions();
var
	C, Ce:Char;
    Max, OnClasp, Count, SubCount:integer;
    OnFunction:Boolean;
    FunctionName:string;
	SubSectionLines:TDictionary<Integer, String>;
    SubSectionLinesName:TDictionary<Integer, String>;
begin
    //Recorremos todas las lineas en búsqueda de sub funciones
		Max := SectionLines.Count-1;
        OnClasp := 0;
        SubCount := 0;
        OnFunction := False;
        FunctionName := '';

        for Count := 0 to Max do begin
        	C := SectionLines[Count].Chars[0];
            Ce := SectionLines[Count].Chars[SectionLines[Count].Length-1];

        	if ((not OnFunction) and (c = 'f') and (SectionLines[Count].Substring(0, 8) = 'function')) then begin
                OnFunction := true;
                FunctionName := SectionName + ':' + SectionLines[Count].Substring(8, SectionLines[Count].Length-8-1);
                SubCount := 0;
                SectionLines.Remove(Count);
                SectionLinesName.Remove(Count);

                SubSectionLines := TDictionary<Integer, String>.create;
                SubSectionLinesName := TDictionary<Integer, String>.create;
                OnClasp := OnClasp + 1;
                continue;
            end;

            if ((OnFunction) and (Ce = '{')) then  OnClasp := OnClasp + 1;
            if ((OnFunction) and (Ce = '}')) then begin
                OnClasp := OnClasp - 1;
                if ((OnFunction) and (OnClasp = 0)) then begin
                    SectionLines.Remove(Count);
                    SectionLinesName.Remove(Count);

					TSectionProcess.Create(Parent, FunctionName, SubSectionLines, SubSectionLinesName);
                    OnFunction := False;
                    SubSectionLines.free;
                    SubSectionLinesName.free;
                end;
            end;

            if (OnFunction) then begin
				SubSectionLines.Add(SubCount, SectionLines[Count]);
                SubSectionLinesName.Add(SubCount, SectionLinesName[Count]);
                SubCount := SubCount + 1;
                SectionLines.Remove(Count);
                SectionLinesName.Remove(Count);
            end;
        end;

end;



end.
