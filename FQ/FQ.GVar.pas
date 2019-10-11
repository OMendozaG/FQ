unit FQ.GVar;

interface

uses
	System.SysUtils, System.Classes, System.Variants, Generics.Collections, RTTI;

type TGVar = class
	public
    	Data: TValue;

        GVarType: Integer;
        GVarClass:String;

        FreeOnGet: Boolean;
        ObjectOwner:Boolean;
        ObjectGive:Boolean;

        RelatedObjects:TDictionary<Integer, TValue>;

        ArrayKeys:TStringList;
        constructor Create(); overload;
        constructor Create(const Data:Variant; const DestroyOnGet:Boolean = False; const GiveOwneringOnAssign:Boolean = False); overload;
        constructor CreateAsNil(const DestroyOnGet:Boolean = False; const GiveOwneringOnAssign:Boolean = False);
        constructor CreateAsT(const Data:TValue; const DestroyOnGet:Boolean = False; const GiveOwneringOnAssign:Boolean = False);
        constructor CreateAsArray(const DestroyOnGet:Boolean = False; const GiveOwneringOnAssign:Boolean = False); overload;
        constructor CreateAsArray(const ArrayData:TDictionary<String, TGVar>; const KeysOrder:TStringList; const DestroyOnGet:Boolean = False; const GiveOwneringOnAssign:Boolean = False); overload;
        destructor Destroy(); override;

        procedure Assign(From:TGVar);
        function Clone(const DestroyOnGet:Boolean = False; const GiveOwneringOnAssign:Boolean = False): TGVar;
        function Duplicate(const DestroyOnGet:Boolean = False; const GiveOwneringOnAssign:Boolean = False): TGVar;

        function ArrayMitosis(const Recursive:Boolean=False):Boolean;
        procedure ClearData(WantPrepare: Boolean = True);
        procedure PrepareVar();

        procedure CreateArray();

        procedure SetT(const T: TValue; const VarType:Integer = 0; const SetObjectOwner:Boolean = True);
        procedure SetValue(const Data:Variant);
        procedure SetNil();

        function GetT():TValue;
        function GetValue(const PreventSelfFree:Boolean = False):String;
        function GetBool(const PreventSelfFree:Boolean = False):Boolean;
        function GetInt(const PreventSelfFree:Boolean = False):Integer;
        function GetNumeric(const PreventSelfFree:Boolean = False):Double;
        function GetIsNil(const PreventSelfFree:Boolean = False):Boolean;
        function GetArray(const PreventSelfFree:Boolean = False):TDictionary<String, TGVar>;
        procedure SetArray(const Key:String; const GVar:TGVar);
        procedure RemoveArray(const Key:String);
        procedure SetRelated(const T:TValue);

    private

end;

implementation

/////////////////////////////////////////
//
// Var type
//
//		1: String
//		2: Object
//      3: Array (TDictionary<String, TGVar>)
//
// Var Class
//

constructor TGVar.Create();
begin
	//Una vacía pero con sef-destroy
        ClearData();

        FreeOnGet := False;
        ObjectGive := False;
end;

constructor TGVar.Create(const Data:Variant; const DestroyOnGet:Boolean = False; const GiveOwneringOnAssign:Boolean = False);
begin
	//Una vacía pero con sef-destroy
        ClearData();

        SetValue(Data);

        FreeOnGet := DestroyOnGet;
        ObjectGive := GiveOwneringOnAssign;
end;

constructor TGVar.CreateAsNil(const DestroyOnGet:Boolean = False; const GiveOwneringOnAssign:Boolean = False);
begin
	//Una vacía pero con sef-destroy
        ClearData();

        SetNil;
end;

constructor TGVar.CreateAsT(const Data:TValue; const DestroyOnGet:Boolean = False; const GiveOwneringOnAssign:Boolean = False);
begin
	//Una desde una variant
        ClearData();

    	SetT(Data);

        FreeOnGet := DestroyOnGet;
        ObjectGive := GiveOwneringOnAssign;
end;

constructor TGVar.CreateAsArray(const DestroyOnGet:Boolean = False; const GiveOwneringOnAssign:Boolean = False);
begin
	//Una desde una variant
		CreateArray();

        FreeOnGet := DestroyOnGet;
        ObjectGive := GiveOwneringOnAssign;
end;

constructor TGVar.CreateAsArray(const ArrayData:TDictionary<String, TGVar>; const KeysOrder:TStringList; const DestroyOnGet:Boolean = False; const GiveOwneringOnAssign:Boolean = False);
var
	K:string;
begin
	//Una desde una variant
    	ClearData();

        SetT(ArrayData, 3);
        ArrayKeys.Clear;
        ArrayKeys.AddStrings(KeysOrder);


        FreeOnGet := DestroyOnGet;
        ObjectGive := GiveOwneringOnAssign;
end;


destructor TGVar.Destroy();
begin
	//Limpiamos los objetos utilizados por el camino
        ClearData(False);

        inherited;
end;

procedure TGVar.Assign(From:TGVar);
begin

	ClearData();

    GVarClass := From.GVarClass;

    if (From.GVarType = 3) then  begin
    	SetT(From.Data, From.GVarType, False);

    	if ((From.ObjectGive) and (From.ObjectOwner)) then begin
        	ArrayKeys := TStringList.Create;
            ArrayKeys.AddStrings(From.ArrayKeys);

            From.ArrayKeys.Free;
            From.ArrayKeys := ArrayKeys;

            From.ObjectOwner := False;
            ObjectOwner := True;

            From.ObjectGive := False;

        end else begin
        	ArrayKeys := From.ArrayKeys;
    	end;

    end else if (From.GVarType = 2) then  begin
    	SetT(From.Data, From.GVarType, False);

    	if ((From.ObjectGive) and (From.ObjectOwner)) then begin
        	RelatedObjects := TDictionary<Integer, TValue>.Create(From.RelatedObjects);
            From.RelatedObjects.Free;
            ObjectGive := False;
            From.ObjectOwner := False;
            ObjectOwner := True;
        end else RelatedObjects := From.RelatedObjects;

    end else if (From.GVarType = 4) then SetNil()
	else if (From.GVarType = 1) then SetValue(From.Data.AsString);
             

    if (From.FreeOnGet) then From.Free;

end;

function TGVar.Clone(const DestroyOnGet:Boolean = False; const GiveOwneringOnAssign:Boolean = False): TGVar;
begin
	Result := TGVar.Create();
    Result.Assign(Self);

    Result.FreeOnGet := DestroyOnGet;
    Result.ObjectGive := GiveOwneringOnAssign;
end;

function TGVar.Duplicate(const DestroyOnGet:Boolean = False; const GiveOwneringOnAssign:Boolean = False): TGVar;
begin
	Result := TGVar.Create();
    Result.Assign(Self);

    Result.ArrayMitosis(True);

    Result.FreeOnGet := DestroyOnGet;
    Result.ObjectGive := GiveOwneringOnAssign;
end;

procedure TGVar.ClearData(WantPrepare: Boolean = True);
var
	I:integer;
	K:String;
begin
	if (GVarType = 3) then begin
    	if (ObjectOwner) then begin
            for K in Data.AsType<TDictionary<String, TGVar>>.Keys do
                Data.AsType<TDictionary<String, TGVar>>[K].Free;

	        Data.AsType<TDictionary<String, TGVar>>.Free;
            ArrayKeys.Free;
        end;
    end;

	if ((ObjectOwner) and (GVarType = 2)) then begin
        for I in RelatedObjects.keys do RelatedObjects[i].AsObject.free;
        RelatedObjects.free;
        Data.AsObject.free;
    end;

    ObjectGive := False;
    ObjectOwner := True;
	Data := '';
    GVarClass := '';
	GVarType := 1;

    if (WantPrepare) then PrepareVar();
end;

procedure TGVar.PrepareVar();
var
	I:integer;
	K:String;
begin

    ObjectGive := False;
    ObjectOwner := True;

	Data := '';
    GVarClass := '';
	GVarType := 1;
end;

function TGVar.ArrayMitosis(const Recursive:Boolean=False):Boolean;
var
	K,KLC:String;
    From:TDictionary<String, TGVar>;
    FromKeys:TStringList;
begin
	Result := False;

	if ((GVarType = 3) and (not ObjectOwner)) then begin
        Result := True;
        From := GetArray();
        FromKeys := ArrayKeys;

        Data :=  TDictionary<String, TGVar>.Create();
        ArrayKeys := TStringList.Create();
        ArrayKeys.AddStrings(FromKeys);

        for K in FromKeys do begin
        	KLC := LowerCase(K);
            if (Recursive) then
            	Data.AsType<TDictionary<String, TGVar>>.Add(KLC, From[KLC].Duplicate)
            else Data.AsType<TDictionary<String, TGVar>>.Add(KLC, From[KLC].Clone)
        end;
        ObjectOwner := True;
    end;
end;

procedure TGVar.SetT(const T: TValue; const VarType:Integer = 0; const SetObjectOwner:Boolean = True);
var
	V:Variant;
    P:Pointer;
    K:String;
begin
	if (((VarType = 1) or (VarType = 0)) and ((not T.IsObject) and (T.TryAsType<Variant>(V)))) then begin

		SetValue(T.AsVariant);

	end else if (VarType = 3) then begin
		ClearData;
        GVarType := 3;

        Data := T;
        ObjectOwner := SetObjectOwner;

        if (ObjectOwner) then begin
            ArrayKeys := TStringList.Create;
            for K in Data.AsType<TDictionary<String,TGVar>>.Keys do ArrayKeys.Add(K);
        end;

    end else if ((VarType = 0) or (VarType = 2)) then begin
    	ClearData;
		GVarType := 2;

        ObjectOwner := SetObjectOwner;

    	if (T.TypeData <> nil) then
        	GVarClass := lowercase(T.TypeData.ClassType.ClassName) else GVarClass := '';

        Data := T;
        if (ObjectOwner) then RelatedObjects := TDictionary<Integer, TValue>.Create();
    end;
end;

procedure TGVar.SetValue(const Data:Variant);
var
	F:TFormatSettings;
begin
	ClearData();

	//Definimos el tipo de la variable y los datos
		GVarType := 1;

        case ((VarType(Data)) and (VarTypeMask)) of
        	varBoolean : begin
				if (Data) then
                	Self.Data := '1' else Self.Data := '0';
            end;

        	varDouble, varSingle, varCurrency : begin
            	F := TFormatSettings.Create;
            	F.DecimalSeparator := ',';
                F.ThousandSeparator := '.';
				Self.Data := FloatToStr(Data, F);
            end;

        	else Self.Data := String(Data);
        end;
end;

procedure TGVar.SetNil();
begin
	ClearData();

	GVarType := 4;

    Data := nil;
end;

procedure TGVar.CreateArray();
begin
	ClearData();

	SetT(TDictionary<String, TGVar>.Create(), 3);
end;

function TGVar.GetT():TValue;
begin

	if (GVarType = 1) then
		Result := Data
    else Result := Data;

    //Y destruimos si es una variable de usar y tirar
     	if (FreeOnGet) then Self.Free;
end;

function TGVar.GetValue(const PreventSelfFree:Boolean = False):String;
var
	s:string;
begin
	Result := '';

	if (GVarType = 1) then
        Result := Data.AsString

    else if (GVarType = 2) and (ObjectOwner) then
    	Result := '[object]'

    else if (GVarType = 2) then
    	Result := '[object-pointer]'

    else if (GVarType = 3) and (ObjectOwner) then
    	Result := '[array]'

    else if (GVarType = 3) then
    	Result := '[array-pointer]'

    else if (GVarType = 4) then
    	Result := 'null'

    else Result := '[unknown]';

    //Y destruimos si es una variable de usar y tirar
      	if ((FreeOnGet) and not (PreventSelfFree)) then Self.Free;
end;

function TGVar.GetBool(const PreventSelfFree:Boolean = False):Boolean;
var
	C:Char;
	S:String;
    WantFreeOnGet:Boolean;
begin
	Result := False;

	S := GetValue(True);
    try
    	if ((S = '') or (S = '0')) then exit;
        if (S = '1') then begin Result := True; exit; end;

        C := lowercase(s.Chars[0]).chars[0];
        if (C = '-') then begin
        	S := s.Substring(1);
            for C in S do if (not CharInSet(C, ['0'..'9']) ) then begin Result := True; break; end;
            if (not Result) then exit;

            S := GetValue(True);
        end;

        Result := True;
        if ((C = 'f') or (C = 'n')) then begin
            s := lowercase(s);
            if ((S = 'false') or (S = 'null')) then Result := False;
        end;


    //Y destruimos si es una variable de usar y tirar
    finally
      	if ((FreeOnGet) and (not PreventSelfFree)) then Self.Free;
    end;
end;

function TGVar.GetInt(const PreventSelfFree:Boolean = False):Integer;
begin
	Result := Trunc(GetNumeric(PreventSelfFree));
end;

function TGVar.GetNumeric(const PreventSelfFree:Boolean = False):Double;
    function OnlyChars(const Text: string; CharSet:TSysCharset): Boolean;
    var
        I:integer;
    begin
        Result := False;
        for I := 0 to Text.Length-1 do if (not CharInSet(Text.Chars[I], CharSet)) then exit;

        Result := True;
    end;
var
    WantFreeOnGet:Boolean;
    Val:string;
    I:Integer;
    Negative:Boolean;
begin
	Result := 0;

    Val := GetValue(True);
    Negative := False;

    try
    	if (Val = '') then exit;
        if (Val.Chars[0] = '-') then begin
            Negative := True;
            Val := Val.Substring(1);
            if (Val = '') then exit;
        end;

        I := Val.IndexOf(',');
        if (Val.IndexOf(',', I+1) >= 0) then Exit;
        if (not OnlyChars(Val, ['0'..'9', ','])) then exit;

        Result := StrtoFloat(Val);

        if (Negative) then Result := Result * -1;       

     finally
    //Y destruimos si es una variable de usar y tirar

      	if ((FreeOnGet) and (not PreventSelfFree)) then Self.Free;
    end;
end;


function TGVar.GetIsNil(const PreventSelfFree:Boolean = False):Boolean;
begin
	if (GVarType = 4) then Result := True
    else Result := False;

    //Y destruimos si es una vari able de usar y tirar
      	if ((FreeOnGet) and (not PreventSelfFree)) then Self.Free;
end;

function TGVar.GetArray(const PreventSelfFree:Boolean = False):TDictionary<String, TGVar>;
begin
	if (GVarType <> 3) then CreateArray();
    Result := Data.AsType<TDictionary<String, TGVar>>;

    //Y destruimos si es una variable de usar y tirar
      	if ((FreeOnGet) and (not PreventSelfFree)) then Self.Free;
end;

procedure TGVar.SetArray(const Key:String; const GVar:TGVar);
var
	KeyLC:string;
begin
	if (GVarType <> 3) then CreateArray();

    KeyLC:=Lowercase(Key);
    if (Data.AsType<TDictionary<String, TGVar>>.ContainsKey(KeyLC)) then begin
    	Data.AsType<TDictionary<String, TGVar>>[KeyLC].Free;
        ArrayKeys.Strings[ArrayKeys.IndexOf(Key)] := Key;
    end else ArrayKeys.Add(Key);

    Data.AsType<TDictionary<String, TGVar>>.AddOrSetValue(KeyLC, GVar);
end;

procedure TGVar.RemoveArray(const Key:String);
var
	I:Integer;
	KeyLC:string;
begin
	if (GVarType <> 3) then exit;

    KeyLC:=Lowercase(Key);
    if (Data.AsType<TDictionary<String, TGVar>>.ContainsKey(KeyLC)) then begin
		Data.AsType<TDictionary<String, TGVar>>[KeyLC].free;
		Data.AsType<TDictionary<String, TGVar>>.remove(KeyLC);
		I := ArrayKeys.IndexOf(Key);
        if (I >= 0) then ArrayKeys.Delete(I);
    end;
end;

procedure TGVar.SetRelated(const T:TValue);
begin
	if (GVarType = 2) then begin
    	RelatedObjects.Add(RelatedObjects.Count, T);
    end;
end;

end.
