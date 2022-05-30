{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2022
  @website(https://www.gladir.com/mathix)
  @abstract(Target: Turbo Pascal, Free Pascal)
}

Program PRIME;

Var
 Limit,I:LongInt;
 Err:Word;

Function NombreFacteur(N:LongInt):LongInt;
Var
  Count,I,Racine:LongInt;
Begin
 Count:=2;
 Racine:=Trunc(Sqrt(N));
 For I := 2 to Racine do Begin
  If N mod I = 0 Then Inc(Count);
 End;
 NombreFacteur:=Count;
End;

Function Premier(N:LongInt):Boolean;Begin
 Premier:=NombreFacteur(N) = 2;
End;

Function NombrePremierPlusPetit(N:LongInt):LongInt;
Var
 Count,I:LongInt;
Begin
 Count:=0;
 For I:= 2 to N-1 do If Premier(I)Then Inc(Count);
 NombrePremierPlusPetit:=Count;
End;

BEGIN
 If(ParamStr(1)='/?')or(ParamStr(1)='--help')or(ParamStr(1)='-h')or
   (ParamStr(1)='/h')or(ParamStr(1)='/H')Then Begin
  WriteLn('PRIME : Cette commande permet de retourner des nombres ',
                    'premiers');
  WriteLn;
  WriteLn('Syntaxe : PRIME [limite]');
 End
  Else
 If ParamCount>0Then Begin
  Val(ParamStr(1),Limit,Err);
  If Err>0 Then Begin
   WriteLn('Valeur invalide');
  End
   Else
  Begin
   WriteLn('Liste des nombres premier avant ',Limit,' : ');
   For I := 2 to Limit do Begin
    If Premier(I)Then Write(I,' ');
   End;
   WriteLn;
   Write('Nombre de nombre premier avant ',Limit,' : ');
   WriteLn(NombrePremierPlusPetit(Limit));
  End;
 End
  Else
 Begin
  WriteLn('Liste des nombres premier avant 1000: ');
  For I := 2 to 1000 do Begin
   If Premier(I)Then Write(I,' ');
  End;
  WriteLn;
  Write('Nombre de nombre premier avant 1000: ');
  WriteLn(NombrePremierPlusPetit(1000));
 End;
END.
