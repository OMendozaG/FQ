unit FQ;

interface

uses
	System.SysUtils, System.Classes, Generics.Collections, System.SyncObjs, System.IOUtils, System.JSON,
    FQ.GVar, FMX.Controls, RTTI;

type
	TFunc_OnLog = procedure(const Text: string; const Level: integer = 0) of object;
    TFunc_OnStack = procedure(const PID:string; const Name:String; const Start:Boolean; const Result:String; const Env:String; const LineName:String) of object;
    TFunc_OnVarSet = procedure(const PID:string; const Name:String; const Value:String; const LineName:String) of object;
    TFunc_OnEFQF = function(var Owned:Boolean; const Name:String; const Env:TDictionary<String, TGVar>): TValue of object;

type TFQ = class(TComponent)
	private
    	FormatSettings:TFormatSettings;
    	FlowPID:Integer;
        MainHasRuned:Boolean;

    protected
		Prop_OnLog: TFunc_OnLog;
        Prop_OnStack: TFunc_OnStack;
        Prop_OnVarSet: TFunc_OnVarSet;
        Prop_OnEFQF: TFunc_OnEFQF;
        Prop_ThreadLock_EFQFProxy: Boolean;
        Prop_BreakOnException: Boolean;

    public
        ThreadLock_OnLog:TMutex;
        ThreadLock_OnVarSet:TMutex;
        ThreadLock_OnStack:TMutex;
        ThreadLock_EFQFProxy:TMutex;
        ThreadLock_ThreadAdd:TMutex;

        FQF:Pointer;

    	BreakStack:Boolean;
        TID:Integer;
        Threads: TDictionary<Integer, TThread>;
        Env: TDictionary<String, TGVar>;
        Con: TDictionary<String, TGVar>;
		Script: TDictionary<String, TDictionary<Integer, String>>;
		ScriptLinesName: TDictionary<String, TDictionary<Integer, String>>;

		constructor Create();
        destructor Destroy(); override;
        procedure ScriptReset();
        procedure ExecutionReset();
        procedure UpdateConst(const OnlyUpdateables:Boolean = True);
        function ScriptGetAsJSON(): String;
		procedure ScriptAddSection(const Name: String; const Data: string; const CryptKey:string = ''; const PreventReProcess:Boolean=False);
        procedure ScriptAddSectionsAsJSON(Data: String; const ResetScript:Boolean = True; const RunMain:Boolean = True; const CryptKey:string = ''; const PreventReProcess:Boolean=False);

        procedure DoLog(const Text: string; const Level: integer = 0);
        procedure DoStack(const PID:string; const Name:String; const Start:Boolean; const Result:String; const Env:String; const LineName:String);
        procedure DoVarSet(const PID:string; const Name:String; const Value:String; const LineName:String);
        function DoEFQF(var Owned:Boolean; const Name:String; const Env:TDictionary<String, TGVar>): TValue;

        function ClearParamsLine(const Line:string):String;
        function RunSection(const Section:String; const Params:String): TGVar;
        procedure RunSectionOnThread(const FQPointer:Pointer; const Section:String; const Params:String);

        function GetPid():string;
        function GetTid():integer;
        function Crypt(const CryptKey: String; const Data:String) : String;
        function LineFormat(const Text:String): String;

        procedure SetEnv(const Name:string; const Data:TGVar; const PID:String = '0'; const LineName:String = '');
        procedure UnsetEnv(const Name:string; const LineName:String = '');
        procedure SetCon(const Name:string; const Data:Variant); overload;
        procedure SetCon(const Name:string; const Data:Variant; const PID:String; const LineName:String); overload;

        function OnlyChars(const Text: string; CharSet:TSysCharset): Boolean;

        function IndexOfOut(const Line: string; const Splitter: TSysCharset; const OutOfStrings:Boolean = True; const OutOfParentesis: Boolean = False; const OutOfBrace: Boolean = False; const ReturnLengthIfNotFound:Boolean = False): Integer; overload;
        function IndexOfOut(const Line: string; const Splitter: String; const OutOfStrings:Boolean = True; const OutOfParentesis: Boolean = False; const OutOfBrace: Boolean = False; const ReturnLengthIfNotFound:Boolean = False): Integer; overload;
        function SplitOut(const Line: string; const Splitter: TSysCharset; const OutOfStrings:Boolean = True; const OutOfParentesis: Boolean = False; const OutOfBrace: Boolean = False; const ReturnFullIfNotFound:Boolean = False): TDictionary<Integer, String>; overload;
        function SplitOut(const Splitter: array of string; const Line: string;const OutOfStrings:Boolean = True; const OutOfParentesis: Boolean = False; const OutOfBrace: Boolean = False; const ReturnFullIfNotFound:Boolean = False): TDictionary<Integer, TArray<String>>; overload;
        function SplitOut(const Splitter: String; const Line: string; const OutOfStrings:Boolean = True; const OutOfParentesis: Boolean = False; const OutOfBrace: Boolean = False; const ReturnFullIfNotFound:Boolean = False): TDictionary<Integer, String>; overload;
        function GetBraces(const Line:String): TDictionary<Integer, String>;

	published
    	property EFQFProxy_ThreadLock: Boolean read Prop_ThreadLock_EFQFProxy write Prop_ThreadLock_EFQFProxy;
        property BreakFlowOnException: Boolean read Prop_BreakOnException write Prop_BreakOnException;

		property OnLog: TFunc_OnLog read Prop_OnLog write Prop_OnLog;
        property OnStack: TFunc_OnStack read Prop_OnStack write Prop_OnStack;
        property OnVarSet: TFunc_OnVarSet read Prop_OnVarSet write Prop_OnVarSet;
        property OnEFQF: TFunc_OnEFQF read Prop_OnEFQF write Prop_OnEFQF;
end;



procedure Register;

implementation

uses FQ.SectionProcess, FQ.Flow, FQ.FQF;


procedure Register;
begin
	RegisterComponents('LST', [TFQ]);
end;

constructor TFQ.Create();
begin
    if (Assigned(OnLog)) then DoLog('[FQ] Initializing system...', 0);

    //Creamos mutex de interfaz
    	{$IFDEF MSWINDOWS}
        ThreadLock_OnLog :=  TMutex.Create(nil, False, 'ThreadLock_OnLog', True);
		ThreadLock_OnVarSet := TMutex.Create(nil, False, 'ThreadLock_OnVarSet', True);
		ThreadLock_OnStack := TMutex.Create(nil, False, 'ThreadLock_OnStack', True);
        ThreadLock_EFQFProxy := TMutex.Create(nil, False, 'ThreadLock_FQFProxy', True);
        ThreadLock_ThreadAdd := TMutex.Create(nil, False, 'ThreadLock_ThreadAdd', True);
        {$ELSE}
        ThreadLock_OnLog :=  TMutex.Create(True);
		ThreadLock_OnVarSet := TMutex.Create(True);
		ThreadLock_OnStack := TMutex.Create(True);
        ThreadLock_EFQFProxy := TMutex.Create(True);
        ThreadLock_ThreadAdd := TMutex.Create(True);
        {$ENDIF}

    //Default values
    	FormatSettings := TFormatSettings.Create;
        FormatSettings.DecimalSeparator := ',';
        FormatSettings.ThousandSeparator := '.';

        Prop_ThreadLock_EFQFProxy := False;
        Prop_BreakOnException := False;


        FQF := TFQF.Create(Self);

    //Inicializamos lo necesario
        ScriptReset();


    if (Assigned(OnLog)) then DoLog('[FQ] FQ ready!', 0);
end;

destructor TFQ.Destroy();
var
	K:string;
begin
	//Lanzamos ya el breakstack
    	BreakStack := True;
    
	//Quitamos la cionexion con el exterior
        ThreadLock_OnLog.Acquire;
        ThreadLock_OnStack.Acquire;
        ThreadLock_OnVarSet.Acquire;
        ThreadLock_EFQFProxy.Acquire;
        //ThreadLock_ThreadAdd.Acquire;

		OnLog := nil;
    	OnStack := nil;
    	OnVarSet := nil;

        ThreadLock_OnLog.Release;
        ThreadLock_OnStack.Release;
        ThreadLock_OnVarSet.Release;
        ThreadLock_EFQFProxy.Release;
        //ThreadLock_ThreadAdd.Release;

    
	//Limpiamos los objetos utilizados por el camino
        ScriptReset();

    //Y limpiamos los defaults de los resets
        Env.Free;
        if (Assigned(Con)) then
        	for K in Con.Keys do Con[K].Free;
        Con.Free;

        Script.Free;
        ScriptLinesName.Free;

        threads.Free;

        ThreadLock_OnLog.Free;
        ThreadLock_OnStack.Free;
        ThreadLock_OnVarSet.Free;
        ThreadLock_EFQFProxy.Free;
        ThreadLock_ThreadAdd.Free;

        TFQF(FQF).Free;
end;

procedure TFQ.ScriptReset();
var
	K:String;
begin
	//Reseteamos la ejecucion
    	ExecutionReset();

        MainHasRuned := False;

	//Reseteamos el FQ para que setee los defaults
    	FlowPID := 0;
        if (Assigned(Script)) then
    		for K in Script.Keys do Script[K].Free;
		Script.Free;

        if (Assigned(ScriptLinesName)) then
        	for K in ScriptLinesName.Keys do ScriptLinesName[K].Free;
        ScriptLinesName.Free;

    //Instanciamos defaults
    	Script := TDictionary<String, TDictionary<Integer, String>>.create();
        ScriptLinesName := TDictionary<String, TDictionary<Integer, String>>.create();
end;

procedure TFQ.ExecutionReset();
var
	i:integer;
	K:String;
    LastBreakStack:Boolean;
begin
	//Detenemos la actual ejecucion del script
    	LastBreakStack := BreakStack;
        BreakStack := true;

    //Detenemos todos los threads
    	ThreadLock_ThreadAdd.Acquire;
    	if (Assigned(Threads)) then begin
         	for i in threads.Keys do begin
                threads[i].Suspended := True;
                if (TRunOnThread(threads[i]).FreeAtEnd) then
                	TFlow(TRunOnThread(threads[i]).flow).Free;
                threads[i].Terminate;
                //threads.Remove(i);
            end;
        end;
        ThreadLock_ThreadAdd.Release;

    //Ahora pillamos todos los locks para limpiar todo
        ThreadLock_OnLog.Acquire;
        ThreadLock_OnStack.Acquire;
        ThreadLock_OnVarSet.Acquire;
        ThreadLock_ThreadAdd.Acquire;

        Threads.Free;
		Threads := TDictionary<Integer, TThread>.create;

	//Reseteamos las cosas de la ejecución
    	if (Assigned(Con)) then
        	for K in Con.Keys do Con[K].Free;
        Con.Free;

        if (Assigned(Env)) then
        	for K in Env.Keys do Env[K].Free;
        Env.Free;

    //Instanciamos defaults
        Env := TDictionary<String, TGVar>.create();
        Con := TDictionary<String, TGVar>.create();
        UpdateConst(False);

        ThreadLock_OnLog.Release;
        ThreadLock_OnStack.Release;
        ThreadLock_OnVarSet.Release;
        ThreadLock_ThreadAdd.Release;

        BreakStack := LastBreakStack;
end;

procedure TFQ.UpdateConst(const OnlyUpdateables:Boolean = True);
    function PathFormat(const s:string):string;
    var
        Contra:string;
    begin
        Result := s;
        if (s = '') then exit;

        if ((s.Chars[s.Length - 1] <> '/') and (s.Chars[s.Length - 1] <> '\')) then
            Result :=  Result + TPath.DirectorySeparatorChar;

        if (TPath.DirectorySeparatorChar = '/') then Contra := '\'
        else Contra := '/';

        Result := StringReplace(Result, Contra, TPath.DirectorySeparatorChar, [rfReplaceAll, rfIgnoreCase]);
    end;
var
	S,X:String;
begin
	//Cargamos las variables, primero las que pueden cambiar según el momento
		SetCon('time', '342');

    //Y ahora si se require las fijas
    	if (OnlyUpdateables) then exit;
		SetCon('fq', 'FQ');
        SetCon('version', '3.1');

        S := '';
        for X in TFQF(FQF).Methods.Keys do S := S + X + ';';
        SetCon('functions', S);

        SetCon('pathtemp', PathFormat(TPath.GetTempPath));
        SetCon('pathhome', PathFormat(TPath.GetHomePath));
        SetCon('pathdocuments', PathFormat(TPath.GetDocumentsPath));

        SetCon('pathlibrary', PathFormat(TPath.GetLibraryPath));
        SetCon('pathcache', PathFormat(TPath.GetCachePath));
        SetCon('pathpublic', PathFormat(TPath.GetPublicPath));
        SetCon('pathpictures', PathFormat(TPath.GetPicturesPath));
        SetCon('pathcamera', PathFormat(TPath.GetCameraPath));
        SetCon('pathmusic', PathFormat(TPath.GetMusicPath));
        SetCon('pathmovies', PathFormat(TPath.GetMoviesPath));
        SetCon('pathdownloads', PathFormat(TPath.GetDownloadsPath));
        SetCon('pathalarms', PathFormat(TPath.GetAlarmsPath));

        SetCon('appfile', ParamStr(0));
        SetCon('appfilename', TPath.GetFileName(ParamStr(0)));
        SetCon('pathapp', PathFormat(TPath.GetDirectoryName(ParamStr(0))));

        SetCon('pathchar', TPath.DirectorySeparatorChar);
        SetCon('pathprogramfiles', PathFormat(GetEnvironmentVariable('PROGRAMFILES')));
        SetCon('pathsystem', PathFormat(GetEnvironmentVariable('SYSTEMROOT')));
        SetCon('pathcommonprogramfiles', PathFormat(GetEnvironmentVariable('COMMONPROGRAMFILES')));
        SetCon('pathsearch', PathFormat(GetEnvironmentVariable('PATH')));

end;

function TFQ.ScriptGetAsJSON(): String;
var
	S:string;
    K:Integer;
    A:TJSONArray;
    O:TJSONObject;
    b:TBytes;
begin
	//Metemos el script en un JSON
        Result := '';
        O := TJSONObject.Create;

        for S in Script.Keys do begin
            A := TJSONArray.Create;
            for K := 0 to Script[S].Count-1 do
            	A.Add(Script[S][K]);
            O.AddPair(S, A);
        end;

        SetLength(B, o.EstimatedByteSize);
		K := O.ToBytes(B, 0);
		Result := TEncoding.ANSI.GetString(B, 0, K);

		o.Destroy;
end;

procedure TFQ.ScriptAddSection(const Name: String; const Data: string; const CryptKey:string = ''; const PreventReProcess:Boolean=False);
begin
	//Añadimos código en texto
		TSectionProcess.Create(Self, Name, Data, CryptKey, PreventReProcess);
end;

procedure TFQ.ScriptAddSectionsAsJSON(Data: String; const ResetScript:Boolean = True; const RunMain:Boolean = True; const CryptKey:string = ''; const PreventReProcess:Boolean=False);
var
	Flow:TFlow;
    JO:TJSONObject;
    HasMain:Boolean;
    K:integer;
    JOe, SEo, B:TJSONPairEnumerator;
    SEa:TJSONArrayEnumerator;
    SectionName:String;
    SectionLines: TDictionary<Integer, String>;
begin

	if (CryptKey <> '') then Data := Crypt(Data, CryptKey);
    if (ResetScript) then ScriptReset();

    if (Data = '') then exit;

    HasMain := False;

    JO := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(Data),0) as TJSONObject;

    JOe := jo.GetEnumerator;

    while (JOe.MoveNext) do begin
    	SectionName := LowerCase(JOe.Current.JsonString.Value);
        if (SectionName = 'main') then HasMain := TRUE;
        SectionLines := TDictionary<Integer, String>.create;

        k := 0;
        if (Joe.Current.JsonValue is TJSONArray) then begin
        	SEa := TJSONArray(Joe.Current.JsonValue).GetEnumerator;
            while (SEa.MoveNext) do begin SectionLines.Add(K, SEa.GetCurrent.Value); K := K+1; end;
            SEa.Free;
        end else if (Joe.Current.JsonValue is TJSONObject) then begin
            SEo := TJSONObject(Joe.Current.JsonValue).GetEnumerator;
            while (SEo.MoveNext) do begin SectionLines.Add(K, SEo.GetCurrent.Value); K := K+1; end;
            SEo.Free;
        end;

        TSectionProcess.Create(Self, SectionName, SectionLines, PreventReProcess);

        SectionLines.Free;
    end;

    Joe.Free;
    JO.Destroy;

    if ((HasMain) and (not MainHasRuned) and (RunMain)) then begin
        MainHasRuned := True;

        Flow := TFlow.create(Self, 'main');
        Flow.Run;
        Flow.Free;
    end;
end;

procedure TFQ.DoLog(const Text: string; const Level: integer = 0);
begin
try
	ThreadLock_OnLog.Acquire;
    if (Assigned(OnLog)) then OnLog(Text, Level);
    ThreadLock_OnLog.Release;
except ThreadLock_OnLog.Release; end;
end;

procedure TFQ.DoStack(const PID:string; const Name:String; const Start:Boolean; const Result:String; const Env:String; const LineName:String);
begin
try
	ThreadLock_OnStack.Acquire;
    if (Assigned(OnStack)) then OnStack(PID, Name, Start, Result, Env, LineName);
    ThreadLock_OnStack.Release;
except ThreadLock_OnStack.Release; end;
end;

procedure TFQ.DoVarSet(const PID:string; const Name:String; const Value:String; const LineName:String);
begin
try
	ThreadLock_OnVarSet.Acquire;
    if (Assigned(OnVarSet)) then OnVarSet(PID, Name, Value, LineName);
    ThreadLock_OnVarSet.Release;
except ThreadLock_OnVarSet.Release; end;
end;

function TFQ.DoEFQF(var Owned:Boolean; const Name:String; const Env:TDictionary<String, TGVar>): TValue;
var
	ThreadRelease:Boolean;
begin
try
	ThreadRelease := false;
	if (EFQFProxy_ThreadLock) then begin
      ThreadLock_EFQFProxy.Acquire;
      ThreadRelease := True;
    end;
    Result := '';
    if (Assigned(OnEFQF)) then Result := OnEFQF(Owned, Name, Env);
    if (ThreadRelease) then ThreadLock_EFQFProxy.Release;
except if (ThreadRelease) then ThreadLock_EFQFProxy.Release; end;
end;

function TFQ.ClearParamsLine(const Line:string):string;
var
	Pos:Integer;
	C, Cn:Char;
    OnString:Boolean;
    OnParentesis,OnBrace:Integer;
begin
	Result := '';
    OnString := False;
    OnParentesis := 0;
    OnBrace := 0;

    Pos := -1;
    while (Pos < Line.Length-1) do begin;

        Pos := Pos + 1;
        C := Line.Chars[Pos];
        if (Pos+1 < Line.Length) then Cn := Line.Chars[Pos + 1] else Cn := ' ';

        if ((not OnString) and (Ord(C) <= 32)) then continue;

        if (C = '''') then begin
	        if (not OnString) then OnString := True
        	else if (OnString) then begin
            	if (Cn = '''') then begin
                	Result := Result + C + Cn;
                    Pos := Pos + 1; continue;
                end else OnString := False;
            end;

        end else if (not OnString) then begin
        	C := Lowercase(C).Chars[0];
            if (C = '(') then OnParentesis := OnParentesis + 1
            else if (C = ')') then OnParentesis := OnParentesis - 1
            else if (C = '[') then OnBrace := OnBrace + 1
            else if (C = ']') then OnBrace := OnBrace - 1;
        end;

        Result := Result + C;
    end;

    if ((OnString) or (OnParentesis <> 0) or (OnBrace <> 0))  then begin
    	Result := '';
        if (Assigned(OnLog)) then DoLog('[FQ] Error: Invalid sintax on params line', 1);
    end;

end;

function TFQ.RunSection(const Section:String; const Params:String): TGVar;
var
	Flow:TFlow;
    GVar:TGVar;
begin
	Result := TGVar.Create();

	if (not Script.ContainsKey(Lowercase(Section))) then begin
        if (Assigned(OnLog)) then DoLog('[FQ] Error: Can''t run section. Reason: Not found ['+Section+']');
        Exit;
    end;

    Flow := TFlow.Create(Self, Section);
    Flow.DeclareEnv(Params);
    Flow.Run();


   	Flow.PreventFreeOfResult := True;

    Result.Free;
    Result := Flow.Result;

    Flow.Free;
end;

procedure TFQ.RunSectionOnThread(const FQPointer:Pointer; const Section:String; const Params:String);
var
	Flow:TFlow;
begin
	if (not Script.ContainsKey(Lowercase(Section))) then begin
        if (Assigned(OnLog)) then DoLog('[FQ] Error: Can''t run section. Reason: Not found ['+Section+']');
        Exit;
    end;

    Flow := TFlow.Create(FQPointer, Section);
    Flow.DeclareEnv(Params);
    Flow.RunOnThread();
end;

function TFQ.GetPID():string;
begin
	FlowPID := FlowPID + 1;
    Result := IntToHex(FlowPID, 8);

    if (FlowPid >= 2290000000) then FlowPid := -1;
end;

function TFQ.GetTid():integer;
begin
	TID := TID + 1;
    Result := TID;
end;

function TFQ.Crypt(const CryptKey: String; const Data:String) : String;
var
   i : Integer;
   KeyLen : Integer;
begin
   KeyLen := CryptKey.Length;
   for i := 0 to CryptKey.Length do KeyLen := KeyLen xor Ord(CryptKey.Chars[i]);

   Result := '';
   for i := 0 to Data.Length do Result := Result + chr(not(ord(Data.Chars[i]) xor Ord(KeyLen)));
end;

function TFQ.LineFormat(const Text:String): String;
var
	I: Integer;
begin
	Result := '';
    for I := 0 to Text.Length-1 do
    	if (ord(Text.Chars[I]) >= 33) then Result := Result + Text.Chars[I];
end;

procedure TFQ.SetEnv(const Name:string; const Data:TGVar; const PID:String = '0'; const LineName:String = '');
begin
	UnsetEnv(Name, LineName);
	Env.AddOrSetValue(Name, Data);

	if (Assigned(OnLog)) then DoLog('[' + PID + '] ' + LineName + 'Var setted ["@'+Name+'"="' + Data.GetValue + '"]', 4);
    if (Assigned(OnVarSet)) then DoVarSet(PID, '@' + Name, Data.GetValue, LineName);
end;

procedure TFQ.UnsetEnv(const Name:string; const LineName:String = '');
var
	K:string;
begin
 	if (Env.ContainsKey(Name)) then begin
        if (Env[Name].GVarType = 3) then begin
        	for K in Env[Name].GetArray.Keys do UnsetEnv(Name+'['+K+']');
        end;

    	Env[Name].Free;
        Env.Remove(Name);
        if (Assigned(OnLog)) then DoLog(LineName + 'Global unsetted ["$'+Name+'"]', 6);
    end;
end;

procedure TFQ.SetCon(const Name:string; const Data:Variant);
begin
	if (Con.ContainsKey(Name)) then Con[Name].Free;
	Con.AddOrSetValue(Name, TGVar.Create(Data));
end;

procedure TFQ.SetCon(const Name:string; const Data:Variant; const PID:String; const LineName:String);
begin
	if (Con.ContainsKey(Name)) then Con[Name].Free;
	Con.AddOrSetValue(Name, TGVar.Create(Data));

    if (Assigned(OnLog)) then DoLog('[' + PID + '] ' + LineName + 'Var setted ["%'+Name+'"="' + Con[Name].GetValue + '"]', 4);
    if (Assigned(OnVarSet)) then DoVarSet(PID, '%' + Name, Con[Name].GetValue, LineName);
end;

function TFQ.OnlyChars(const Text: string; CharSet:TSysCharset): Boolean;
var
	I:integer;
begin
	Result := False;
    for I := 0 to Text.Length-1 do if (not CharInSet(Text.Chars[I], CharSet)) then exit;

    Result := True;
end;

function TFQ.IndexOfOut(const Line: string; const Splitter: TSysCharset; const OutOfStrings:Boolean = True; const OutOfParentesis: Boolean = False; const OutOfBrace: Boolean = False; const ReturnLengthIfNotFound:Boolean = False): Integer;
var
	C:Char;
	I:Integer;
    OnString:Boolean;
    OnParentesis,OnBrace:Integer;
begin
    if (ReturnLengthIfNotFound) then Result := Line.Length
    else Result := -1;

    OnString := False;
    for C in Splitter do
    	if (Line.IndexOf(C) >= 0) then begin OnString := True; break; end;
    if (not OnString) then  Exit;

	I := 0;
    OnString := False;
    OnParentesis := 0;
    OnBrace := 0;

    while (I < Line.Length) do begin
        C := Line.Chars[I];

        if (C = '''') then begin
        	if (not OnString) then OnString := True
            else if (OnString) then begin
            	if (Line.Chars[I+1] = '''') then begin I := I + 2; continue; end
                else OnString := False;
            end;
        end;

        if (not OnString) then begin
			if ((((((OutOfStrings) and (not OnString)) or (not OutOfStrings)) and
             		((OutOfParentesis) and (OnParentesis = 0)) or (not OutOfParentesis)) and
             		(((OutOfBrace) and (OnBrace = 0)) or (not OutOfBrace)))
            		and (CharInSet(C, Splitter))) then begin
                Result := I;
                Exit;
			end;

        	if (C = '(') then OnParentesis := OnParentesis + 1
            else if (C = ')') then OnParentesis := OnParentesis - 1
            else if (C = '[') then OnBrace := OnBrace + 1
            else if (C = ']') then OnBrace := OnBrace - 1;
        end;

        I := I + 1;
    end;

    if ((Result = -1) and (ReturnLengthIfNotFound)) then Result := Line.Length;
end;


function TFQ.IndexOfOut(const Line: string; const Splitter: String; const OutOfStrings:Boolean = True; const OutOfParentesis: Boolean = False; const OutOfBrace: Boolean = False; const ReturnLengthIfNotFound:Boolean = False): Integer;
var
	C,Cs:Char;
	I, Sl:Integer;
    OnString:Boolean;
    OnParentesis,OnBrace:Integer;
begin
    if (ReturnLengthIfNotFound) then Result := Line.Length
    else Result := -1;

    OnString := False;
    if (Line.IndexOf(Splitter) < 0) then Exit;

	I := 0;
    OnString := False;
    OnParentesis := 0;
    OnBrace := 0;
    Sl := Splitter.Length;
    Cs := Splitter.Chars[0];

    while (I < Line.Length) do begin
        C := Line.Chars[I];

        if (C = '''') then begin
        	if (not OnString) then OnString := True
            else if (OnString) then begin
            	if (Line.Chars[I+1] = '''') then begin I := I + 2; continue; end
                else OnString := False;
            end;
        end;

        if (not OnString) then begin
			if ((((((OutOfStrings) and (not OnString)) or (not OutOfStrings)) and
             		((OutOfParentesis) and (OnParentesis = 0)) or (not OutOfParentesis)) and
             		(((OutOfBrace) and (OnBrace = 0)) or (not OutOfBrace)))
            		and ((C = Cs) and (Line.Substring(I, Sl) = Splitter))) then begin
                Result := I;
                Exit;
			end;

        	if (C = '(') then OnParentesis := OnParentesis + 1
            else if (C = ')') then OnParentesis := OnParentesis - 1
            else if (C = '[') then OnBrace := OnBrace + 1
            else if (C = ']') then OnBrace := OnBrace - 1;
        end;

        I := I + 1;
    end;

    if ((Result = -1) and (ReturnLengthIfNotFound)) then Result := Line.Length;
end;

function TFQ.SplitOut(const Line: string; const Splitter: TSysCharset; const OutOfStrings:Boolean = True; const OutOfParentesis: Boolean = False; const OutOfBrace: Boolean = False; const ReturnFullIfNotFound:Boolean = False): TDictionary<Integer, String>;
var
	C:Char;
	I:Integer;
    OnString:Boolean;
    OnParentesis,OnBrace:Integer;
    Buffer: String;
begin

	Result := TDictionary<Integer, String>.create();

    OnString := False;
    for C in Splitter do
    	if (Line.IndexOf(C) >= 0) then begin OnString := True; break; end;
    if (not OnString) then begin
    	if (ReturnFullIfNotFound) then
        	if (Line <> '') then Result.add(0, Line);
    	Exit;
    end;

	I := 0;
    OnString := False;
    OnParentesis := 0;
    OnBrace := 0;
    Buffer := '';

    while (I < Line.Length) do begin
        C := Line.Chars[I];
        Buffer := Buffer + C;

        if (C = '''') then begin
        	if (not OnString) then OnString := True
            else if (OnString) then begin
            	if (Line.Chars[I+1] = '''') then begin Buffer := Buffer + ''''; I := I + 2; continue; end
                else OnString := False;
            end;
        end;

        if (not OnString) then begin
			if ((((((OutOfStrings) and (not OnString)) or (not OutOfStrings)) and
             		((OutOfParentesis) and (OnParentesis = 0)) or (not OutOfParentesis)) and
             		(((OutOfBrace) and (OnBrace = 0)) or (not OutOfBrace)))
            		and (CharInSet(C, Splitter))) then begin
                Result.Add(Result.count, Buffer.substring(0,Buffer.length-1));
                Buffer := '';
			end;

        	if (C = '(') then OnParentesis := OnParentesis + 1
            else if (C = ')') then OnParentesis := OnParentesis - 1
            else if (C = '[') then OnBrace := OnBrace + 1
            else if (C = ']') then OnBrace := OnBrace - 1;
        end;

        I := I + 1;
    end;

    if (Result.count = 0) then begin
    	if (ReturnFullIfNotFound) then
        	Result.add(0, Line);
    end else if (Buffer.Length > 0) then
       if (Line <> '') then Result.Add(Result.count, Buffer);
end;

function TFQ.SplitOut(const Splitter: array of string; const Line: string;const OutOfStrings:Boolean = True; const OutOfParentesis: Boolean = False; const OutOfBrace: Boolean = False; const ReturnFullIfNotFound:Boolean = False): TDictionary<Integer, TArray<String>>;
	function AsArray(const Text:String; const Splitter:String): TArray<String>;
    begin
    	setlength(Result, 2);
        Result[0] := Text;
        Result[1] := Splitter;
    end;
	function InArray(const C: Char; const Text:String; const From:Integer): String;
    var
    	S:String;
    begin
    	Result := '';
		for S in Splitter do begin
        	if ((C = S.Chars[0]) and (S = Text.Substring(From, S.Length))) then begin
				Result := S;
	            break;
            end;
        end;
    end;
var
	C:Char;
    E:String;
	I:Integer;
    OnString:Boolean;
    InSplitt:String;
    OnParentesis,OnBrace:Integer;
    Buffer: String;
    SplitterC:TArray<String>;
begin

	Result := TDictionary<Integer, TArray<String>>.create();

    OnString := False;
    for E in Splitter do
    	if (Line.IndexOf(E) >= 0) then begin OnString := True; break; end;
    if (not OnString) then begin
    	if (ReturnFullIfNotFound) then
        	if (Line <> '') then Result.add(0, AsArray(Line, ''));
    	Exit;
    end;

	I := 0;
    OnString := False;
    OnParentesis := 0;
    OnBrace := 0;
    Buffer := '';

    while (I < Line.Length) do begin
        C := Line.Chars[I];
        Buffer := Buffer + C;

        if (C = '''') then begin
        	if (not OnString) then OnString := True
            else if (OnString) then begin
            	if (Line.Chars[I+1] = '''') then begin Buffer := Buffer + ''''; I := I + 2; continue; end
                else OnString := False;
            end;
        end;

        if (not OnString) then begin
			if ((((((OutOfStrings) and (not OnString)) or (not OutOfStrings)) and
             		((OutOfParentesis) and (OnParentesis = 0)) or (not OutOfParentesis)) and
             		(((OutOfBrace) and (OnBrace = 0)) or (not OutOfBrace)))) then begin
                    InSplitt := (InArray(C, Line, I));
                    if (InSplitt <> '') then begin
                		Result.Add(Result.count, AsArray(Buffer.substring(0,Buffer.length-1), InSplitt));
                		Buffer := '';
                        I := I + InSplitt.Length-1;
            		end;
			end;

        	if (C = '(') then OnParentesis := OnParentesis + 1
            else if (C = ')') then OnParentesis := OnParentesis - 1
            else if (C = '[') then OnBrace := OnBrace + 1
            else if (C = ']') then OnBrace := OnBrace - 1;
        end;

        I := I + 1;
    end;

    if (Result.count = 0) then begin
    	if (ReturnFullIfNotFound) then
        	Result.add(0, AsArray(Line, ''));
    end else if (Buffer.Length > 0) then
       if (Line <> '') then Result.Add(Result.count, AsArray(Buffer, ''));
end;

function TFQ.SplitOut(const Splitter: String; const Line: string;const OutOfStrings:Boolean = True; const OutOfParentesis: Boolean = False; const OutOfBrace: Boolean = False; const ReturnFullIfNotFound:Boolean = False): TDictionary<Integer, String>;
var
	C,sC:Char;
    E:String;
	I,sL:Integer;
    OnString:Boolean;
    InSplitt:String;
    OnParentesis,OnBrace:Integer;
    Buffer: String;
begin

	Result := TDictionary<Integer, String>.create;

    if (Line.IndexOf(Splitter) < 0) then begin
    	if (ReturnFullIfNotFound) then
        	if (Line <> '') then Result.add(0, Line);
    	Exit;
    end;

	I := 0;
    OnString := False;
    OnParentesis := 0;
    OnBrace := 0;
    Buffer := '';
    Sc := Splitter.Chars[0];
    Sl := Splitter.Length;

    while (I < Line.Length) do begin
        C := Line.Chars[I];
        Buffer := Buffer + C;

        if (C = '''') then begin
        	if (not OnString) then OnString := True
            else if (OnString) then begin
            	if (Line.Chars[I+1] = '''') then begin Buffer := Buffer + ''''; I := I + 2; continue; end
                else OnString := False;
            end;
        end;

        if (not OnString) then begin
			if (((((((OutOfStrings) and (not OnString)) or (not OutOfStrings)) and
             		((OutOfParentesis) and (OnParentesis = 0)) or (not OutOfParentesis)) and
             		(((OutOfBrace) and (OnBrace = 0)) or (not OutOfBrace))))
                    and ((sC = C) and (Splitter = Line.Substring(I, sL)))) then begin
                		Result.Add(Result.count, Buffer.substring(0,Buffer.length-1));
                		Buffer := '';
                        I := I + sL - 1;
			end;

        	if (C = '(') then OnParentesis := OnParentesis + 1
            else if (C = ')') then OnParentesis := OnParentesis - 1
            else if (C = '[') then OnBrace := OnBrace + 1
            else if (C = ']') then OnBrace := OnBrace - 1;
        end;

        I := I + 1;
    end;

    if (Result.count = 0) then begin
    	if (ReturnFullIfNotFound) then
        	Result.add(0, Line);
    end else if (Buffer.Length > 0) then
       if (Line <> '') then Result.Add(Result.count, Buffer);
end;

function TFQ.GetBraces(const Line:String): TDictionary<Integer, String>;
var
	C:Char;
	I,K:Integer;
    OnString:Boolean;
    OnParentesis,OnBrace:Integer;
    Buffer: String;
begin
	Result := TDictionary<Integer, String>.create;

	I := 0;
    K := 0;
    OnString := False;
    OnParentesis := 0;
    OnBrace := 0;
    Buffer := '';

    while (I < Line.Length) do begin
        C := Line.Chars[I];
        Buffer := Buffer + C;

        if (C = '''') then begin
        	if (not OnString) then OnString := True
            else if (OnString) then begin
            	if (Line.Chars[I+1] = '''') then begin I := I + 2; continue; end
                else OnString := False;
            end;
        end;

        if (not OnString) then begin
        	if (C = '(') then OnParentesis := OnParentesis + 1
            else if (C = ')') then OnParentesis := OnParentesis - 1
            else if (C = '[') then OnBrace := OnBrace + 1
            else if (C = ']') then begin OnBrace := OnBrace - 1;
                if ((not OnString) and (OnParentesis = 0) and (OnBrace = 0)) then begin
                    Result.Add(K, Buffer.Substring(1, Buffer.Length-2));
                    Buffer := '';
                    K := K + 1;
                end;
            end;
        end;

        I := I + 1;
    end;
end;




end.
