/*
修正済み
2.一番小さいEMPNOの人のSALが1000以上だったら
　RESULTテーブルのCRESULTに'TRUE',
　1000未満だったら'FALSE'をinsertするPLSQLを書きなさい。

*/

SET SERVEROUTPUT ON
DECLARE
  miku VARCHAR2(6) ;
    len emp.SAL%TYPE ;

BEGIN
  select E.SAL into len
  from EMP E
  where EMPNO = (
    select min(a.empno) from emp a
  ) ;
  DBMS_OUTPUT.PUT_LINE(len);

  if (len >= 1000) THEN
    miku := 'TRUE' ;
  else
    miku := 'FALSE' ;
  END if;
  insert into result (CRESULT) values (miku) ;

END;
/

NO            NRESULT     CRESULT
---------- ---------- ------------
     12502500
                            FALSE




==============================
/* 添削 */

DECLARE
--  miku EMP.ENAME%TYPE := 'TRUE' ;				/* 不要 */
--  rin EMP.ENAME%TYPE := 'FALSE' ;				/* 不要 */
  w_ret		VARCHAR2(5);						/* 追加 */
  ruka EMP.EMPNO%TYPE ;							/* 未使用変数は不要 */
  len emp.SAL%TYPE ;

BEGIN
  select E.SAL into len
  from EMP E
  where EMPNO = (
    select min(a.empno) from emp a
  ) ;
  DBMS_OUTPUT.PUT_LINE(len);

  if (len >= 1000) THEN
	w_ret := 'TRUE';							/* IFの分岐で2回INSERT書く必要はない。IFの外で1回で済む。 */
--    insert into RESULT (						/* 宣言部のmiku/rinの値を確認しないといけないので変数使用しなくて良い。（ただしケースによります） */
--      CRESULT
--    )
--    values (
--      miku
--    ) ;
  else
	w_ret := 'FALSE';
--    insert into RESULT (
--      CRESULT
--    )
--    values (
--      rin
--    ) ;
  END if;

  insert into RESULT (CRESULT) values (w_ret);	/* 1回で。 */

END;
/
