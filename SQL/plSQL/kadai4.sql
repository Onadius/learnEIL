/*
4.EMP表に存在する人物のSALを全て足して、
RESULTテーブルのNRESULT2にinsertするPLSQLを書きなさい。
このとき、Cより後のアルファベットで始まるJOBの人物のSALは
DEPTNO倍して足しなさい。
*/
--@C:\Users\Administrator\Desktop\text\SQL\plSQL\kadai4.sql

DECLARE
 sal1 emp.sal%type ;
 sal2 emp.sal%type ;

BEGIN
  select
    sum(a.sal * a.deptno) into sal1
  from
    emp a
  where
    a.job like 'C%' ;

  select
    sum(e.sal) into sal2
  from
    emp e
  where e.job not like 'C%' ;

  DBMS_OUTPUT.PUT_LINE(sal1 + sal2);

  insert into RESULT (
    NRESULT2
  )
  values (
    sal1 + sal2
  ) ;

END ;
/


SQL> select NRESULT2 from result ;

  NRESULT2
----------



    102875
