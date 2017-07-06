/*
--3.一番多いJOBの名前をRESULTテーブルのJNRESULTにinsertするPLSQLを書きなさい。
--@C:\Users\Administrator\Desktop\text\SQL\plSQL\kadai.sql

@C:\Users\Administrator\Documents\learnEIL\SQL\plSQL\kadai\review3.sql

・cursor宣言とその使い方
・forでのカーソルの中身の取り出し

*/


set SERVEROUTPUT on
DECLARE
  cursor mikumiku is
    select job
    from emp E
    group by E.job
    having
      count(E.job) = (
        select MAX(count(A.job))
        from emp A
        group by A.job
      ) ;

BEGIN
  for miku_rec in mikumiku loop
    insert into RESULT
      (JNRESULT)
    values
      (miku_rec.job) ;
  END loop ;

END ;
/

select * from result ;
