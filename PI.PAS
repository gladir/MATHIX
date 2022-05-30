{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2022
  @website(https://www.gladir.com/mathix)
  @abstract(Target: Turbo Pascal, Free Pascal)
}

Program PI(Input,Output);

Var
 FileName:String;
 Handle:Text;
 Limit,I:LongInt;
 a,b,c,d,e,g:LongInt;
 f:Array[0..8401]of LongInt;
 X:String;
 Err:Word;

Function Right(Const S:String;L:Byte):String;Begin
 Right:=Copy(S,Length(S)-L+1,L);
End;

BEGIN
 If(ParamStr(1)='/?')or(ParamStr(1)='--help')or(ParamStr(1)='-h')or
   (ParamStr(1)='/h')or(ParamStr(1)='/H')Then Begin
  WriteLn('PI : Cette commande permet de generer le nombre PI.');
  WriteLn;
  WriteLn('Syntaxe : PI [fichier] [limite]');
 End
  Else
 Begin
  Limit:=2147483647;
  FileName:='';
  If ParamStr(1)<>''Then Begin
   If(ParamCount=1)Then Begin
    Val(ParamStr(1),Limit,Err);
    If Err>0Then Begin
     FileName:=ParamStr(1);
     Limit:=2147483647;
    End;
   End
    Else
   Begin
    FileName:=ParamStr(1);
   End;
  End;
  If ParamStr(2)<>''Then Begin
   Val(ParamStr(2),Limit,Err);
   If Err>0Then Begin
    WriteLn('Limite invalide !');
    Halt;
   End;
  End;
  If FileName<>''Then Begin
   Assign(Handle,FileName);
   Rewrite(Handle);
   WriteLn(Handle,'G‚n‚ration du nombre PI :');
   Close(Handle);
   Append(Handle);
  End;
  a := 10000;
  c := 8400;
  I := 0;
  While b <> c do Begin
   f[b] := a div 5;
   Inc(b);
  End;
  While c > 0 do Begin
   g := 2 * c;
   d := 0;
   b := c;
   While b > 0 do Begin
    Inc(d,f[b] * a);
    Dec(g);
    f[b] := d mod g;
    d := d div g;
    Dec(g);
    Dec(b);
    If b <> 0 Then d := d * b;
   End;
   Dec(c,14);
   Str(e + (d div a),X);
   If FileName<>''Then Begin
    Write(Handle,Copy('0000',1, 5 - Length(X) - 1));
    Write(Handle,Right(X,Length(X)));
   End
    Else
   Begin
    Write(Copy('0000',1, 5 - Length(X) - 1));
    Write(Right(X,Length(X)));
   End;
   e := d mod a;
   Inc(I);
   If I>=Limit Then Break;
  End;
  If FileName<>''Then Close(Handle);
 End;
END.