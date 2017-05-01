--3.一番多いJOBの名前をRESULTテーブルのJNRESULTにinsertするPLSQLを書きなさい。
--@C:\Users\Administrator\Desktop\text\SQL\plSQL\kadai.sql

SET SERVEROUTPUT ON
DECLARE
  cursor jobnames is
    select
      e.job
    from
      emp e
    group by e.job
    having
      COUNT(e.ename) = (
        select max(count(a.ename))
        from emp a
        group by a.job
    );

  r1 jobnames%rowtype ;

BEGIN
  open jobnames ;
  loop
    dbms_output.put_line(r1.job);
    FETCH jobnames into r1 ;
    insert into RESULT (
      JNRESULT
    )
    values (
      r1.job
    ) ;
    exit when jobnames%notfound ;
  END loop ;
  close jobnames;
END;
/


JNRESULT
------------------------------


CLERK


SALESMAN
