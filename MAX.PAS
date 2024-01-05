{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2024
  @website(https://www.gladir.com/mathix)
  @abstract(Target: Turbo Pascal 7, Free Pascal 3.2)
}

Program MAX;

Uses DOS;

Var
 I,J:Integer;
 MaxValue,CurrValue:Real;
 Err,PosField:Word;
 FileSource:Text;
 CurrWord,CurrLine:String;

Function FileExist(Name:String):Boolean;
Var
 Rec:SearchRec;
Begin
 FindFirst(Name,AnyFile,Rec);
 FileExist:=DosError=0;
End;

BEGIN
 If(ParamStr(1)='/?')or(ParamStr(1)='--help')or(ParamStr(1)='-h')or
   (ParamStr(1)='/h')or(ParamStr(1)='/H')Then Begin
  WriteLn('MAX : Cette commande permet de retourner la valeur maximal ',
                 'd''un groupe de valeurs.');
  WriteLn;
  WriteLn('Syntaxe : MAX valeur1 valeur2 valeur3 ...');
  WriteLn('          MAX fichier1.csv fichier2.csv fichier3.csv ...');
  WriteLn;
  WriteLn(' valeur?   Liste de valeurs … analyser');
  WriteLn(' fichier?  Liste de fichiers … analyser');
 End
  Else
 If ParamCount>0Then Begin
  MaxValue:=-1;
  For I:=1 to ParamCount do Begin
   Val(ParamStr(I),CurrValue,Err);
   If Err=0 Then Begin
    If(CurrValue>MaxValue)Then MaxValue:=CurrValue;
   End
    Else
   If FileExist(ParamStr(I))Then Begin
    {$I-}Assign(FileSource,ParamStr(I));
    Reset(FileSource);{$I+}
    If IOResult<>0 Then Begin
     WriteLn('Impossible de lire le fichier ',ParamStr(I));
     Halt(1);
    End;
    While Not EOF(FileSource)do Begin
     ReadLn(FileSource,CurrLine);
     CurrWord:='';
     PosField:=0;
     For J:=1 to Length(CurrLine)do Begin
      If CurrLine[J]=','Then Begin
       If(CurrWord[J]='"')and(CurrWord[Length(CurrWord)]='"')Then Begin
        Val(Copy(CurrWord,2,Length(CurrWord)-2),CurrValue,Err);
       End
        Else
       Val(CurrWord,CurrValue,Err);
       If Err=0 Then Begin
        If(CurrValue>MaxValue)Then MaxValue:=CurrValue;
       End;
       CurrWord:='';
       Inc(PosField);
      End
       Else
      CurrWord:=CurrWord+CurrLine[J];
     End;
     Val(CurrWord,CurrValue,Err);
     If Err=0 Then Begin
      If(CurrValue>MaxValue)Then MaxValue:=CurrValue;
     End;
     Inc(PosField);
    End;
    Close(FileSource);
   End;
  End;
  If Frac(MaxValue)=0.0 Then WriteLn(MaxValue:1:0)
                        Else WriteLn(MaxValue);
 End;
END.