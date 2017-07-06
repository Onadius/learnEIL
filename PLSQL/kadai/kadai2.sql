/*
@C:\Users\Administrator\Desktop\text\SQL\plSQL\kadai.sql
予約語は変数に使えない。ex. sumやall

2.一番小さいEMPNOの人のSALが1000以上だったら
　RESULTテーブルのCRESULTに'TRUE',
　1000未満だったら'FALSE'をinsertするPLSQLを書きなさい。

*/

SET SERVEROUTPUT ON
DECLARE
  miku EMP.ENAME%TYPE := 'TRUE' ;
  rin EMP.ENAME%TYPE := 'FALSE' ;
  ruka EMP.EMPNO%TYPE ;
  len emp.SAL%TYPE ;

BEGIN
  select E.SAL into len
  from EMP E
  where EMPNO = (
    select min(a.empno) from emp a
  ) ;
  DBMS_OUTPUT.PUT_LINE(len);

  if (len >= 1000) THEN
    insert into RESULT (
      CRESULT
    )
    values (
      miku
    ) ;
  else
    insert into RESULT (
      CRESULT
    )
    values (
      rin
    ) ;
  END if;
END;
/



NO            NRESULT     CRESULT
---------- ---------- ------------
     12502500
                            FALSE
