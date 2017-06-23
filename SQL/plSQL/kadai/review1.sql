/*
1.1～5000までの数字の足算の結果を
RESULTテーブルのNRESULTにinsertするPLSQLを書きなさい。

ファイル実行fullパス
@C:\Users\Administrator\Documents\learnEIL\SQL\plSQL\kadai\

・FOR loop処理

*/

-- console ログ表示
SET SERVEROUTPUT ON

DECLARE
  miku NUMBER := 0 ;

BEGIN
  for i in 1..3939 LOOP
    --dbms_output.put_line('loop回数 : ' || i) ;
    miku := miku + i ;
  END LOOP ;

  insert into RESULT
    (NRESULT)
  values
    (miku) ;

  dbms_output.put_line(miku) ;

END ;
/
