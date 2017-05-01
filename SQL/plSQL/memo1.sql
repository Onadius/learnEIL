--変数宣
--@C:\Users\Administrator\Desktop\text\SQL\plSQL\memo1.sql
/*
DECLARE
  v_name varchar2(10);
  v_job varchar2(10);

BEGIN
  selct
    ename, job into v_name, v_job
  from EMP
  where EMPNO = &社員番号;

  DBMS_OUTPUT.PUT_LINE(v_name);
END ;
/
*/

/*
DECLARE
  v_ename emp.ename%type;
  v_sal emp.sal%type ;
BEGIN
  select sal ,ename into v_sal, v_ename from emp where empno = 7934;
   DBMS_OUTPUT.PUT_LINE(v_ename);
END ;
/
*/

set serveroutput on
set verify off
DECLARE
   V_EMPNO   EMP.EMPNO%TYPE := &社員番号;
   V_ENAME   EMP.ENAME%TYPE;
   V_DEPTNO  DEPT.DEPTNO%TYPE;
   V_DNAME   DEPT.DNAME%TYPE;
BEGIN
   /* 指定された社員番号をもとに社員名と部門番号を取得する */
   SELECT ENAME, DEPTNO INTO V_ENAME, V_DEPTNO
   FROM   EMP
   WHERE  EMPNO = V_EMPNO;
  /*その部門番号で、部門表を問い合わせて、部門名を取得する*/
   SELECT DNAME INTO V_DNAME FROM DEPT
   WHERE  DEPTNO = V_DEPTNO;
  DBMS_OUTPUT.PUT_LINE(V_ENAME);

EXCEPTION
   WHEN  NO_DATA_FOUND  THEN
     DBMS_OUTPUT.PUT_LINE(V_EMPNO);
END;
/
