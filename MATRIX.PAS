{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2023
  @website(https://www.gladir.com/mathix)
  @abstract(Target: Turbo Pascal 7, Free Pascal 3.2)
}

Program MATRIX;

Type
 MatrixType=Array[1..20,1..20]of Real;

Var
 SourceCSV,SourceCSV2:Text;
 I,PosField,PosRec:Integer;
 Err:Word;
 Value,Somme:Real;
 CurrLine,CurrWord:String;
 Matrix1,Matrix2,MatrixResultat:MatrixType;
 DimensionX,DimensionY:Word;

Procedure AddMatrix(DimensionX,DimensionY:Word;
                    Const A,B:MatrixType;Var Resultat:MatrixType);
Var
 I,J:Word;
Begin
 For J:=1 to DimensionY do Begin
   For I:=1 to DimensionX do Begin
    Resultat[J,I] := A[J,I] + B[J,I];
   End;
 End;
End;

Procedure MulMatrix(DimensionX,DimensionY:Word;
                    Const A,B:MatrixType;Var Resultat:MatrixType);
Var
 I,J,K:Word;
Begin
 For J:=1 to DimensionY do Begin
   For I:=1 to DimensionX do Begin
    Resultat[J,I] := 0;
    For K:=1 to DimensionX do Begin
     Resultat[J,I] := Resultat[J,I] + A[J,I] * B[J,I];
    End;
   End;
 End;
End;

Procedure ShowMatrix(DimensionX,DimensionY:Word;Const C:MatrixType);
Var
 I,J:Word;
Begin
 For J:=1 to DimensionY do Begin
   For I:=1 to DimensionX do Begin
    Write(C[J,I]:0:5,' ');
   End;
   WriteLn;
 End;
End;


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
  WriteLn('MATRIX : Cette commande permet de calculer des matrices.');
  WriteLn;
  WriteLn('Syntaxe : MATRIX SUM data1.csv data2.csv');
  WriteLn;
  WriteLn(' data1.csv   Ce paramätre permet d''indiquer le fichier ',
                       'contenant les donnÇes');
  WriteLn(' data2.csv   Ce paramätre permet d''indiquer le fichier ',
                       'contenant les donnÇes');
  WriteLn(' SUM        Ce paramätre permet d''indiquer la somme');
  WriteLn(' MUL        Ce paramätre permet d''indiquer la multiplication');
 End
  Else
 If ParamCount>0 Then Begin
  If StrToUpper(ParamStr(1))='SUM'Then Begin
   If ParamStr(3)=''Then Begin
    {$I-}Assign(SourceCSV,ParamStr(2));
    Reset(SourceCSV);{$I+}
    If IoResult<>0 Then Begin
     WriteLn('Fichier introuvable : ',ParamStr(2));
     Halt;
    End;
    While Not EOF(SourceCSV)do Begin
     ReadLn(SourceCSV,CurrLine);
     Somme:=0;
     CurrWord:='';PosField:=0;
     For I:=1 to Length(CurrLine)do Begin
      If CurrLine[I]=','Then Begin
       If(CurrWord[1]='"')and(CurrWord[Length(CurrWord)]='"')Then Begin
        Val(Copy(CurrWord,2,Length(CurrWord)-2),Value,Err);
        Somme:=Somme+Value;
        Inc(PosField);
       End
        Else
       Begin
        Val(CurrWord,Value,Err);
        Somme:=Somme+Value;
        Inc(PosField);
       End;
       CurrWord:='';
      End
       Else
      CurrWord:=CurrWord+CurrLine[I];
     End;
     If CurrWord<>''Then Begin
      Val(CurrWord,Value,Err);
     Somme:=Somme+Value;
     End;
     WriteLn(Somme:0:5);
    End;
    Close(SourceCSV);
   End
    Else
   Begin
    FillChar(Matrix1,SizeOf(Matrix1),0);
    FillChar(Matrix2,SizeOf(Matrix2),0);
    PosRec:=1;
    {$I-}Assign(SourceCSV,ParamStr(2));
    Reset(SourceCSV);{$I+}
    If IoResult<>0 Then Begin
     WriteLn('Fichier introuvable : ',ParamStr(2));
     Halt;
    End;
    {$I-}Assign(SourceCSV2,ParamStr(3));
    Reset(SourceCSV2);{$I+}
    If IoResult<>0 Then Begin
     WriteLn('Fichier introuvable : ',ParamStr(3));
     Halt;
    End;
    While Not EOF(SourceCSV)do Begin
     ReadLn(SourceCSV,CurrLine);
     CurrWord:='';PosField:=1;
     For I:=1 to Length(CurrLine)do Begin
      If CurrLine[I]=','Then Begin
       If(CurrWord[1]='"')and(CurrWord[Length(CurrWord)]='"')Then Begin
        Val(Copy(CurrWord,2,Length(CurrWord)-2),Matrix1[PosRec,PosField],Err);
        Inc(PosField);
       End
        Else
       Begin
        Val(CurrWord,Matrix1[PosRec,PosField],Err);
        Inc(PosField);
       End;
       CurrWord:='';
      End
       Else
      CurrWord:=CurrWord+CurrLine[I];
     End;
     If CurrWord<>''Then Begin
      Val(CurrWord,Matrix1[PosRec,PosField],Err);
     End;
     Inc(PosRec);
     If PosRec>20 Then Begin
      WriteLn('Matrice trop grande !');
      Halt;
     End;
    End;
    DimensionX:=PosField;
    DimensionY:=PosRec-1;
    PosRec:=1;
    While Not EOF(SourceCSV2)do Begin
     ReadLn(SourceCSV2,CurrLine);
     CurrWord:='';PosField:=1;
     For I:=1 to Length(CurrLine)do Begin
      If CurrLine[I]=','Then Begin
       If(CurrWord[1]='"')and(CurrWord[Length(CurrWord)]='"')Then Begin
        Val(Copy(CurrWord,2,Length(CurrWord)-2),Matrix2[PosRec,PosField],Err);
        Inc(PosField);
       End
        Else
       Begin
        Val(CurrWord,Matrix2[PosRec,PosField],Err);
        Inc(PosField);
       End;
       CurrWord:='';
      End
       Else
      CurrWord:=CurrWord+CurrLine[I];
     End;
     If CurrWord<>''Then Begin
      Val(CurrWord,Matrix2[PosRec,PosField],Err);
     End;
     Inc(PosRec);
     If PosRec>20 Then Begin
      WriteLn('Matrice trop grande !');
      Halt;
     End;
    End;
    Close(SourceCSV2);
    Close(SourceCSV);
    WriteLn('Dimension : ',DimensionX,'x',DimensionY);
    WriteLn;
    WriteLn('Matrice A :');
    ShowMatrix(DimensionX,DimensionY,Matrix1);
    WriteLn;
    WriteLn('Matrice B :');
    ShowMatrix(DimensionX,DimensionY,Matrix2);
    WriteLn;
    WriteLn('RÇsultat : ');
    AddMatrix(DimensionX,DimensionY,Matrix1,Matrix2,MatrixResultat);
    ShowMatrix(DimensionX,DimensionY,MatrixResultat);
   End;
  End
   Else
  If StrToUpper(ParamStr(1))='MUL'Then Begin
   If ParamStr(3)=''Then Begin
    {$I-}Assign(SourceCSV,ParamStr(2));
    Reset(SourceCSV);{$I+}
    If IoResult<>0 Then Begin
     WriteLn('Fichier introuvable : ',ParamStr(2));
     Halt;
    End;
    While Not EOF(SourceCSV)do Begin
     ReadLn(SourceCSV,CurrLine);
     Somme:=1;
     CurrWord:='';PosField:=0;
     For I:=1 to Length(CurrLine)do Begin
      If CurrLine[I]=','Then Begin
       If(CurrWord[1]='"')and(CurrWord[Length(CurrWord)]='"')Then Begin
        Val(Copy(CurrWord,2,Length(CurrWord)-2),Value,Err);
        Somme:=Somme*Value;
        Inc(PosField);
       End
        Else
       Begin
        Val(CurrWord,Value,Err);
        Somme:=Somme*Value;
        Inc(PosField);
       End;
       CurrWord:='';
      End
       Else
      CurrWord:=CurrWord+CurrLine[I];
     End;
     If CurrWord<>''Then Begin
      Val(CurrWord,Value,Err);
     Somme:=Somme*Value;
     End;
     WriteLn(Somme:0:5);
    End;
    Close(SourceCSV);
   End
    Else
   Begin
    FillChar(Matrix1,SizeOf(Matrix1),0);
    FillChar(Matrix2,SizeOf(Matrix2),0);
    PosRec:=1;
    {$I-}Assign(SourceCSV,ParamStr(2));
    Reset(SourceCSV);{$I+}
    If IoResult<>0 Then Begin
     WriteLn('Fichier introuvable : ',ParamStr(2));
     Halt;
    End;
    {$I-}Assign(SourceCSV2,ParamStr(3));
    Reset(SourceCSV2);{$I+}
    If IoResult<>0 Then Begin
     WriteLn('Fichier introuvable : ',ParamStr(3));
     Halt;
    End;
    While Not EOF(SourceCSV)do Begin
     ReadLn(SourceCSV,CurrLine);
     CurrWord:='';PosField:=1;
     For I:=1 to Length(CurrLine)do Begin
      If CurrLine[I]=','Then Begin
       If(CurrWord[1]='"')and(CurrWord[Length(CurrWord)]='"')Then Begin
        Val(Copy(CurrWord,2,Length(CurrWord)-2),Matrix1[PosRec,PosField],Err);
        Inc(PosField);
       End
        Else
       Begin
        Val(CurrWord,Matrix1[PosRec,PosField],Err);
        Inc(PosField);
       End;
       CurrWord:='';
      End
       Else
      CurrWord:=CurrWord+CurrLine[I];
     End;
     If CurrWord<>''Then Begin
      Val(CurrWord,Matrix1[PosRec,PosField],Err);
     End;
     Inc(PosRec);
     If PosRec>20 Then Begin
      WriteLn('Matrice trop grande !');
      Halt;
     End;
    End;
    DimensionX:=PosField;
    DimensionY:=PosRec-1;
    PosRec:=1;
    While Not EOF(SourceCSV2)do Begin
     ReadLn(SourceCSV2,CurrLine);
     CurrWord:='';PosField:=1;
     For I:=1 to Length(CurrLine)do Begin
      If CurrLine[I]=','Then Begin
       If(CurrWord[1]='"')and(CurrWord[Length(CurrWord)]='"')Then Begin
        Val(Copy(CurrWord,2,Length(CurrWord)-2),Matrix2[PosRec,PosField],Err);
        Inc(PosField);
       End
        Else
       Begin
        Val(CurrWord,Matrix2[PosRec,PosField],Err);
        Inc(PosField);
       End;
       CurrWord:='';
      End
       Else
      CurrWord:=CurrWord+CurrLine[I];
     End;
     If CurrWord<>''Then Begin
      Val(CurrWord,Matrix2[PosRec,PosField],Err);
     End;
     Inc(PosRec);
     If PosRec>20 Then Begin
      WriteLn('Matrice trop grande !');
      Halt;
     End;
    End;
    Close(SourceCSV2);
    Close(SourceCSV);
    WriteLn('Dimension : ',DimensionX,'x',DimensionY);
    WriteLn;
    WriteLn('Matrice A :');
    ShowMatrix(DimensionX,DimensionY,Matrix1);
    WriteLn;
    WriteLn('Matrice B :');
    ShowMatrix(DimensionX,DimensionY,Matrix2);
    WriteLn;
    WriteLn('RÇsultat : ');
    MulMatrix(DimensionX,DimensionY,Matrix1,Matrix2,MatrixResultat);
    ShowMatrix(DimensionX,DimensionY,MatrixResultat);
   End;
  End
   Else
  WriteLn('Action non reconnu');
 End
  Else
 WriteLn('Paramätre requis');
END.