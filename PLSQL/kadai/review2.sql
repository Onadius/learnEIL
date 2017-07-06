/*
修正済み
2.一番小さいEMPNOの人のSALが1000以上だったら
RESULTテーブルのCRESULTに'TRUE',
1000未満だったら'FALSE'をinsertするPLSQLを書きなさい。

@C:\Users\Administrator\Documents\learnEIL\SQL\plSQL\kadai\review2.sql

・IF分岐
・INSERT処理

*/

-- console ログ表示
SET SERVEROUTPUT ON

DECLARE
  min_sal NUMBER := 0 ;
  eromannga VARCHAR2(30) ;  

BEGIN
  select E.sal into min_sal
  from emp E
  where
    empno = (
      select MIN(A.empno)
      from emp A
    ) ;

  if (min_sal >= 1000 ) THEN
    eromannga := '紗霧ちゃん' ;

  else
    eromannga := 'そんな名前の人は知らない' ;

  END if ;

  INSERT into result
    (CRESULT)
  values
    (eromannga) ;

  dbms_output.put_line('お兄ちゃんのラノベ主人公!!') ;

/*
EXCEPTION
  when others then
  dbms_output.put_line('エラー発生！！');
  */


END ;
/
