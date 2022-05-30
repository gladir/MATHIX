{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2022
  @website(https://www.gladir.com/mathix)
  @abstract(Target: Turbo Pascal, Free Pascal)
}

Program TABLE;

Var
 Number,I,J:LongInt;
 Err:Word;
 S:String;

Function PadRight(S:String;Space:Byte):String;
Var
 I:Byte;
Begin
 If Length(S)<Space Then For I:=Length(S)+1 to Space do S:=S+' ';
 PadRight:=S;
End;


BEGIN
 If(ParamStr(1)='/?')or(ParamStr(1)='--help')or(ParamStr(1)='-h')or
   (ParamStr(1)='/h')or(ParamStr(1)='/H')Then Begin
  WriteLn('PI : Cette commande permet d''afficher la table d''un ',
                'nombre');
  WriteLn;
  WriteLn('Syntaxe : TABLE [nombre]');
 End
  Else
 If ParamCount>0Then Begin
  For I:=1 to ParamCount do Begin
   Val(ParamStr(I),Number,Err);
   If Err>0Then Begin
    WriteLn('Nombre invalide');
    Halt;
   End;
   WriteLn;
   WriteLn('Table du ',Number);
   For J:=1 to 13 do WriteLn(J,' x ',Number,' = ',J*Number);
  End;
 End
  Else
 Begin
  Write(' ':3);
  For I:=1 to 6 do Begin
   Str(I,S);
   Write(PadRight(S,9));
  End;
  WriteLn;
  For J:=1 to 12 do Begin
   For I:=1 to 6 do Begin
    Str(J*I,S);
    Write(J:2,'x',I,'=',PadRight(S,4));
   End;
   WriteLn;
  End;
  WriteLn;
  Write(' ':3);
  For I:=7 to 12 do Begin
   Str(I,S);
   Write(PadRight(S,9));
  End;
  WriteLn;
  For J:=1 to 12 do Begin
   For I:=7 to 12 do Begin
    Str(J*I,S);
    Write(J:2,'x',I,'=',PadRight(S,4));
   End;
   WriteLn;
  End;
 End;
END.