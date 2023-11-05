{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2022
  @website(https://www.gladir.com/mathix)
  @abstract(Target: Turbo Pascal, Free Pascal)
}

Program ROMAN;

Function NumberToRomain(X:Integer):String;
Var
 S:String;
Begin
 S:='';
 Case(X mod 1000) div 100 of
  9: S:=S+'CM';
  8: S:=S+'DCCC';
  7: S:=S+'DCC';
  6: S:=S+'DC';
  5: S:=S+'D';
  4: S:=S+'CD';
  3: S:=S+'CCC';
  2: S:=S+'CC';
  1: S:=S+'C';
 End;
 Case(X mod 100) div 10 of
  9: S:=S+'XC';
  8: S:=S+'LXXX';
  7: S:=S+'LXX';
  6: S:=S+'LX';
  5: S:=S+'L';
  4: S:=S+'XL';
  3: S:=S+'XXX';
  2: S:=S+'XX';
  1: S:=S+'X';
 End;
 Case X mod 10 of
  9: S:=S+'IX';
  8: S:=S+'VIII';
  7: S:=S+'VII';
  6: S:=S+'VI';
  5: S:=S+'V';
  4: S:=S+'IV';
  3: S:=S+'III';
  2: S:=S+'II';
  1: S:=S+'I';
 End;
 NumberToRomain:=S;
End;

Function IsRomanNumber(S:String):Boolean;
Var
 I:Byte;
Begin
 IsRomanNumber:=False;
 For I:=1 to Length(S)do If Not(S[I] in['C','D','I','L','M','V','X'])Then Exit;
 IsRomanNumber:=True;
End;

Function RomainToNumber(S:String):Integer;
Var
 I:Byte;
 Number:Integer;
Begin
 Number:=0;
 For I:=1 to Length(S)do Begin
  Case S[I]of
   'C':If(I+1>=Length(S))and(S[I+1] in['D','M'])Then Number:=Number-100
                                                Else Number:=Number+100;
   'D':Number:=Number+500;
   'I':If(I+1>=Length(S))and(S[I+1] in['V','X'])Then Number:=Number-1
                                                Else Number:=Number+1;
   'L':Number:=Number+50;
   'M':Number:=Number+1000;
   'V':Number:=Number+5;
   'X':If(I+1>=Length(S))and(S[I+1] in['C','L'])Then Number:=Number-10
                                                Else Number:=Number+10;
  End;
 End;
 RomainToNumber:=Number;
End;

Var
 I,Value:Integer;
 Err:Word;

BEGIN
 If(ParamStr(1)='/?')or(ParamStr(1)='--help')or(ParamStr(1)='-h')Then Begin
  WriteLn('ROMAN : Cette commande permet de convertir un nombre en un nombre romain.');
  WriteLn;
  WriteLn('Syntaxe : ROMAN nombre');
 End
  Else
 If ParamCount>=1Then Begin
  For I:=1 to ParamCount do Begin
   If IsRomanNumber(ParamStr(I))Then Begin
    WriteLn(RomainToNumber(ParamStr(I)));
   End
    Else
   Begin
    Val(ParamStr(I),Value,Err);
    If Err=0 Then Begin
      WriteLn(NumberToRomain(Value));
    End
     Else
    WriteLn('Nombre invalide !');
   End;
  End;
 End
  Else
 WriteLn('Nombre requis !');
END.
