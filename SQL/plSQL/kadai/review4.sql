/*
4.EMP表に存在する人物のSALを全て足して、
RESULTテーブルのNRESULT2にinsertするPLSQLを書きなさい。
このとき、Qより後のアルファベットで始まるJOBの人物のSALは
DEPTNO倍して足しなさい。

@C:\Users\Administrator\Documents\learnEIL\SQL\plSQL\kadai\review4.sql



*/


set SERVEROUTPUT on

DECLARE
  money1 number ;
  money2 number ;

BEGIN
  select SUM( NVL(E.SAL, 0) * E.deptno )
  into money1
  from emp E
  where substr(E.job, 1, 1) >= 'Q' ;

  select SUM( NVL(E.sal, 0) )
  into money2
  from emp E
  where substr(E.job, 1, 1) < 'Q' ;

  dbms_output.put_line(money1 + money2) ;

  insert into RESULT
    (NRESULT2)
  values
    (money1 + money2) ;
    
END ;
/
