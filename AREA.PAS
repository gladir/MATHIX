{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2022
  @website(https://www.gladir.com/mathix)
  @abstract(Target: Turbo Pascal, Free Pascal)
}

Program Area;

Var
 B1,B2,L,H,R:Real;
 Err:Word;

Function StrToUpper(S:String):String;
Var
 I:Byte;
Begin
 For I:=1 to Length(S)do Begin
  If S[I] in['a'..'z']Then S[I]:=Chr(Ord(S[I])-32);
 End;
 StrToUpper:=S;
End;

BEGIN
 If(ParamStr(1)='/?')or(ParamStr(1)='--help')or(ParamStr(1)='-h')or
   (ParamStr(1)='/h')or(ParamStr(1)='/H')Then Begin
  WriteLn('AREA : Cette commande permet de calculer la surface d''une forme.');
  WriteLn;
  WriteLn('Syntaxe : AREA forme [parametre]');
  WriteLn;
  WriteLn('          AREA CIRCLE rayon');
  WriteLn('          AREA SQUARE cote');
  WriteLn('          AREA RECTANGLE longueur largeur');
  WriteLn('          AREA TRAPEZE petitebase grandebase hauteur');
  WriteLn('          ...');
  WriteLn;
  WriteLn(' CIRCLE    Cette forme permet d''indiquer un cercle');
  WriteLn(' RECTANGLE Cette forme permet d''indiquer un rectangle');
  WriteLn(' SQUARE    Cette forme permet d''indiquer un carr‚');
  WriteLn(' TRAPEZE   Cette forme permet d''indiquer un trapŠze');
 End
  Else
 If ParamCount>0Then Begin
  If StrToUpper(ParamStr(1))='CIRCLE'Then Begin
   Val(ParamStr(2),R,Err);
   If Err>0Then Begin
    WriteLn('Valeur de rayon invalide');
    Halt;
   End;
   WriteLn(PI*Sqr(R):1:4);
  End
   Else
  If StrToUpper(ParamStr(1))='RECTANGLE'Then Begin
   Val(ParamStr(2),L,Err);
   If Err>0Then Begin
    WriteLn('Valeur de longueur invalide');
    Halt;
   End;
   Val(ParamStr(3),H,Err);
   If Err>0Then Begin
    WriteLn('Valeur de largeur invalide');
    Halt;
   End;
   WriteLn(L*H:1:4);
  End
   Else
  If StrToUpper(ParamStr(1))='SQUARE'Then Begin
   Val(ParamStr(2),R,Err);
   If Err>0Then Begin
    WriteLn('Valeur de cote invalide');
    Halt;
   End;
   WriteLn(Sqr(R):1:4);
  End
   Else
  If StrToUpper(ParamStr(1))='TRAPEZE'Then Begin
   Val(ParamStr(2),B1,Err);
   If Err>0Then Begin
    WriteLn('Valeur de la petite base invalide');
    Halt;
   End;
   Val(ParamStr(3),B2,Err);
   If Err>0Then Begin
    WriteLn('Valeur de la grande base invalide');
    Halt;
   End;
   Val(ParamStr(4),H,Err);
   If Err>0Then Begin
    WriteLn('Valeur de la hauteur invalide');
    Halt;
   End;
   WriteLn(((B1+B2)*H)/2:1:4);
  End
   Else
  WriteLn('Forme non reconnu');
 End
  Else
 WriteLn('Parametre requis');
END.