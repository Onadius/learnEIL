/*
@C:\Users\Administrator\Desktop\text\SQL\plSQL\kadai.sql
予約語は変数に使えない。ex. sumやall
*/
--1.1～5000までの数字の足算の結果を
--RESULTテーブルのNRESULTにinsertするPLSQLを書きなさい。

SET SERVEROUTPUT ON
DECLARE
  num EMP.SAL%TYPE := 0;
  miku number := 0;

BEGIN
  LOOP
    exit when num >= 5001;
    miku := miku + num ;
    num := num + 1 ;
  END LOOP ;
  DBMS_OUTPUT.PUT_LINE(miku);

  insert into RESULT (
    NRESULT
  )
  values (
    miku
  );
END;
/


NO            NRESULT      CRESULT
---------- ---------- ------------
            12502500
