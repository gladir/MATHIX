{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2022
  @website(https://www.gladir.com/mathix)
  @abstract(Target: Turbo Pascal, Free Pascal)
}

Program MathQuiz;

Uses Crt,Strings;

Var
 TmpQuestion:String;
 QuestionList:Array[1..255]of Byte;
 I,NumQuestion,P,Good,Bad:Integer;
 Choix:Char;
 ChoixValid:Boolean;

Type
 QuestionRec=Record
  Question:PChar;
  AnswerA,AnswerB,AnswerC,AnswerD:PChar;
  Response:Char;
 End;

Const
 Questions:Array[1..11] of QuestionRec=(
  (Question:'Quel est la somme de 3 + 7';
   AnswerA:'21';
   AnswerB:'4';
   AnswerC:'10';
   AnswerD:'20';
   Response:'C'),
  (Question:'Quel est la racine carr‚ de -9';
   AnswerA:'3';
   AnswerB:'-3';
   AnswerC:'9';
   AnswerD:'Nombre irr‚el';
   Response:'D'),
  (Question:'Quel nombres parmi les suivants sont paires';
   AnswerA:'1';
   AnswerB:'2';
   AnswerC:'3';
   AnswerD:'5';
   Response:'B'),
  (Question:'Quel est la produit de 4 x 4';
   AnswerA:'8';
   AnswerB:'0';
   AnswerC:'16';
   AnswerD:'-16';
   Response:'C'),
  (Question:'Quel est la somme de 4 - 7';
   AnswerA:'3';
   AnswerB:'11';
   AnswerC:'-3';
   AnswerD:'0';
   Response:'C'),
  (Question:'Quel est le produit de 0 x 1';
   AnswerA:'0';
   AnswerB:'1';
   AnswerC:'Impossible';
   AnswerD:'-1';
   Response:'A'),
  (Question:'Quel est la produit de 13 x 13';
   AnswerA:'26';
   AnswerB:'-169';
   AnswerC:'169';
   AnswerD:'144';
   Response:'C'),
  (Question:'Quel est la somme de 4 + 7';
   AnswerA:'12';
   AnswerB:'11';
   AnswerC:'-11';
   AnswerD:'3';
   Response:'B'),
  (Question:'Quel est la somme de -7 + 4';
   AnswerA:'11';
   AnswerB:'-3';
   AnswerC:'-11';
   AnswerD:'3';
   Response:'B'),
  (Question:'Quel est la racine carr‚ de 9';
   AnswerA:'3';
   AnswerB:'-3';
   AnswerC:'9';
   AnswerD:'Nombre irr‚el';
   Response:'A'),
  (Question:'Quel est la racine carr‚ de -4096';
   AnswerA:'64';
   AnswerB:'Nombre irr‚el';
   AnswerC:'-64';
   AnswerD:'0';
   Response:'B')
 );

BEGIN
 {$IFDEF FPC}
  {$IFDEF WINDOWS}
   SetUseACP(False);
  {$ENDIF}
 {$ENDIF}
 If(ParamStr(1)='/?')or(ParamStr(1)='--help')or(ParamStr(1)='-h')Then Begin
  WriteLn('MATHQUIZ - Cette commande permet de passer un QUIZ de math‚matique');
  WriteLn;
  WriteLn('Syntaxe : MATHQUIZ');
 End
  Else
 Begin
  Randomize;
  NumQuestion:=10;
  Good:=0;
  Bad:=0;
  FillChar(QuestionList,SizeOf(QuestionList),0);
  TmpQuestion[0]:=Chr(High(Questions));
  For I:=1 to 255 do Begin
   TmpQuestion[I]:=Chr(I);
  End;
  For I:=1 to NumQuestion do Begin
   P:=1+Random(Length(TmpQuestion));
   QuestionList[I]:=Byte(TmpQuestion[P]);
   Delete(TmpQuestion,P,1);
  End;
  For I:=1 to NumQuestion do Begin
   ClrScr;
   TextColor(White);
   WriteLn(' ':30,'QUIZ de math‚matique');
   WriteLn;
   WriteLn('Question (',I,'/',NumQuestion,')');
   TextColor(LightGreen);
   WriteLn('Bonne r‚ponse : ',Good);
   TextColor(LightRed);
   WriteLn('Mauvaise r‚ponse : ',Bad);
   WriteLn;
   TextColor(7);
   WriteLn(StrPas(Questions[QuestionList[I]].Question),' ?');
   WriteLn;
   WriteLn('A) ',StrPas(Questions[QuestionList[I]].AnswerA));
   WriteLn('B) ',StrPas(Questions[QuestionList[I]].AnswerB));
   WriteLn('C) ',StrPas(Questions[QuestionList[I]].AnswerC));
   WriteLn('D) ',StrPas(Questions[QuestionList[I]].AnswerD));
   WriteLn;
   Write('Votre choix : ');
   Repeat
    Choix:=ReadKey;
    ChoixValid:=True;
    Case Choix of
     'A','a':If Questions[QuestionList[I]].Response='A'Then Inc(Good)
                                                       Else Inc(Bad);
     'B','b':If Questions[QuestionList[I]].Response='B'Then Inc(Good)
                                                       Else Inc(Bad);
     'C','c':If Questions[QuestionList[I]].Response='C'Then Inc(Good)
                                                       Else Inc(Bad);
     'D','d':If Questions[QuestionList[I]].Response='D'Then Inc(Good)
                                                       Else Inc(Bad);
     #27:Begin
      TextColor(LightRed);
      WriteLn('Test abandonn‚');
      Halt;
     End;
     Else ChoixValid:=False;
    End;
   Until ChoixValid;
   WriteLn(Choix);
   WriteLn;
  End;
  If Trunc((Good/NumQuestion)*100)>60 Then Begin
   TextColor(LightGreen);
   WriteLn('VOUS AVEZ REUSSIS LE QUIZ !');
   WriteLn('FELICITATION !');
  End
   Else
  Begin
   TextColor(LightRed);
   WriteLn('VOUS AVEZ ECHOUER LE QUIZ !');
  End;
  WriteLn('Vous avez obtenu une note de ',Trunc((Good/NumQuestion)*100),'% !');
  WriteLn('Bonne r‚ponse : ',Good);
  WriteLn('Mauvaise r‚ponse : ',Bad);
 End;
END.
