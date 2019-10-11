unit FQ.FQF;

interface

uses System.Classes, System.SysUtils, Generics.Collections, RTTI, TypInfo, FQ.Flow,
	 FQ, FQ.GVar,

	 IdCookieManager, IdCookie, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
	 IdHTTP, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdMultipartFormData,
	 IdSSLOpenSSL, IdZLibCompressorBase, IdCompressorZLib, Math, EncdDecd,

     {$IFDEF MSWINDOWS}
     Tlhelp32, Winapi.Windows, Winapi.Messages, ShellApi, Registry, ShlObj, ComObj, ActiveX,
     {$ENDIF MSWINDOWS}

     IdHash, IdHashMessageDigest,

     StrUtils, System.JSON, DateUtils, REST.Utils, System.IOUtils;

type TFQF = class
	public
    	Parent:TFQ;
        Methods:TDictionary<String, TRTTIMethod>;
        Params:TDictionary<String, TDictionary<Integer, String>>;
        ParamsT:TDictionary<String, TDictionary<Integer, String>>;
        Defaults:TDictionary<String, TDictionary<String, TGVar>>;

        constructor Create(const FQParent:TFQ);
        destructor Destroy(); override;
        procedure UpdateMethods();

		function Run(const Name:String; const Params:String; const Flow:TFlow):TGVar;
        function PrepareArgs(const Name:string; const Elements:TDictionary<String, TGVar>; const Flow:TFlow; const PID:String = '0'):TArray<TValue>;
        function GetParams(const Line: String; const Flow: TFlow; const PID:String = '0'): TDictionary<String, TGVar>;
        function GetParamsVariable(const Line: String; var Keys:TStringList; const Flow: TFlow; const PID:String = '0'): TDictionary<String, TGVar>;

    private
    	procedure PrintArray(const Keys: TStringList; const Sort:Boolean; const Data:TDictionary<String, TGVar>; const Level: integer = 0; const Child:string = '');
        procedure HTTP_Work_Internal(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);

    published

    	//06: Básicas
    	procedure Log(const Data:TGVar; const Sort:Boolean; const Flow:TFlow);
        procedure FQSectionsAddAsJSON(const Data:String; const ResetScript:Boolean; const RunMain:Boolean; const CryptKey:String; const PreventReProcess:Boolean);

        procedure ThreadClose(const ThreadId:Integer);

        function Return(const Data:string):String;
        function IsNull(const Data:TGVar):Boolean;
        function IsReg(const Data:TGVar; const ArrayAsReg:Boolean):Boolean;
       	function IsArray(const Data:TGVar):Boolean;
        function IsObject(const Data:TGVar; const ArrayAsObject:Boolean):Boolean;
        function IsNum(const Data:TGVar; const Decimal:Boolean; const Negative:Boolean):Boolean;

        function Bool(const Data:TGVar):Boolean;

        procedure Sleep(const Milis:Integer);

        function Time(const UTC:Boolean):integer;
        function TimeZoneOffset():integer;
        function Date(const TimeStamp:integer; const Format:string):String;
        function DateToTime(const Data:string; const Format:string; const DateSeparator:string):Integer;

        //07: Strings
        function StrCount(const Data:TGVar):Integer;
        function Chr(const Data:String; const Pos:integer):String;
        function StrToChars(const Data:String):TGVar;

        function StrToUpper(const Data:String):String;
        function StrToLower(const Data:String):String;

        function DecToHex(const Data:Integer; const Size:Integer):String;
        function HexToDec(const Data:String):Integer;

        function StrPos(const Data:String; const Search:string; const FromPos:Integer):Integer;

        function NumTrunc(const Data:Double):Integer;
        function NumRound(const Data:Double):Integer;

        function Trim(const Data:String):String;
        function StrRev(const Data:String):String;

        function StrOrd(const Data:String; const Splitter:String):String;
        function StrChar(const Data:Integer):String;

        function SubStr(const Data:String; const FromPos:Integer; Length:Integer):String;
        function Split(Data:String; Splitter:string; const CaseSensitive:Boolean; const Limit:Integer):TGVar;
        function SubStrCut(const Data:String; SplitFrom:String; SplitTo:String; const AsArray:Boolean; const Count:Integer; const RestIfSplitToNotFound:Boolean; const CaseSensitive:Boolean; const IncFromSplitter:Boolean; const IncToSplitter:Boolean):TGVar;

        //08: Arrays
        function Count(const Data:TGVar; const CountIfString:Boolean):Integer;
        function Keys(const Data:TGVar; const Sort:Boolean):TGVar;
        function KSort(const Data:TGVar):TGVar;
        function ArrayToLine(const Data:TGVar; const Splitter:string; const Sort:Boolean; const EqualOnEmpty:Boolean; const UrlEncode:Boolean):String;
        function ArrayKeySearch(const Data:TGVar; Key:string; const CaseSensitive:Boolean):TGVar;
        function ArrayKeyExist(const Data:TGVar; Key:string; const CaseSensitive:Boolean):TGVar;
        function ArrayValueSearch(const Data:TGVar; Value:string; const CaseSensitive:Boolean; const AllowMultipleResult:Boolean):TGVar;
        function ArrayValueExist(const Data:TGVar; Value:string; const CaseSensitive:Boolean):TGVar;

        //09: Objetos

        //10: Util
		function Crypt(const CryptKey: String; const Data:String) : String;
        function Rand(const Min:Integer; const Max:Integer):integer;
        function MD5(const Data:String):string;
        function UrlGetFormat(const Url:String; const Data:TGVar; const Sort:Boolean; const EqualOnEmpty:Boolean):String;
        function JSONDecode(const Data:string): TGVar;
        function JSONEncode(const Data:TGVar; const AllAsObject:Boolean; const AllAsString:Boolean): String;
        function Base64Encode(const Data: String) : String;
        function Base64Decode(const Data: String) : String;

        //11: Ficheros
        function ToFile(const Data:TGVar; const Filename:String; const ArrayKeys:Boolean):Boolean;
        function FromFile(const Filename:String; const AsArray:Boolean):TGVar;
        function IsFile(const FileName:String):Boolean;
        function IsDir(const Path:String):Boolean;
        function CreateDir(const Path:String):Boolean;
        function DeleteFile(const FileName:String):Boolean;
        function CopyFile(const Source:String; const Dest:String; const Overwrite:Boolean):Boolean;

        //12: HTTP
        function HTTP(const CookieManager:TGVar):TGVar;
        procedure HTTP_Conf(const HTTP:TIDHTTP;
        	const HandleRedirects:TGVar; const MaxAuthRetries:TGVar; const RedirectMaximum:TGVar;
            const ProxyAuthentication:TGVar; const ProxyPassword:TGVar; const ProxyPort:TGVar;const ProxyServer:TGVar; const ProxyUsername:TGVar;
            const Accept:TGVar; const AcceptCharSet:TGVar; const AcceptEncoding:TGVar; const AcceptLanguage:TGVar; const BasicAuthentication:TGVar;
            const CacheControl:TGVar; const Charset:TGVar; const Connection:TGVar; const ContentDisposition:TGVar; const ContentEncoding:TGVar;
            const ContentLanguage:TGVar; const ContentType:TGVar; const ContentVersion:TGVar; const CustomHeaders:TGVar; const Date:TGVar; const ETag:TGVar;
            const Expires:TGVar; const From:TGVar; const Host:TGVar; const LastModified:TGVar; const MethodOverride:TGVar; const Password:TGVar;
            const Pragma:TGVar; const ProxyConnection:TGVar; const Range:TGVar; const Ranges:TGVar; const Referer:TGVar; const TransferEncoding:TGVar;
            const UserAgent:TGVar; const Username:TGVar; const ContentLength:TGVar);
        function HTTP_Url(const HTTP:TIDHTTP; Url:string; const Params:TGVar; Verb:String):string;
        function HTTP_Download(const HTTP:TIDHTTP; Url:string; const FileName:string; const HTTP_Work:String):boolean;
        function HTTP_CookieGet(const HTTP:TIDHTTP; Name:string):string;
        procedure HTTP_CookiesClear(const HTTP:TIDHTTP);
        function HTTP_CookiesSessionGet(const HTTP:TIDHTTP):TGVar;
        procedure HTTP_CookiesSessionSet(const HTTP:TIDHTTP; const Session:TGVar);
        function HTTPCookie():tIdCookieManager;

    	//13: Sistema
    	{$IFDEF MSWINDOWS} function ProcessGet(const Resumed:Boolean):TGVar; {$ENDIF MSWINDOWS}
        {$IFDEF MSWINDOWS} procedure ProcesKillByPid(const Pid:integer); {$ENDIF MSWINDOWS}
        {$IFDEF MSWINDOWS} procedure ProcesKillByName(const Name:string); {$ENDIF MSWINDOWS}
        {$IFDEF MSWINDOWS} function ExeVersion(const Filename: string): string; {$ENDIF MSWINDOWS}
        {$IFDEF MSWINDOWS} procedure Exec(const Filename: string; const Params:string; WindowsState:string); {$ENDIF MSWINDOWS}
        {$IFDEF MSWINDOWS} procedure RegWriteStr(Section:string; const Path:string; const Key:string; const Value:string); {$ENDIF MSWINDOWS}
        {$IFDEF MSWINDOWS} procedure RegWriteBool(Section:string; const Path:string; const Key:string; const Value:Boolean); {$ENDIF MSWINDOWS}
        {$IFDEF MSWINDOWS} procedure RegWriteInt(Section:string; const Path:string; const Key:string; const Value:Integer); {$ENDIF MSWINDOWS}
        {$IFDEF MSWINDOWS} procedure RegDelete(Section:string; const Path:string; const Key:string); {$ENDIF MSWINDOWS}
        {$IFDEF MSWINDOWS} function RegReadStr(Section:string; const Path:string; const Key:string) : string; {$ENDIF MSWINDOWS}
		{$IFDEF MSWINDOWS} function RegReadBool(Section:string; const Path:string; const Key:string) : Boolean; {$ENDIF MSWINDOWS}
		{$IFDEF MSWINDOWS} function RegReadInt(Section:string; const Path:string; const Key:string) : Integer; {$ENDIF MSWINDOWS}
        {$IFDEF MSWINDOWS} procedure CreateLnk(const LnkFile:string; const LnkTarget: string); {$ENDIF MSWINDOWS}
end;

implementation


constructor TFQF.Create(const FQParent:TFQ);
begin
	//Definimos los valores default
       	Parent := FQParent;

    //Actualizamos los metodos
    	Methods := TDictionary<String, TRTTIMethod>.create;
        Params := TDictionary<String, TDictionary<Integer, String>>.create();
        ParamsT := TDictionary<String, TDictionary<Integer, String>>.create();
        Defaults := TDictionary<String, TDictionary<String, TGVar>>.create();

        UpdateMethods();
end;

destructor TFQF.Destroy();
var
	K,X:String;
begin
	//Limpiamos los objetos utilizados por el camino
		Methods.Free;

        for K in Params.keys do Params[K].Free;
        Params.Free;

        for K in ParamsT.keys do ParamsT[K].Free;
        ParamsT.Free;

        for K in Defaults.keys do begin
        	for X in Defaults[K].Keys do Defaults[K][x].Free;
            Defaults[K].Free;
        end;
        Defaults.Free;

        inherited;
end;

procedure TFQF.UpdateMethods();
var
	K:Integer;
	Current,CurrentT:TDictionary<Integer, String>;
	Contex: TRttiContext;
    Method:TRTTIMethod;
    Param:TRTTIParameter;
begin

	//Updateamos los metodos de FQF
        for Method in Contex.GetType(Self.ClassType).GetMethods do begin
			if (Method.Visibility = mvPublished) then begin

            	K := 0;
               	Current := TDictionary<Integer, String>.create;
                CurrentT := TDictionary<Integer, String>.create;
                for Param in Method.GetParameters do begin
                	Current.AddOrSetValue(K, Lowercase(Param.Name));
                    CurrentT.AddOrSetValue(K, Lowercase(Param.ParamType.ToString));
                    K := K + 1;
                end;

                Params.AddOrSetValue(LowerCase(Method.Name), Current);
                ParamsT.AddOrSetValue(LowerCase(Method.Name), CurrentT);
            	Methods.AddOrSetValue(LowerCase(Method.Name), Method);
                Defaults.AddOrSetValue(LowerCase(Method.Name), TDictionary<String, TGVar>.Create());
            end;
		end;

    //Seteamos los defaults para cada funcion que deba tenerlos... Telita fina

    	//06: Básicas
		Defaults['log'].Add('data', TGVar.create(''));
        Defaults['log'].Add('sort', TGVar.create(False));

        Defaults['fqsectionsaddasjson'].Add('resetscript', TGVar.create(False));
        Defaults['fqsectionsaddasjson'].Add('runmain', TGVar.create(True));
        Defaults['fqsectionsaddasjson'].Add('cryptkey', TGVar.create(''));
        Defaults['fqsectionsaddasjson'].Add('preventreprocess', TGVar.create(False));

        Defaults['return'].Add('data', TGVar.create('Default Value'));

        Defaults['isreg'].Add('arrayasreg', TGVar.create(True));

        Defaults['isobject'].Add('arrayasobject', TGVar.create(True));

        Defaults['isnum'].Add('decimal', TGVar.create(True));
        Defaults['isnum'].Add('negative', TGVar.create(True));

        Defaults['time'].Add('utc', TGVar.create(False));

        Defaults['date'].Add('format', TGVar.create('dd/mm/yy hh:nn:ss'));

        Defaults['datetotime'].Add('format', TGVar.create('dd/mm/yy hh:nn:ss'));
        Defaults['datetotime'].Add('dateseparator', TGVar.create('/'));

        //07: Strings
        Defaults['strpos'].Add('frompos', TGVar.create(0));

        Defaults['strord'].Add('splitter', TGVar.create(','));

        Defaults['dectohex'].Add('size', TGVar.create(1));

        Defaults['substr'].Add('frompos', TGVar.create(0));
        Defaults['substr'].Add('length', TGVar.create(-1));

        Defaults['split'].Add('splitter', TGVar.create(','));
        Defaults['split'].Add('casesensitive', TGVar.create(True));
        Defaults['split'].Add('limit', TGVar.create(-1));

        Defaults['substrcut'].Add('splitfrom', TGVar.create(''));
        Defaults['substrcut'].Add('splitto', TGVar.create(''));
        Defaults['substrcut'].Add('asarray', TGVar.create('0'));
        Defaults['substrcut'].Add('count', TGVar.create(-1));
        Defaults['substrcut'].Add('restifsplittonotfound', TGVar.create(False));
        Defaults['substrcut'].Add('casesensitive', TGVar.create(True));
        Defaults['substrcut'].Add('incfromsplitter', TGVar.create(False));
        Defaults['substrcut'].Add('inctosplitter', TGVar.create(False));

        //08: Array
        Defaults['keys'].Add('sort', TGVar.create(False));

		Defaults['arraytoline'].Add('splitter', TGVar.create('&'));
        Defaults['arraytoline'].Add('sort', TGVar.create(False));
        Defaults['arraytoline'].Add('equalonempty', TGVar.create(True));
        Defaults['arraytoline'].Add('urlencode', TGVar.create(False));

        Defaults['count'].Add('countifstring', TGVar.create(True));

        Defaults['arraykeysearch'].Add('casesensitive', TGVar.create(True));

        Defaults['arraykeyexist'].Add('casesensitive', TGVar.create(True));

        Defaults['arrayvaluesearch'].Add('casesensitive', TGVar.create(True));
        Defaults['arrayvaluesearch'].Add('allowmultipleresult', TGVar.create(False));

        Defaults['arrayvalueexist'].Add('casesensitive', TGVar.create(True));

        //09: Objetos

        //10: Util
        Defaults['urlgetformat'].Add('sort', TGVar.create(False));
        Defaults['urlgetformat'].Add('equalonempty', TGVar.create(True));

        Defaults['jsonencode'].Add('allasobject', TGVar.create(False));
        Defaults['jsonencode'].Add('allasstring', TGVar.create(False));

        //11: Files
        Defaults['tofile'].Add('arraykeys', TGVar.create(False));

        Defaults['fromfile'].Add('asarray', TGVar.create(False));

        Defaults['copyfile'].Add('overwrite', TGVar.create(True));


        //12: HTTP
  		Defaults['http'].Add('cookiemanager', TGVar.create());

        Defaults['http_conf'].Add('handleredirects', TGVar.CreateAsNil());
        Defaults['http_conf'].Add('maxauthretries', TGVar.CreateAsNil());
        Defaults['http_conf'].Add('redirectmaximum', TGVar.CreateAsNil());

        Defaults['http_conf'].Add('proxyauthentication', TGVar.CreateAsNil());
        Defaults['http_conf'].Add('proxypassword', TGVar.CreateAsNil());
        Defaults['http_conf'].Add('proxyport', TGVar.CreateAsNil());
        Defaults['http_conf'].Add('proxyserver', TGVar.CreateAsNil());
        Defaults['http_conf'].Add('proxyusername', TGVar.CreateAsNil());

        Defaults['http_conf'].Add('accept', TGVar.CreateAsNil());
        Defaults['http_conf'].Add('acceptcharset', TGVar.CreateAsNil());
        Defaults['http_conf'].Add('acceptencoding', TGVar.CreateAsNil());
        Defaults['http_conf'].Add('acceptlanguage', TGVar.CreateAsNil());
        Defaults['http_conf'].Add('basicauthentication', TGVar.CreateAsNil());
        Defaults['http_conf'].Add('cachecontrol', TGVar.CreateAsNil());
        Defaults['http_conf'].Add('charset', TGVar.CreateAsNil());
        Defaults['http_conf'].Add('connection', TGVar.CreateAsNil());
        Defaults['http_conf'].Add('contentdisposition', TGVar.CreateAsNil());
        Defaults['http_conf'].Add('contentencoding', TGVar.CreateAsNil());
        Defaults['http_conf'].Add('contentlanguage', TGVar.CreateAsNil());
        Defaults['http_conf'].Add('contenttype', TGVar.CreateAsNil());
        Defaults['http_conf'].Add('contentversion', TGVar.CreateAsNil());
        Defaults['http_conf'].Add('customheaders', TGVar.CreateAsNil());
        Defaults['http_conf'].Add('date', TGVar.CreateAsNil());
        Defaults['http_conf'].Add('etag', TGVar.CreateAsNil());
        Defaults['http_conf'].Add('expires', TGVar.CreateAsNil());
        Defaults['http_conf'].Add('from', TGVar.CreateAsNil());
        Defaults['http_conf'].Add('host', TGVar.CreateAsNil());
        Defaults['http_conf'].Add('lastmodified', TGVar.CreateAsNil());
        Defaults['http_conf'].Add('methodoverride', TGVar.CreateAsNil());
        Defaults['http_conf'].Add('password', TGVar.CreateAsNil());
        Defaults['http_conf'].Add('pragma', TGVar.CreateAsNil());
        Defaults['http_conf'].Add('proxyconnection', TGVar.CreateAsNil());
        Defaults['http_conf'].Add('range', TGVar.CreateAsNil());
        Defaults['http_conf'].Add('ranges', TGVar.CreateAsNil());
        Defaults['http_conf'].Add('referer', TGVar.CreateAsNil());
        Defaults['http_conf'].Add('transferencoding', TGVar.CreateAsNil());
        Defaults['http_conf'].Add('useragent', TGVar.CreateAsNil());
        Defaults['http_conf'].Add('username', TGVar.CreateAsNil());
        Defaults['http_conf'].Add('contentlength', TGVar.CreateAsNil());

        Defaults['http_url'].Add('params', TGVar.create(''));
        Defaults['http_url'].Add('verb', TGVar.create('default'));

        Defaults['http_download'].Add('http_work', TGVar.create(''));


        //13: Sistema
        {$IFDEF MSWINDOWS} Defaults['processget'].Add('resumed', TGVar.create(true)); {$ENDIF MSWINDOWS}

        {$IFDEF MSWINDOWS} Defaults['exec'].Add('params', TGVar.create('')); {$ENDIF MSWINDOWS}
        {$IFDEF MSWINDOWS} Defaults['exec'].Add('windowsstate', TGVar.create('normal')); {$ENDIF MSWINDOWS}

end;

function TFQF.Run(const Name:String; const Params:String; const Flow:TFlow):TGVar;
var
    ThreadLock:Boolean;
    Owned:Boolean;
    PID, K: String;
    SubFlow:TFlow;
    GVar:TGVar;
    EnvParams:string;
    TempRes:TValue;

	Elements:TDictionary<String, TGVar>;

    c:TRttiContext;
    m:TRTTIMethod;
    p:TRTTIParameter;

begin
	//Runeamos el FQF
    	Result := TGVar.create();

        PID := Parent.GetPid;
        Owned := False;
        ThreadLock := Parent.EFQFProxy_ThreadLock;
        Owned := false;

	//Y.. ¿que funcion tenemos que ejecutar?
	 	if (Assigned(Parent.OnLog)) then Parent.DoLog(Flow.GetCurrentLineName+'Command FQF FQFRUN ["'+Name+'"/"'+Params+'"]', 5);

        //Ahora miramos si se trata de una funcion exsitente en FQF
			if ((not Owned) and (Methods.ContainsKey(Name))) then begin
                Owned := true;
            	Elements := GetParams(Params, Flow, PID);

            	if (Assigned(Parent.OnStack)) then begin
                	EnvParams := '';

                    for K in Elements.Keys do
                        EnvParams := EnvParams + K + ':' + '"' + Elements[K].GetValue + '",';
                    EnvParams := EnvParams.Substring(0, EnvParams.Length-1);

                	Parent.DoStack(PID, Name, True, '', EnvParams, Flow.GetCurrentLineName());
                end;

                try
                	TempRes := nil;

                	TempRes := Methods[Name].Invoke(Self, PrepareArgs(Name, Elements, Flow, PID));
                    if (not TempRes.IsEmpty) then begin
                        if ((TempRes.TypeData <> nil) and (TempRes.TypeData.ClassType = TGVar)) then begin
                            Result.Free;

                            Result := TempRes.AsType<TGVar>;
                            Result.ObjectGive := True;

                        end else Result.SetT(TempRes);
                    end;

                except on E : Exception do begin
                	if (Assigned(Parent.OnLog)) then Parent.DoLog(Flow.GetCurrentLineName + 'FQF Exception: [' + E.ClassName + ': ' + E.Message + ']', 1);
                	Result.SetValue('');
                end; end;

                if (Assigned(Parent.OnStack)) then Parent.DoStack(PID, Name, False, Result.GetValue, EnvParams, Flow.GetCurrentLineName());

                for K in Elements.Keys do Elements[K].Free;
                Elements.Free;
            end;


        //Primero miramos si hay una funcion (Section) Que se llame asi por que entonces será eso
        if ((not Owned) and ((Parent.Script.ContainsKey(Name)) or (Parent.Script.ContainsKey(Flow.SectionName + ':' + Name)))) then begin
        	Owned := true;
            if (Parent.Script.ContainsKey(Name)) then
            	SubFlow := TFlow.Create(Flow.Parent, Name, Flow.GetCurrentLineName())
            else SubFlow := TFlow.Create(Flow.Parent, Flow.SectionName + ':' + Name, Flow.GetCurrentLineName());
            Elements := GetParams(Params, Flow, PID);
            SubFlow.DeclareEnv(Elements);

            Result.Free;

            SubFlow.Run();
            SubFlow.PreventFreeOfResult := True;

            Result := SubFlow.Result;

            Result.ObjectGive := True;

            SubFlow.Free;

            for K in Elements.Keys do Elements[K].Free;
            Elements.Free;
        end;

        //Y si no, se la pasaremos a la app owner a ver que dice
        if (not Owned) then begin
        	Elements := GetParams(Params, Flow, PID);
            if (Assigned(Parent.OnStack)) then begin
            	EnvParams := '';

                for K in Elements.Keys do
                	EnvParams := EnvParams + K + ':' + '"' + Elements[K].GetValue + '",';
                EnvParams := EnvParams.Substring(0, EnvParams.Length-1);
             end;
                TempRes := nil;

                TempRes := Parent.DoEFQF(Owned, Name, Elements);
                if ((TempRes.TypeData <> nil) and (TempRes.TypeData.ClassType = TGVar)) then begin
                	Result.Free;

                    Result := TempRes.AsType<TGVar>;
                    Result.ObjectGive := True;

                end else Result.SetT(TempRes);


            for K in Elements.Keys do Elements[K].Free;

            if (Assigned(Parent.OnStack)) then Parent.DoStack(PID, Name, False, Result.GetValue, EnvParams, Flow.GetCurrentLineName());

            Elements.Free;
        end;

        //No se ha owneado? emitimos un warning
        	if (not Owned) then begin
				if (Assigned(Parent.OnLog)) then Parent.DoLog(Flow.GetCurrentLineName + 'Error: Run ignored. Reason: Function not found. [' + Name + ']', 1);
            end;

    	//Si hay que enviarlo al proxy


    //Endeamos
end;

function TFQF.PrepareArgs(const Name:string; const Elements:TDictionary<String, TGVar>; const Flow:TFlow; const PID:String = '0'):TArray<TValue>;
var
	K:String;
    Setted,Needed,Item:Integer;
    ParamsPending: TDictionary<Integer, String>;
begin
    if ((not Params.ContainsKey(Name)) or (Params[Name].Count = 0)) then Exit;

    ParamsPending := TDictionary<Integer, String>.create(Params[Name]);
    Needed := ParamsPending.Count;

    //Seteamos los parametros
		SetLength(Result, ParamsPending.Count);

    //Asignamos los numericos by user
    	Item := 0;
		while (Elements.ContainsKey(IntToStr(Item))) and (ParamsPending.Count > 0) do begin
        	if (ParamsT[Name][Item] = 'tgvar') then Result[Item] := Elements[IntToStr(Item)].Clone()
            else if (ParamsT[Name][Item] = 'string') then Result[Item] := Elements[IntToStr(Item)].GetValue
            else if (ParamsT[Name][Item] = 'boolean') then Result[Item] := Elements[IntToStr(Item)].GetBool
            else if (ParamsT[Name][Item] = 'integer') then Result[Item] := Trunc(Elements[IntToStr(Item)].GetInt)
            else if (ParamsT[Name][Item] = 'double') then Result[Item] := Elements[IntToStr(Item)].GetNumeric
            else Result[Item] := Elements[IntToStr(Item)].GetT;

            ParamsPending.Remove(Item);
        	Item := Item + 1;
            Setted := Setted + 1;
        end;

    //Y ahora los que tengan nombre
    	Item := 0;
    	while (Item < Params[Name].Count) do begin
            if (Elements.ContainsKey(Params[Name][Item])) then begin
                if (ParamsT[Name][Item] = 'tgvar') then Result[Item] := Elements[Params[Name][Item]].Clone()
                else if (ParamsT[Name][Item] = 'string') then Result[Item] := Elements[Params[Name][Item]].GetValue
                else if (ParamsT[Name][Item] = 'boolean') then Result[Item] := Elements[Params[Name][Item]].GetBool
                else if (ParamsT[Name][Item] = 'integer') then Result[Item] := Trunc(Elements[Params[Name][Item]].GetInt)
                else if (ParamsT[Name][Item] = 'double') then Result[Item] := Elements[Params[Name][Item]].GetNumeric
                else Result[Item] := Elements[Params[Name][Item]].GetT;

                ParamsPending.Remove(Item);
				Setted := Setted + 1;
            end;

    		Item := Item + 1;
    	end;

    //Ponemos los autoasignables
    	Item := 0;
    	while ((Item < Params[Name].Count) and (ParamsPending.Count > 0)) do begin
			if (ParamsT[Name][Item] = 'tflow') then begin
            	Result[Item] := Flow;

                ParamsPending.Remove(Item);
				Setted := Setted + 1;
            end;

        	Item := Item + 1;
        end;

   	//Y las default values
    	Item := 0;
    	for Item in ParamsPending.Keys do begin
        	if (Setted = Needed) then break;

            if (Defaults[Name].ContainsKey(ParamsPending[Item])) then begin
                if (ParamsT[Name][Item] = 'tgvar') then Result[Item] := Defaults[Name][ParamsPending[Item]].Clone()
                else if (ParamsT[Name][Item] = 'string') then Result[Item] := Defaults[Name][ParamsPending[Item]].GetValue
                else if (ParamsT[Name][Item] = 'boolean') then Result[Item] := Defaults[Name][ParamsPending[Item]].GetBool
                else if (ParamsT[Name][Item] = 'integer') then Result[Item] := Trunc(Defaults[Name][ParamsPending[Item]].GetInt)
                else if (ParamsT[Name][Item] = 'double') then Result[Item] := Defaults[Name][ParamsPending[Item]].GetNumeric
                else Result[Item] := Defaults[Name][ParamsPending[Item]].GetT;
                Setted := Setted + 1;
            end;

        end;

    //Miramos si hay los parametros minimos asignados
	if (Setted <> Needed) then begin
		if (Assigned(Parent.OnLog)) then Parent.DoLog(Flow.GetCurrentLineName + 'Warning: Not found all expected params for function call [' + Name + ']', 2);
    end;
    ParamsPending.Free;
end;

function TFQF.GetParams(const Line: String; const Flow: TFlow; const PID:String = '0'): TDictionary<String, TGVar>;
var
	Name, Element, Extra:String;
    K, AnonCount, PosSplitter:Integer;
	Elements:TDictionary<Integer, String>;
    StringParams:String;
    GVar:TGVar;
    GrantOwnerObjet:Boolean;
begin

	Result := TDictionary<String, TGVar>.create;
	Elements := Parent.SplitOut(Line, [','], True, True, True, True);

    StringParams := '';
	AnonCount := 0;
	for K := 0 to Elements.count-1 do begin
    	GrantOwnerObjet := False;
        Element := Elements[K];
        PosSplitter := Parent.IndexOfOut(Element, [':'], True, True, True, False);
        Name := Element.substring(0, PosSplitter);
        Extra := Element.substring(PosSplitter + 1, Element.Length - Name.Length);
        if ((Extra.Length > 0) and (Extra.Chars[0] = '^')) then begin
			GrantOwnerObjet := True;
            Extra := Extra.Substring(1);
        end;


        if (Name = '') then begin
        	Name := IntToStr(AnonCount);
            AnonCount := AnonCount + 1;
        end;

        GVar := Flow.SolvePart(Extra);
     {   if (GVar.GVarType = 3) then begin
        	GVar.ObjectGive := True;
            GVar.ArrayMitosis(True);
        end;            }
        Result.AddOrSetValue(Name, GVar);

        if (Assigned(Parent.OnStack)) then begin
        	StringParams := StringParams + Name + ':"' + Result[Name].GetValue + '"';
        	if (K < Elements.count-1) then StringParams := StringParams + ', ';
        end;
    end;

    Elements.Free;
end;

function TFQF.GetParamsVariable(const Line: String; var Keys:TStringList; const Flow: TFlow; const PID:String = '0'): TDictionary<String, TGVar>;
var
	Name, NameLC, Element, Extra:String;
    K, AnonCount, PosSplitter:Integer;
	Elements:TDictionary<Integer, String>;
    StringParams:String;
    GrantOwnerObjet:Boolean;
    GVar:TGVar;
begin

	Result := TDictionary<String, TGVar>.create;
	Elements := Parent.SplitOut(Line, [','], True, True, True, True);

    StringParams := '';
	AnonCount := 0;
	for K := 0 to Elements.count-1 do begin
    	GrantOwnerObjet := False;
        Element := Elements[K];

        PosSplitter := Parent.IndexOfOut(Element, [':'], True, True, True, False);
        Name := Element.substring(0, PosSplitter);
        Extra := Element.substring(PosSplitter + 1, Element.Length - Name.Length);
        if ((Extra.Length > 0) and (Extra.Chars[0] = '^')) then begin
			GrantOwnerObjet := True;
            Extra := Extra.Substring(1);
        end;


        if (Name = '') then begin
        	Name := IntToStr(AnonCount);
            AnonCount := AnonCount + 1;
        end else begin
    		Name := Flow.SolvePart(Name, True).GetValue;
        end;

        NameLC := LowerCase(Name);

        Keys.Add(Name);

        GVar := Flow.SolvePart(Extra, False);
        if (GVar.GVarType = 3) then begin
        	GVar.ObjectGive := True;
            GVar.ArrayMitosis(True);
        end;
        Result.AddOrSetValue(NameLC, GVar);

        if (Assigned(Parent.OnStack)) then begin
        	StringParams := StringParams + NameLC + ':"' + Result[NameLC].GetValue + '"';
        	if (K < Elements.count-1) then StringParams := StringParams + ', ';
        end;
    end;

    Elements.Free;
end;

procedure TFQF.PrintArray(const Keys: TStringList; const Sort:Boolean; const Data:TDictionary<String, TGVar>; const Level: integer = 0; const Child:string = '');
var
	I:integer;
    K, Klc,Pad,EndLine:string;
    KeysShort:TStringList;
begin
	Pad := '';
    for I := 0 to Level do Pad := Pad + char(9);

    KeysShort := TStringList.Create;
    KeysShort.AddStrings(Keys);

    if (Sort) then KeysShort.Sort;

    I := 1;
    for K in KeysShort do begin
    	KLC := lowercase(K);
    	if (I < Keys.Count) then EndLine := ',' else EndLine := '';
    	if (Data[KLC].GVarType = 3) then begin
        	Parent.DoLog(Pad + '['+K+']' + ' = Array(', 7);
           	PrintArray(Data[KLC].ArrayKeys, Sort, Data[KLC].GetArray, Level + 1, Child + '['+K+']');
			Parent.DoLog(Pad + ')' + EndLine, 7);
        end else Parent.DoLog(Pad + '['+K+']' + ' = "' + Data[KLC].GetValue + '"' + EndLine, 7);

        I := I + 1;
    end;
    KeysShort.free;
end;

procedure TFQF.HTTP_Work_Internal(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
var
  Http: TIdHTTP;
  ContentLength: Int64;
  Percent: Integer;
  S:string;
begin
  Http := TIdHTTP(ASender);
  ContentLength := Http.Response.ContentLength;
  s := 'http_work';

  if (http.Name <> '') then s := s + ':' + http.name;

  if ((ContentLength > 0)) then  begin
    Percent := 100*AWorkCount div ContentLength;
    if parent.script.ContainsKey(s) then
		Parent.RunSection(S, inttostr(Percent)+',current:'+inttostr(AWorkCount)+',max:'+inttostr(ContentLength)).Free;
  end;
end;



///////////////////////////////////////////////////////////////////////////////////////////////////
///////
/////// 06: Básicas
///////

procedure TFQF.Log(const Data:TGVar; const Sort:Boolean; const Flow:TFlow);
begin
	if (Assigned(Parent.OnLog)) then begin
        if (Data.GVarType = 3) then begin
        	Parent.DoLog(Flow.GetCurrentLineName, 7);
        	Parent.DoLog('Array(', 7);
        	PrintArray(Data.ArrayKeys, Sort, Data.GetArray);
            Parent.DoLog(')', 7);
        end else Parent.DoLog(Flow.GetCurrentLineName + Data.GetValue, 7);
    end;

    Data.Free;
end;

procedure TFQF.FQSectionsAddAsJSON(const Data:String; const ResetScript:Boolean; const RunMain:Boolean; const CryptKey:String; const PreventReProcess:Boolean);
begin

	Parent.ScriptAddSectionsAsJSON(Data, ResetScript, RunMain, CryptKey, PreventReProcess);

end;

procedure TFQF.ThreadClose(const ThreadId:Integer);
begin

	Parent.ThreadLock_ThreadAdd.Acquire;
	if (Parent.Threads.ContainsKey(ThreadId)) then
        TFlow(TRunOnThread(Parent.Threads[ThreadId]).flow).StopThread := True;
	Parent.ThreadLock_ThreadAdd.Release;

end;

function TFQF.Return(const Data:string):String;
begin
	Result := 'Retorno: '+data;
end;

function TFQF.IsNull(const Data:TGVar):Boolean;
begin
	Result := False;
	if (Data.GVarType = 4) then Result := True;

    Data.Free;
end;

function TFQF.IsReg(const Data:TGVar; const ArrayAsReg:Boolean):Boolean;
begin
	Result := False;
	if (Data.GVarType = 1) or ((Data.GVarType = 3) and (ArrayAsReg))  then Result := True;

    Data.Free;
end;

function TFQF.IsArray(const Data:TGVar):Boolean;
begin
	Result := False;
	if (Data.GVarType = 3) then Result := True;

    Data.Free;
end;

function TFQF.IsObject(const Data:TGVar; const ArrayAsObject:Boolean):Boolean;
begin
	Result := False;
	if (Data.GVarType = 2) or ((Data.GVarType = 3) and (ArrayAsObject)) then Result := True;

    Data.Free;
end;

function TFQF.IsNum(const Data:TGVar; const Decimal:Boolean; const Negative:Boolean):Boolean;
    function OnlyChars(const Text: string; CharSet:TSysCharset): Boolean;
    var
        I:integer;
    begin
        Result := False;
        for I := 0 to Text.Length-1 do if (not CharInSet(Text.Chars[I], CharSet)) then exit;

        Result := True;
    end;
var
    Val:string;
    I:Integer;
begin
	Result := False;

    try
	    Val := Data.GetValue;
	    if (Val = '') then exit;
        if (Val.Length >= 15) then exit;

	    if (Val.Chars[0] = '-') then begin
	        Val := Val.Substring(1);
	        if (Val = '') then exit;
	        if (not Negative) then exit;
	    end;

	    I := Val.IndexOf(',');
	    if ((not Decimal) and (I >= 0)) then Exit;

	    if (Val.IndexOf(',', I+1) >= 0) then Exit;
	    if (not OnlyChars(Val, ['0'..'9', ','])) then exit;

	    Result := True;
    finally
	    Data.Free;
    end;
end;

function TFQF.Bool(const Data:TGVar):Boolean;
begin
	Result := Data.GetBool;
    Data.Free;
end;

procedure TFQF.Sleep(const Milis:Integer);
begin
	System.SysUtils.Sleep(Milis);
end;

function TFQF.Time(const UTC:Boolean):integer;
begin
	if (not UTC) then
    	Result := DateTimeToUnix(Now)
    else Result := DateTimeToUnix(TTimeZone.Local.ToUniversalTime(Now));
end;

function TFQF.TimeZoneOffset():integer;
begin
	Result := DateTimeToUnix(Now) - DateTimeToUnix(TTimeZone.Local.ToUniversalTime(Now));
end;

function TFQF.Date(const TimeStamp:integer; const Format:string):String;
begin
	Result := FormatDateTime(Format, UnixToDateTime(TimeStamp));
end;

function TFQF.DateToTime(const Data:string; const Format:string; const DateSeparator:string):Integer;
var
	FormatObj: TFormatSettings;
begin
	FormatObj := TFormatSettings.Create;
    FormatObj.LongDateFormat := Format;
    FormatObj.ShortDateFormat := Format;

    FormatObj.DateSeparator := DateSeparator.Chars[0];

    Result := DateTimeToUnix(StrToDateTime(Data, FormatObj));
end;


///////////////////////////////////////////////////////////////////////////////////////////////////
///////
/////// 07: Strings
///////

function TFQF.StrCount(const Data:TGVar):Integer;
begin
	Result := 0;

    if (Data.gvartype = 1) then
		Result := data.GetValue().Length;

    Data.Free;
end;

function TFQF.Chr(const Data:String; const Pos:integer):String;
begin
	Result := '';

    if ((Pos >= 0) and (Pos < Data.Length)) then
		Result := Data.Chars[Pos];
end;

function TFQF.StrToChars(const Data:String):TGVar;
var
	I:integer;
begin
	Result := TGVar.CreateAsArray();

    for I := 0 to Data.Length-1 do
		Result.SetArray(IntToStr(I), TGVar.Create(Data.Chars[I]));
end;

function TFQF.StrToUpper(const Data:String):String;
begin
	Result := UpperCase(data);
end;

function TFQF.StrToLower(const Data:String):String;
begin
	Result := LowerCase(data);
end;

function TFQF.DecToHex(const Data:Integer; const Size:Integer):String;
begin
	Result := IntToHex(Data, Size);
end;

function TFQF.HexToDec(const Data:String):Integer;
begin
	Result := StrToInt('$' + Data);
end;

function TFQF.StrPos(const Data:String; const Search:string; const FromPos:Integer):Integer;
begin
    Result := Data.IndexOf(Search, FromPos);
end;

function TFQF.NumTrunc(const Data:Double):Integer;
begin
    Result := Trunc(Data);
end;

function TFQF.NumRound(const Data:Double):Integer;
begin
	Result := Round(Data);
end;

function TFQF.Trim(const Data:String):String;
begin
	Result := Data.Trim;
end;

function TFQF.StrRev(const Data:String):String;
begin
	Result := ReverseString(Data);
end;

function TFQF.StrOrd(const Data:String; const Splitter:String):String;
var
	I:integer;
begin
	Result := '';
	for I := 0 to Data.Length-1 do begin
		Result := Result + IntToStr(ord(Data.Chars[I]));
        if (I < Data.Length-1) then Result := Result + Splitter;
    end;
end;

function TFQF.StrChar(const Data:Integer):String;
begin
	Result := char(Data);
end;

function TFQF.SubStr(const Data:String; const FromPos:Integer; Length:Integer):String;
begin
	if (Length = -1) then Length := Data.Length - FromPos;
	Result := Data.Substring(FromPos, Length);
end;

function TFQF.Split(Data:String; Splitter:string; const CaseSensitive:Boolean; const Limit:Integer):TGVar;
var
	Process:String;
	L,Pos,I:Integer;
begin
	Result := TGVar.CreateAsArray();

	if (not CaseSensitive) then begin
    	Splitter := LowerCase(Splitter);
        Process := LowerCase(Data);
    end else Process := Data;

    L := Data.Length;

    I := 0;
    while ((I < Limit) or (Limit = -1)) do begin
    	Pos := Process.IndexOf(Splitter);
		if (Pos < 0) then break;

        Result.SetArray(IntToStr(I), TGVar.Create(Data.Substring(0, Pos)));
        Data := Data.Substring(Pos + Splitter.Length);
        Process := Process.Substring(Pos + Splitter.Length);
        I := I + 1;
    end;

    Result.SetArray(IntToStr(I), TGVar.Create(Data));
end;

function TFQF.SubStrCut(const Data:String; SplitFrom:String; SplitTo:String; const AsArray:Boolean; const Count:Integer; const RestIfSplitToNotFound:Boolean; const CaseSensitive:Boolean; const IncFromSplitter:Boolean; const IncToSplitter:Boolean):TGVar;
	function SubStrCutR(var LastPos:integer; Data:String; SplitFrom:String; SplitTo:String; const RestIfSplitToNotFound:Boolean; const CaseSensitive:Boolean; const IncFromSplitter:Boolean; const IncToSplitter:Boolean):string;
    var
    	PreventToSplitter:Boolean;
        PosFrom, PosTo:integer;
    begin
        Result := Data;
        PreventToSplitter := false;

        if (not CaseSensitive) then begin
            Data := Lowercase(Data);
            SplitFrom := Lowercase(SplitFrom);
            SplitTo := Lowercase(SplitTo);
        end;

        if (SplitFrom = '') then
            PosFrom := 0
            else begin
            	PosFrom := Data.IndexOf(SplitFrom);
                if (PosFrom >= 0) then
                    PosFrom := PosFrom
                else begin
                    Result := '';
                    LastPos := Data.Length;
                    exit;
            end;
        end;

        LastPos := PosFrom;
        PosFrom := PosFrom + SplitFrom.Length;

        if (SplitTo = '') then
            PosTo := Data.Length - PosFrom
        else begin
            PosTo := Data.indexOf(SplitTo, PosFrom);
            if (PosTo >= 0) then
                PosTo := PosTo - PosFrom
            else begin
                if (not RestIfSplitToNotFound) then begin
                    Result := '';
                    LastPos := Data.Length;
                    Exit;
                end else begin
                	PosTo := Data.Length - PosFrom;
                    PreventToSplitter := true;
                end;
            end;
        end;

        LastPos := LastPos + PosTo + SplitTo.Length;
        //if (IncToSplitter) then PosTo := PosTo + SplitTo.Length;

        Result := Result.Substring(PosFrom, PosTo);
        if (IncFromSplitter) then Result := SplitFrom + Result;
        if ((IncToSplitter) and (not PreventToSplitter)) then Result := Result + SplitTo;
    end;
var
	I,L,T:Integer;
	SubStr, SubStrL:String;
	AllPos,LastPos:integer;
begin
	I := 0;
    L := Data.Length;
    LastPos := 0;
    AllPos := 0;

    if (not CaseSensitive) then begin
        SplitFrom := Lowercase(SplitFrom);
        SplitTo := Lowercase(SplitTo);
    end;

	if (AsArray) then begin
    	Result := TGVar.CreateAsArray;
    	while (((I < Count) or (Count = -1)) and (AllPos < L)) do begin
        	SubStr := Data.Substring(AllPos);
            if (not CaseSensitive) then SubStrL := Lowercase(SubStr) else SubStrL := Substr;
            T := SubStrL.IndexOf(SplitFrom);
        	if (SplitFrom <> '') and (T <= -1) then begin
            	AllPos := L;
                continue;
            end;
        	if (SplitTo <> '') and (not RestIfSplitToNotFound) and (SubStrL.Substring(T+SplitFrom.Length).IndexOf(SplitTo) <= -1) then begin
            	AllPos := L;
                continue;
            end;
        	Result.SetArray(IntToStr(I),
				TGVar.Create(SubStrCutR(LastPos, SubStr, SplitFrom, SplitTo, RestIfSplitToNotFound, CaseSensitive, IncFromSplitter, IncToSplitter))
            );
            AllPos := LastPos + AllPos;
            I := I + 1;
        end;
    end else begin
    	Result := TGVar.Create();
    	while ((I <= Count) or ((Count = -1) and (I = 0))) do begin

        	Result.SetValue(
				SubStrCutR(LastPos, Data.Substring(AllPos), SplitFrom, SplitTo, RestIfSplitToNotFound, CaseSensitive, IncFromSplitter, IncToSplitter)
            );

            AllPos := LastPos + AllPos;
            I := I + 1;
        end;
    end;
end;

///////////////////////////////////////////////////////////////////////////////////////////////////
///////
/////// 08: Arrays
///////

function TFQF.Keys(const Data:TGVar; const Sort:Boolean):TGVar;
var
	K:string;
    I:integer;
    List:TStringList;
begin
	Result := TGVar.CreateAsArray();
	if (Data.GVarType = 3) then begin
    	I := 0;
        List := TStringList.Create;
        List.AddStrings(Data.ArrayKeys);

        if (Sort) then List.Sort;


		for K in List do begin
            Result.SetArray(IntToStr(I), TGVar.CreateAsT(K));
            I := I +1;
        end;

        List.free;

    end;

    Data.Free;
end;

function TFQF.KSort(const Data:TGVar):TGVar;
begin

	Result := Data.Clone();

    if (Result.GVarType = 3) then
    	Result.ArrayKeys.sort;

    Data.Free;
end;

function TFQF.Count(const Data:TGVar; const CountIfString:Boolean):Integer;
begin
	Result := 0;
	if (Data.GVarType = 3) then Result := Data.GetArray.Count
    else if ((Data.gvartype = 1) and (CountIfString)) then
		Result := data.GetValue().Length;

    Data.Free;
end;

function TFQF.ArrayToLine(const Data:TGVar; const Splitter:string; const Sort:Boolean; const EqualOnEmpty:Boolean; const UrlEncode:Boolean):String;
var
	K,KLC:string;
    I:Integer;
	List:TStringList;
begin

	Result := Data.GetValue;
    List := TStringList.Create;

    if (Data.GVarType = 3) then begin
    	List.AddStrings(Data.ArrayKeys);
		if (Sort) then List.Sort;

        Result := '';
        I := 0;
        for K in List do begin
        	KLC := LowerCase(K);
        	if (UrlEncode) then begin
                if ((EqualOnEmpty) or (Data.GetArray[KLC].GetValue <> '')) then
                    Result := Result + UriEncode(k) + '=' + UriEncode(Data.GetArray[KLC].GetValue)
                else if (not EqualOnEmpty) then Result := Result + UriEncode(k);
            end else begin
                if ((EqualOnEmpty) or (Data.GetArray[KLC].GetValue <> '')) then
                    Result := Result + k + '=' + Data.GetArray[KLC].GetValue
                else if (not EqualOnEmpty) then Result := Result + k;
            end;

            if (I < list.Count-1) then Result := Result + Splitter;
            I := I + 1;
        end;

    end;

    List.Free;
    Data.Free;
end;

function TFQF.ArrayKeySearch(const Data:TGVar; Key:string; const CaseSensitive:Boolean):TGVar;
var
	K, KLC:string;
    KV:string;
begin
    //Buscamos un array
    Result := TGVar.Create;
    Result.SetNil;
    if (not CaseSensitive) then Key := LowerCase(Key);

   	for K in Data.ArrayKeys do begin
    	KLC := LowerCase(K);

        if (CaseSensitive) then KV := K
        else KV := KLC;

        if (KV = Key) then begin
        	Result.Free;
			Result := Data.GetArray[KLC].Duplicate;
        	Break;
        end;
    end;

    Data.Free;
end;


function TFQF.ArrayKeyExist(const Data:TGVar; Key:string; const CaseSensitive:Boolean):TGVar;
var
	K, KLC:string;
    KV:string;
begin
    //Buscamos un array
    Result := TGVar.Create(False);
    if (not CaseSensitive) then Key := LowerCase(Key);

   	for K in Data.ArrayKeys do begin
    	KLC := LowerCase(K);

        if (CaseSensitive) then KV := K
        else KV := KLC;

        if (KV = Key) then begin
			Result.setvalue(True);
        	Break;
        end;
    end;

    Data.Free;
end;

function TFQF.ArrayValueSearch(const Data:TGVar; Value:string; const CaseSensitive:Boolean; const AllowMultipleResult:Boolean):TGVar;
var
	K, KLC:string;
    KV:string;
    Found:Boolean;
    I:integer;
begin
    //Buscamos un array
    Found := False;
    if (not CaseSensitive) then Value := LowerCase(Value);
    if (AllowMultipleResult) then Result := TGVar.CreateAsArray()
    	else Result := TGVar.Create;

    I := 0;
   	for K in Data.ArrayKeys do begin
    	KLC := LowerCASE(K);

        if (CaseSensitive) then KV := Data.GetArray[KLC].GetValue
        else KV := LowerCase(Data.GetArray[KLC].GetValue);

        if (KV = Value) then begin
            if (not AllowMultipleResult) then  begin
            	Result.SetValue(K);
                Found := True;
                break;
            end else begin
                Result.SetArray(inttostr(I), TGVar.Create(K));
                I := I + 1;
            end;
        end;
    end;

    if ((not AllowMultipleResult) and (not Found)) then Result.SetNil;
    Data.Free;
end;

function TFQF.ArrayValueExist(const Data:TGVar; Value:string; const CaseSensitive:Boolean):TGVar;
var
	K, KLC:string;
    KV:string;
    I:integer;
begin
    //Buscamos un array
    if (not CaseSensitive) then Value := LowerCase(Value);
    Result := TGVar.Create(False);

    I := 0;
   	for K in Data.ArrayKeys do begin
    	KLC := LowerCASE(K);

        if (CaseSensitive) then KV := Data.GetArray[KLC].GetValue
        else KV := LowerCase(Data.GetArray[KLC].GetValue);

        if (KV = Value) then begin
        	Result.SetValue(True);
            break;
        end;
    end;

    Data.Free;
end;

///////////////////////////////////////////////////////////////////////////////////////////////////
///////
/////// 09: Objetos
///////

///////////////////////////////////////////////////////////////////////////////////////////////////
///////
/////// 10: Util
///////

function TFQF.Crypt(const CryptKey: String; const Data:String) : String;
var
   i : Integer;
   KeyLen : Integer;
begin
   KeyLen := CryptKey.Length;
   for i := 0 to CryptKey.Length do KeyLen := KeyLen xor Ord(CryptKey.Chars[i]);

   Result := '';

   for i := 0 to Data.Length do Result := Result + System.chr(not(ord(Data.Chars[i]) xor Ord(KeyLen)));
end;

function TFQF.Rand(const Min:Integer; const Max:Integer):integer;
begin
	Result := RandomRange(Min, Max + 1);
end;

function TFQF.MD5(const Data:String):string;
var
	IdHash: TIdHashMessageDigest5;
begin
	IdHash := TIdHashMessageDigest5.Create;
    Result :=  IdHash.HashStringAsHex (Data);
    IdHash.Free;
end;

function TFQF.UrlGetFormat(const Url:String; const Data:TGVar; const Sort:Boolean; const EqualOnEmpty:Boolean):String;
var
	Params:String;
begin
	Result := Url;
    if (Result = '') then begin data.Free; exit; end;

    Params := ArrayToLine(Data, '&', Sort, EqualOnEmpty, True);

    if (Params <> '') then begin
    	if (Result.IndexOf('?') < 0) then
        	Result := Result + '?';
        if ((Result.Chars[Result.Length-1] <> '?') and (Result.Chars[Result.Length-1] <> '&')) then Result := Result + '&';

        Result := Result + Params;
    end;
end;

function TFQF.Base64Encode(const Data: String) : String;
begin
	Result := EncodeString(Data);
end;

function TFQF.Base64Decode(const Data: String) : String;
begin
	Result := DecodeString(Data);
end;

function TFQF.JSONDecode(const Data:string): TGVar;
    function ClearLine(const Text:String): String;
    var
        I: Integer;
        C,L:Char;
        OnString:Boolean;
    begin
        Result := '';
        C := ' ';
        OnString := False;
        for I := 0 to Text.Length-1 do begin
            L := C;
        	C := Text.Chars[I];
            if (ord(Text.Chars[I]) >= 32) then begin
            	if ((not OnString) and (C = ' ')) then continue;
                if (C = '"') then begin
                	if not (L = '\') then
                    	OnString := not OnString;
                end;
            	Result := Result + C;
            end;
        end;
    end;
	function GetElement(const Element:TJSONValue): TGVar;
    var
    	K:integer;
        s:string;
    	SEo, B:TJSONPairEnumerator;
    	SEa:TJSONArrayEnumerator;
	begin
        if (Element is TJSONArray) then begin
        	K := 0;
            if (TJSONArray(Element).Count = 0) then begin
            	Result := TGVar.CreateAsArray();
                exit;
            end;
        	SEa := TJSONArray(Element).GetEnumerator;
            Result := TGVar.CreateAsArray();
            while (SEa.MoveNext) do begin Result.SetArray(IntToStr(K), GetElement(SEa.GetCurrent)); K := K + 1; end;
            SEa.Free;
        end else if (Element is TJSONObject) then begin
            SEo := TJSONObject(Element).GetEnumerator;
            Result := TGVar.CreateAsArray();
            while (SEo.MoveNext) do begin Result.SetArray(SEo.GetCurrent.JsonString.Value, GetElement(SEo.GetCurrent.JsonValue)); end;
            SEo.Free;
        end else begin
        	try
            	Result := TGVar.Create(TJSONString(Element).value);
            except
            	Result.free;
            	Result := TGVar.Create('');
            end;
        end;
	end;
var
    JV:TJSONValue;
    s:string;
begin
	JV := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(ClearLine(Data)),0) as TJSONObject;
    Result := GetElement(JV);
    {$IFDEF MSWINDOWS}
	   	jv.Destroy;
    {$ELSE}
		jv.Free;
    {$ENDIF}
end;

function TFQF.JSONEncode(const Data:TGVar; const AllAsObject:Boolean; const AllAsString:Boolean): String;
	function VarToJSON(const Data: TGVar; const AllAsObject:Boolean; const AllAsString:Boolean):TJSONValue;
    var
        JO:TJSONObject;
        JA:TJSONArray;
        K,KLC:string;
        I:integer;
        IsArray:boolean;
    begin
    	if (Data.GVarType = 3) then begin
        	//tenemos que mirar si es todo numerico para ver si crear o no
            IsArray := True;
            I := 0;
            if (AllAsObject) then IsArray := False
            else begin
                while (I < Data.ArrayKeys.Count) do begin
                    if (not Data.GetArray.ContainsKey(IntToStr(I))) then begin
                        IsArray := False;
                        break;
                    end;
                    I := I +1;
                end;
            end;

            if (not IsArray) then begin
                JO := TJSONObject.Create;
                for k in data.ArrayKeys do begin
                	KLC := LowerCase(K);
                    if (K <> '') then
	                    JO.AddPair(K, VarToJSON(Data.GetArray[KLC], AllAsObject, AllAsString))
                    else JO.AddPair('empty', VarToJSON(Data.GetArray[KLC], AllAsObject, AllAsString));
                end;
                Result := JO;
            end else begin
                JA := TJSONArray.Create;
                for I := 0 to data.ArrayKeys.Count-1 do begin
                    JA.AddElement(VarToJSON(Data.GetArray[IntToStr(I)], AllAsObject, AllAsString));
                end;
                Result := JA;
            end;
        end else begin
        	if ((not AllAsString) and (IsNum(Data.clone, True, True))) then
            	Result := TJSONNumber.Create(Data.GetNumeric)
            else Result := TJSONString.Create(Data.GetValue);
        end;

    end;
var
    JV:TJSONValue;
    b:TBytes;
    K:Integer;
begin
	jv := VarToJSON(Data, AllAsObject, AllAsString);
	SetLength(B, jv.EstimatedByteSize);
	K := jv.ToBytes(B, 0);
	Result := TEncoding.UTF8.GetString(b, 0, K);

    //if ((Result <> '') and (Result.Chars[0] <> '{')) then Result := '{'+Result+'}';
    Data.Free;
    {$IFDEF MSWINDOWS}
    	jv.Destroy;
    {$ELSE}
    	jv.Free;
    {$ENDIF}

end;


///////////////////////////////////////////////////////////////////////////////////////////////////
///////
/////// 11: Ficheros
///////

function TFQF.ToFile(const Data:TGVar; const Filename:String; const ArrayKeys:Boolean):Boolean;
var
	K, KLC:String;
	Text:String;
    Writer: TStreamWriter;
begin
    //Guardamos una variable a un fichero
    Text := '';
    if (Data.GVarType = 1) then Text := Data.GetValue
    else if (Data.GVarType = 3) then begin
    	for K in Data.ArrayKeys do begin
        	KLC := LowerCase(K);
        	if not ArrayKeys then
            	Text := Text + Data.GetArray[KLC].GetValue + char(13) + char(10)
            else Text := Text + K + '=' + Data.GetArray[KLC].GetValue + char(13) + char(10);
        end;
    end;

	if (TFile.Exists(Filename)) then TFile.Delete(Filename);

	Writer := TStreamWriter.Create(Filename, false, TEncoding.UTF8);
	Writer.Write(Text);

    if (TFile.Exists(Filename)) then  Result := True else Result := False;

    Writer.Free();
    Data.Free;
end;

function TFQF.FromFile(const Filename:String; const AsArray:Boolean):TGVar;
var
	I:Integer;
	S:String;
    FileStream:TFileStream;
	Reader: TStreamReader;
begin
	if (AsArray) then
        Result := TGVar.CreateAsArray()
    else Result := TGVar.Create();

	if (not TFile.Exists(Filename)) then exit;

    FileStream := TFileStream.Create(Filename, fmOpenRead or fmShareDenyNone);
    Reader := TStreamReader.Create(FileStream, TEncoding.UTF8, True);

    if (not AsArray) then
		Result.SetValue(Reader.ReadToEnd)
    else begin
    	I := 0;
    	while not Reader.EndOfStream do begin
        	Result.SetArray(IntToStr(I), TGVar.Create(Reader.ReadLine));
            I := I + 1;
        end;
	end;

    FileStream.Free;
    Reader.free;
end;

function TFQF.IsFile(const FileName:String):Boolean;
begin
	Result := TFile.Exists(FileName);
end;

function TFQF.IsDir(const Path:String):Boolean;
begin
	Result := TDirectory.Exists(Path);
end;

function TFQF.CreateDir(const Path:String):Boolean;
begin
	Result := False;
	if (TDirectory.Exists(Path)) then begin
    	Result := True;
        Exit;
    end;

	TDirectory.CreateDirectory(Path);
    if (TDirectory.Exists(Path)) then Result := True;
end;

function TFQF.DeleteFile(const FileName:String):Boolean;
begin
    Result := False;
    if (not TFile.Exists(Filename)) then begin
    	Result := True;
        Exit;
    end;

    TFile.Delete(Filename);
    if (not TFile.Exists(Filename)) then begin
    	Result := True;
        Exit;
    end;
end;

function TFQF.CopyFile(const Source:String; const Dest:String; const Overwrite:Boolean):Boolean;
begin

	Result := False;

	if (Overwrite) then DeleteFile(Dest);
	TFile.Copy(Source, Dest);

	if (TFile.Exists(Dest)) then Result := True;

end;


///////////////////////////////////////////////////////////////////////////////////////////////////
///////
/////// 12: HTTP
///////

function TFQF.HTTP(const CookieManager:TGVar):TGVar;
var
	HTTP:TIdHTTP;
begin
	Result := TGVar.Create();

	HTTP := TIdHTTP.create;
    Result.SetT(HTTP);

    if (CookieManager.GVarClass = 'tidcookiemanager') then
    	HTTP.CookieManager := CookieManager.GetT.AsType<tIdCookieManager>
    else begin
    	HTTP.CookieManager := tIdCookieManager.Create;
        Result.SetRelated(HTTP.CookieManager);
    end;

    HTTP.Compressor := TIdCompressorZLib.Create;
    HTTP.IOHandler := TIdSSLIOHandlerSocketOpenSSL.Create;

    HTTP.HTTPOptions := [hoForceEncodeParams, hoNoProtocolErrorException];
    HTTP.AllowCookies := true;
    HTTP.HandleRedirects := true;
    HTTP.RedirectMaximum := 5;


    Result.SetRelated(HTTP.Compressor);
    Result.SetRelated(HTTP.IOHandler);

    CookieManager.Free;
end;

procedure TFQF.HTTP_Conf(const HTTP:TIDHTTP;
			const HandleRedirects:TGVar; const MaxAuthRetries:TGVar; const RedirectMaximum:TGVar;
            const ProxyAuthentication:TGVar; const ProxyPassword:TGVar; const ProxyPort:TGVar;const ProxyServer:TGVar; const ProxyUsername:TGVar;
            const Accept:TGVar; const AcceptCharSet:TGVar; const AcceptEncoding:TGVar; const AcceptLanguage:TGVar; const BasicAuthentication:TGVar;
            const CacheControl:TGVar; const Charset:TGVar; const Connection:TGVar; const ContentDisposition:TGVar; const ContentEncoding:TGVar;
            const ContentLanguage:TGVar; const ContentType:TGVar; const ContentVersion:TGVar; const CustomHeaders:TGVar; const Date:TGVar; const ETag:TGVar;
            const Expires:TGVar; const From:TGVar; const Host:TGVar; const LastModified:TGVar; const MethodOverride:TGVar; const Password:TGVar;
            const Pragma:TGVar; const ProxyConnection:TGVar; const Range:TGVar; const Ranges:TGVar; const Referer:TGVar; const TransferEncoding:TGVar;
            const UserAgent:TGVar; const Username:TGVar; const ContentLength:TGVar);
var
	K, KLC:String;
begin

    if (not handleredirects.GetIsNil) then HTTP.HandleRedirects := handleredirects.GetBool();

    if (not maxauthretries.GetIsNil) then HTTP.MaxAuthRetries := maxauthretries.GetInt();
    if (not redirectmaximum.GetIsNil) then 	HTTP.redirectmaximum := redirectmaximum.GetInt();


    if (not proxyAuthentication.GetIsNil) then HTTP.ProxyParams.BasicAuthentication := ProxyAuthentication.GetBool;
    if (not proxypassword.GetIsNil) then HTTP.ProxyParams.ProxyPassword :=  proxypassword.GetValue;
    if (not proxyport.GetIsNil) then HTTP.ProxyParams.proxyport :=  proxyport.GetInt;
    if (not proxyserver.GetIsNil) then HTTP.ProxyParams.proxyserver :=  proxyserver.GetValue;
    if (not proxyusername.GetIsNil) then HTTP.ProxyParams.proxyusername :=  proxyusername.GetValue;

    if (not accept.GetIsNil) then HTTP.Request.accept := accept.GetValue;
    if (not acceptcharset.GetIsNil) then HTTP.Request.acceptcharset := acceptcharset.GetValue;
    if (not acceptencoding.GetIsNil) then HTTP.Request.acceptencoding := acceptencoding.GetValue;
    if (not acceptlanguage.GetIsNil) then HTTP.Request.acceptlanguage := acceptlanguage.GetValue;
    if (not basicauthentication.GetIsNil) then HTTP.Request.basicauthentication := basicauthentication.GetBool;
    if (not cachecontrol.GetIsNil) then HTTP.Request.cachecontrol := cachecontrol.GetValue;
    if (not charset.GetIsNil) then HTTP.Request.charset := charset.GetValue;
    if (not connection.GetIsNil) then HTTP.Request.Connection := connection.GetValue;
    if (not contentdisposition.GetIsNil) then HTTP.Request.contentdisposition := contentdisposition.GetValue;
    if (not contentencoding.GetIsNil) then HTTP.Request.ContentEncoding := contentencoding.GetValue;
    if (not contentlanguage.GetIsNil) then HTTP.Request.ContentLanguage := contentlanguage.GetValue;
    if (not contenttype.GetIsNil) then HTTP.Request.ContentType := contenttype.GetValue;
    if (not contentversion.GetIsNil) then HTTP.Request.ContentVersion := contentversion.GetValue;

    if (not customheaders.GetIsNil) then begin
    	if (customheaders.GVarType = 1) then
		    HTTP.Request.CustomHeaders.Text := customheaders.GetValue()
        else if (customheaders.GVarType = 3) then begin
        	HTTP.Request.CustomHeaders.Clear;
            for K in customHeaders.ArrayKeys do begin
    			KLC := LowerCase(K);
	            HTTP.Request.CustomHeaders.Add(K + ': '+customHeaders.GetArray[KLC].GetValue());
            end;
        end;
    end;

    if (not date.GetIsNil) then HTTP.Request.Date := UnixToDateTime(date.GetInt());
    if (not etag.GetIsNil) then HTTP.Request.etag := etag.GetValue;
    if (not expires.GetIsNil) then HTTP.Request.expires :=  UnixToDateTime(expires.GetInt());
    if (not from.GetIsNil) then HTTP.Request.from := from.GetValue;
    if (not host.GetIsNil) then HTTP.Request.host := host.GetValue;
    if (not lastmodified.GetIsNil) then HTTP.Request.LastModified := UnixToDateTime(lastmodified.GetInt());
    if (not methodoverride.GetIsNil) then HTTP.Request.MethodOverride := methodoverride.GetValue;
    if (not password.GetIsNil) then HTTP.Request.password := password.GetValue;
    if (not pragma.GetIsNil) then HTTP.Request.pragma := pragma.GetValue;
    if (not proxyconnection.GetIsNil) then HTTP.Request.ProxyConnection := proxyconnection.GetValue;
    if (not range.GetIsNil) then HTTP.Request.range := range.GetValue;
    //if (not ranges.GetIsNil) then HTTP.Request.Ranges :=  ;
    if (not referer.GetIsNil) then HTTP.Request.referer := referer.GetValue;
    if (not transferencoding.GetIsNil) then HTTP.Request.transferencoding := transferencoding.GetValue;
    if (not useragent.GetIsNil) then HTTP.Request.useragent := useragent.GetValue;
    if (not username.GetIsNil) then HTTP.Request.username := username.GetValue;
    if (not contentlength.GetIsNil) then HTTP.Request.contentlength := contentlength.GetInt;


    handleredirects.free;        maxauthretries.free;
    redirectmaximum.free;

    ProxyAuthentication.free;    proxypassword.free;            proxyport.free;
    proxyserver.free;            proxyusername.free;

    accept.free;                 acceptcharset.free;            acceptencoding.free;
    acceptlanguage.free;         basicauthentication.free;      cachecontrol.free;
    charset.free;                connection.free;               contentdisposition.free;
    contentencoding.free;        contentlanguage.free;          contenttype.free;
    contentversion.free;         customheaders.free;            date.free;
    etag.free;                   expires.free;                  from.free;
    host.free;                   lastmodified.free;             methodoverride.free;
    password.free;               pragma.free;                   proxyconnection.free;
    range.free;                  ranges.free;                   referer.free;
    transferencoding.free;       useragent.free;                username.free;
    contentlength.free;
end;

function TFQF.HTTP_Url(const HTTP:TIDHTTP; Url:string; const Params:TGVar; Verb:String):string;
var
	K, KLC:String;
	PostData: TIdMultiPartFormDataStream;
    PostDataL:TStringList;
begin
	Verb := LowerCase(Verb);

    if ((Verb <> 'default') and (Verb <> 'post') and (Verb <> 'get')) then begin
    	if (Assigned(Parent.OnLog)) then Parent.DoLog('[HTTPUrl] Invalid HTTP verb. Setted as default', 2);
        Verb := 'default';
	end;

	if (Verb = 'default') then
		if (Params.GVarType = 3) then Verb := 'post'
        else  Verb := 'get';

    if (Verb = 'get') then begin
        if (Params.GVarType = 1) and (Params.GetValue <> '') then begin
            if (Url.IndexOf('?') < 0) then Url := Url + '?';
        	if ((Url.Chars[Url.Length-1] <> '?') and (Url.Chars[Url.Length-1] <> '&')) then Url := Url + '&';
			Url := Url + Params.GetValue;
            Params.Free;
        end else if (Params.GVarType = 3) then begin
            UrlGetFormat(Url, Params, False, True);
        end else if ((Params.GVarType = 1) and (Params.GetValue <> '')) and (Assigned(Parent.OnLog)) then begin
        	Parent.DoLog('[HTTPUrl] Invalid params data', 2);
            Params.Free;
        end else Params.Free;
    end;

    if ((Verb = 'post') and (Params.GVarType = 3)) then begin
    	if (Params.GVarType = 3) then begin
            PostDataL := TStringList.Create;

            for K in Params.ArrayKeys do begin
            	KLC := LowerCase(K);
                if (Params.GetArray[KLC].GVarType = 1) then
                PostDataL.Add(K + '=' + Params.GetArray[KLC].GetValue);

            end;
        end else if (Params.GVarType = 1) and (Params.GetValue <> '') then begin
            if (Url.IndexOf('?') < 0) then Url := Url + '?';
        	if ((Url.Chars[Url.Length-1] <> '?') and (Url.Chars[Url.Length-1] <> '&')) then Url := Url + '&';
			Url := Url + Params.GetValue;
        end;
        Params.Free;
    end;

    if (Verb = 'post') then
    	Result := HTTP.Post(Url, PostDataL)
    else if (Verb = 'get') then
    	Result := HTTP.Get(Url);

    HTTP.Disconnect;
    if (Assigned(PostData)) then PostData.Free;
    if (Assigned(PostDataL)) then PostDataL.Free;
end;

function TFQF.HTTP_Download(const HTTP:TIDHTTP; Url:string; const FileName:string; const HTTP_Work:String):boolean;
var
	Stream: TMemoryStream;
begin
	Result := False;
	Stream := TMemoryStream.Create;
    try
    	Http.OnWork := HTTP_Work_Internal;

        Http.name := HTTP_Work;

        Http.Get(Url, Stream);

        if (Stream.Size > 0) and (HTTP.ResponseCode = 200) then begin
    	    Stream.SaveToFile(FileName);
        	Result := True;
        end;

    finally
		Stream.Free;
    end;
end;

function TFQF.HTTP_CookieGet(const HTTP:TIDHTTP; Name:string):string;
var
	I:integer;
begin
	Name := LowerCase(Name);

    Result := '';
    for I := 0 to HTTP.CookieManager.CookieCollection.Count - 1 do begin
    	if (LowerCase(HTTP.CookieManager.CookieCollection.Cookies[I].CookieName) = Name) then begin
        	Result := HTTP.CookieManager.CookieCollection.Cookies[I].Value;
        	break;
        end;
    end;
end;

procedure TFQF.HTTP_CookiesClear(const HTTP:TIDHTTP);
begin
	HTTP.CookieManager.CookieCollection.Clear;
end;

function TFQF.HTTP_CookiesSessionGet(const HTTP:TIDHTTP):TGVar;
begin
	Result := TGVar.Create();
    Result.SetT(TPersistent.Create());

	Result.SetRelated(TIdCookies.Create(Tpersistent(Result.GetT.AsType<TPersistent>)));

    Result.RelatedObjects[0].AsType<TIdCookies>.AddCookies(HTTP.CookieManager.CookieCollection);
end;

procedure TFQF.HTTP_CookiesSessionSet(const HTTP:TIDHTTP; const Session:TGVar);
begin
    HTTP.CookieManager.CookieCollection.AddCookies(Session.RelatedObjects[0].AsType<TIdCookies>);

    Session.Free;
end;

function TFQF.HTTPCookie():TIdCookieManager;
begin
	Result := TIdCookieManager.Create;
end;



///////////////////////////////////////////////////////////////////////////////////////////////////
///////
/////// 13: Sistema
///////
{$IFDEF MSWINDOWS}
function TFQF.ProcessGet(const Resumed:Boolean):TGVar;
var
   ContinueLoop: Boolean;
   I:Integer;
   s:string;
   GVar:TGVar;
   FSnapshotHandle: THandle;
   FProcessEntry32: TProcessEntry32;
begin
	Result := TGVar.CreateAsArray();

	FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
	FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
	ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);

	I := 0;
	while Integer(ContinueLoop) <> 0 do begin
    	S := FProcessEntry32.szExeFile;

        if (not Resumed) then begin
            GVar := TGVar.CreateAsArray();
            GVar.SetArray('pid', TGVar.Create(FProcessEntry32.th32ProcessID));
            GVar.SetArray('name', TGVar.Create(S));
            GVar.SetArray('threads', TGVar.Create(FProcessEntry32.cntThreads));
            GVar.SetArray('priority', TGVar.Create(FProcessEntry32.pcPriClassBase));
            GVar.SetArray('parent', TGVar.Create(FProcessEntry32.th32ParentProcessID));
            Result.SetArray(inttostr(i), GVar);

        end else begin
            Result.SetArray(inttostr(FProcessEntry32.th32ProcessID), TGVar.Create(s));
        end;


		ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
		I := I +1;
   end;
end;
{$ENDIF MSWINDOWS}

{$IFDEF MSWINDOWS}
procedure TFQF.ProcesKillByPid(const Pid:integer);
var
   lpMsgBuf: THandle;
   exitcode:integer;
   x:THandle;
begin
	x := Openprocess(PROCESS_TERMINATE,false,PID);
	if x <> 0 then begin
    	try
			TerminateProcess(x, 0);
		finally
			CloseHandle(x);
		end;
	end else begin
		FormatMessage(
			FORMAT_MESSAGE_ALLOCATE_BUFFER or FORMAT_MESSAGE_FROM_SYSTEM,
			nil, GetLastError(), 0, PChar(@lpMsgBuf), 0, nil);
     LocalFree(lpMsgBuf);
   end;
end;
{$ENDIF MSWINDOWS}

{$IFDEF MSWINDOWS}
procedure TFQF.ProcesKillByName(const Name:string);
var
	K:string;
	GVar: TGVar;
begin
	GVar := ArrayValueSearch(ProcessGet(True), Name, false, true);

    for K in GVar.ArrayKeys do
		ProcesKillByPid(GVar.GetArray[K].GetInt);

    GVar.Free;
end;
{$ENDIF MSWINDOWS}

{$IFDEF MSWINDOWS}
function TFQF.ExeVersion(const Filename: string): string;
var
	n, Len : cardinal;
	Buf, Value : PChar;
begin
	Result := '';
    if (not TFile.Exists(Filename)) then exit;

	n := GetFileVersionInfoSize(PChar(Filename),n);
	if n > 0 then begin
		Buf := AllocMem(n);
		try
			GetFileVersionInfo(PChar(Filename),0,n,Buf);
			if (VerQueryValue(Buf,PChar('StringFileInfo\040904E4\FileVersion'),Pointer(Value),Len)) then
				Result := Trim(Value);
		finally
			FreeMem(Buf,n);
		end;
	end;
end;
{$ENDIF MSWINDOWS}

{$IFDEF MSWINDOWS}
procedure TFQF.Exec(const Filename: string; const Params:string; WindowsState:string);
begin
    WindowsState := LowerCase(WindowsState);

	if (WindowsState = 'normal') then
		ShellExecute(0 , 'open', PChar(Filename), PChar(Params), nil, SW_SHOWNORMAL)
    else if (WindowsState = 'minimized') then
    	ShellExecute(0 , 'open', PChar(Filename), PChar(Params), nil, SW_SHOWMINIMIZED)
    else if (WindowsState = 'maximized') then
    	ShellExecute(0 , 'open', PChar(Filename), PChar(Params), nil, SW_SHOWMAXIMIZED)
    else if (WindowsState = 'hidden') then
    	ShellExecute(0 , 'open', PChar(Filename), PChar(Params), nil, SW_HIDE)
    else ShellExecute(0 , 'open', PChar(Filename), PChar(Params), nil, SW_SHOWNORMAL);
end;
{$ENDIF MSWINDOWS}

{$IFDEF MSWINDOWS}
procedure TFQF.RegWriteStr(Section:string; const Path:string; const Key:string; const Value:string);
begin

	try with TRegIniFile.Create('') do try

    	Section := UpperCase(Section);

        if (Section = 'HKEY_CLASSES_ROOT') then RootKey := HKEY_CLASSES_ROOT
        else if (Section = 'HKEY_CURRENT_USER') then RootKey := HKEY_CURRENT_USER
        else if (Section = 'HKEY_LOCAL_MACHINE') then RootKey := HKEY_LOCAL_MACHINE
        else if (Section = 'HKEY_USERS') then RootKey := HKEY_USERS
        else if (Section = 'HKEY_PERFORMANCE_DATA') then RootKey := HKEY_PERFORMANCE_DATA
        else if (Section = 'HKEY_CURRENT_CONFIG') then RootKey := HKEY_CURRENT_CONFIG
        else if (Section = 'HKEY_DYN_DATA') then RootKey := HKEY_DYN_DATA;

       WriteString(Path + #0, Key, Value);

	finally	Free; end;
	except
	end;
end;
{$ENDIF MSWINDOWS}

{$IFDEF MSWINDOWS}
procedure TFQF.RegWriteBool(Section:string; const Path:string; const Key:string; const Value:Boolean);
begin
	try with TRegIniFile.Create('') do try

    	Section := UpperCase(Section);

        if (Section = 'HKEY_CLASSES_ROOT') then RootKey := HKEY_CLASSES_ROOT
        else if (Section = 'HKEY_CURRENT_USER') then RootKey := HKEY_CURRENT_USER
        else if (Section = 'HKEY_LOCAL_MACHINE') then RootKey := HKEY_LOCAL_MACHINE
        else if (Section = 'HKEY_USERS') then RootKey := HKEY_USERS
        else if (Section = 'HKEY_PERFORMANCE_DATA') then RootKey := HKEY_PERFORMANCE_DATA
        else if (Section = 'HKEY_CURRENT_CONFIG') then RootKey := HKEY_CURRENT_CONFIG
        else if (Section = 'HKEY_DYN_DATA') then RootKey := HKEY_DYN_DATA;

        WriteBool(Path + #0, Key, Value);

	finally	Free; end;
	except
	end;
end;
{$ENDIF MSWINDOWS}

{$IFDEF MSWINDOWS}
procedure TFQF.RegWriteInt(Section:string; const Path:string; const Key:string; const Value:Integer);
begin
	try with TRegIniFile.Create('') do try

    	Section := UpperCase(Section);

        if (Section = 'HKEY_CLASSES_ROOT') then RootKey := HKEY_CLASSES_ROOT
        else if (Section = 'HKEY_CURRENT_USER') then RootKey := HKEY_CURRENT_USER
        else if (Section = 'HKEY_LOCAL_MACHINE') then RootKey := HKEY_LOCAL_MACHINE
        else if (Section = 'HKEY_USERS') then RootKey := HKEY_USERS
        else if (Section = 'HKEY_PERFORMANCE_DATA') then RootKey := HKEY_PERFORMANCE_DATA
        else if (Section = 'HKEY_CURRENT_CONFIG') then RootKey := HKEY_CURRENT_CONFIG
        else if (Section = 'HKEY_DYN_DATA') then RootKey := HKEY_DYN_DATA;

        WriteInteger(Path + #0, Key, Value);

	finally	Free; end;
	except
	end;
end;
{$ENDIF MSWINDOWS}

{$IFDEF MSWINDOWS}
function TFQF.RegReadStr(Section:string; const Path:string; const Key:string) :  string;
begin

	try with TRegIniFile.Create('') do try

    	Section := UpperCase(Section);

        if (Section = 'HKEY_CLASSES_ROOT') then RootKey := HKEY_CLASSES_ROOT
        else if (Section = 'HKEY_CURRENT_USER') then RootKey := HKEY_CURRENT_USER
        else if (Section = 'HKEY_LOCAL_MACHINE') then RootKey := HKEY_LOCAL_MACHINE
        else if (Section = 'HKEY_USERS') then RootKey := HKEY_USERS
        else if (Section = 'HKEY_PERFORMANCE_DATA') then RootKey := HKEY_PERFORMANCE_DATA
        else if (Section = 'HKEY_CURRENT_CONFIG') then RootKey := HKEY_CURRENT_CONFIG
        else if (Section = 'HKEY_DYN_DATA') then RootKey := HKEY_DYN_DATA;

		Result := ReadString(Path + #0, Key, '');

	finally	Free; end;
	except
	end;
end;
{$ENDIF MSWINDOWS}

{$IFDEF MSWINDOWS}
function TFQF.RegReadBool(Section:string; const Path:string; const Key:string) : Boolean;
begin
	try with TRegIniFile.Create('') do try

    	Section := UpperCase(Section);

        if (Section = 'HKEY_CLASSES_ROOT') then RootKey := HKEY_CLASSES_ROOT
        else if (Section = 'HKEY_CURRENT_USER') then RootKey := HKEY_CURRENT_USER
        else if (Section = 'HKEY_LOCAL_MACHINE') then RootKey := HKEY_LOCAL_MACHINE
        else if (Section = 'HKEY_USERS') then RootKey := HKEY_USERS
        else if (Section = 'HKEY_PERFORMANCE_DATA') then RootKey := HKEY_PERFORMANCE_DATA
        else if (Section = 'HKEY_CURRENT_CONFIG') then RootKey := HKEY_CURRENT_CONFIG
        else if (Section = 'HKEY_DYN_DATA') then RootKey := HKEY_DYN_DATA;

        Result := ReadBool(Path + #0, Key, False);

	finally	Free; end;
	except
	end;
end;
{$ENDIF MSWINDOWS}

{$IFDEF MSWINDOWS}
function TFQF.RegReadInt(Section:string; const Path:string; const Key:string) : Integer;
begin
	try with TRegIniFile.Create('') do try

    	Section := UpperCase(Section);

        if (Section = 'HKEY_CLASSES_ROOT') then RootKey := HKEY_CLASSES_ROOT
        else if (Section = 'HKEY_CURRENT_USER') then RootKey := HKEY_CURRENT_USER
        else if (Section = 'HKEY_LOCAL_MACHINE') then RootKey := HKEY_LOCAL_MACHINE
        else if (Section = 'HKEY_USERS') then RootKey := HKEY_USERS
        else if (Section = 'HKEY_PERFORMANCE_DATA') then RootKey := HKEY_PERFORMANCE_DATA
        else if (Section = 'HKEY_CURRENT_CONFIG') then RootKey := HKEY_CURRENT_CONFIG
        else if (Section = 'HKEY_DYN_DATA') then RootKey := HKEY_DYN_DATA;

        Result := ReadInteger(Path + #0, Key, 0);

	finally	Free; end;
	except
	end;
end;
{$ENDIF MSWINDOWS}


{$IFDEF MSWINDOWS}
procedure TFQF.RegDelete(Section:string; const Path:string; const Key:string);
begin
	try with TRegIniFile.Create('') do try

    	Section := UpperCase(Section);

        if (Section = 'HKEY_CLASSES_ROOT') then RootKey := HKEY_CLASSES_ROOT
        else if (Section = 'HKEY_CURRENT_USER') then RootKey := HKEY_CURRENT_USER
        else if (Section = 'HKEY_LOCAL_MACHINE') then RootKey := HKEY_LOCAL_MACHINE
        else if (Section = 'HKEY_USERS') then RootKey := HKEY_USERS
        else if (Section = 'HKEY_PERFORMANCE_DATA') then RootKey := HKEY_PERFORMANCE_DATA
        else if (Section = 'HKEY_CURRENT_CONFIG') then RootKey := HKEY_CURRENT_CONFIG
        else if (Section = 'HKEY_DYN_DATA') then RootKey := HKEY_DYN_DATA;

        DeleteKey(Path + #0, Key)
	finally	Free; end;
	except
	end;
end;
{$ENDIF MSWINDOWS}

{$IFDEF MSWINDOWS}
procedure TFQF.CreateLnk(const LnkFile:string; const LnkTarget: string);
var
	IObject: IUnknown;
	ISLink: IShellLink;
	IPFile: IPersistFile;
	PIDL: PItemIDList;
	LinkName: string;
	InFolder: array [0..MAX_PATH-1] of Char;
begin
  IObject := CreateComObject(CLSID_ShellLink);
  ISLink := IObject as IShellLink;
  IPFile := IObject as IPersistFile;

  with ISLink do
  begin
    SetDescription('Description ...');
    SetPath(PChar(LnkTarget));
    SetWorkingDirectory(PChar(ExtractFilePath(LnkTarget)));
  end;


  if FileExists(LnkFile) then DeleteFile(LnkFile);
  IPFile.Save(PWideChar(LnkFile), False);
end;
{$ENDIF MSWINDOWS}


end.

