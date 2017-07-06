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
    ); --取得できてる

BEGIN
  for rec1 in jobnames loop
    dbms_output.put_line(rec1.job);
    insert into RESULT
    (JNRESULT)
    values
    (rec1.job) ;
  END loop ;
END;
/

select jnresult from result ;

JNRESULT
------------------------------
CLERK
SALESMAN




===========================================
/* 添削 */

★これは1箇所バグってます。
★実行結果がこれ↓


22:07:31 SQL> DECLARE
22:07:32   2    cursor jobnames is
22:07:32   3      select
22:07:32   4        e.job
22:07:32   5      from
22:07:32   6        emp e
22:07:32   7      group by e.job
22:07:32   8      having
22:07:32   9        COUNT(e.ename) = (
22:07:32  10          select max(count(a.ename))
22:07:32  11          from emp a
22:07:32  12          group by a.job
22:07:32  13      );
22:07:32  14
22:07:32  15    r1 jobnames%rowtype ;
22:07:32  16
22:07:32  17  BEGIN
22:07:32  18    open jobnames ;
22:07:32  19    loop
22:07:32  20      dbms_output.put_line(r1.job);
22:07:32  21      insert into RESULT (
22:07:32  22        JNRESULT
22:07:32  23      )
22:07:32  24      values (
22:07:32  25        r1.job
22:07:32  26      ) ;
22:07:32  27      FETCH jobnames into r1 ;
22:07:32  28      exit when jobnames%notfound ;
22:07:32  29    END loop ;
22:07:32  30    close jobnames;
22:07:32  31  END;
22:07:32  32  /
CLERK
SALESMAN

PL/SQLプロシージャが正常に完了しました。

経過: 00:00:00.01
22:07:32 SQL>
22:07:32 SQL>
22:07:33 SQL> select * from result;

             NO         NRESULT CRESULT                                  JNRESULT
--------------- --------------- ---------------------------------------- ---------------------------
@               @               @                                        @                              			★←JNRESULT=NULLの行ができてる。
@               @               @                                        CLERK
@               @               @                                        SALESMAN

経過: 00:00:00.02



★何故こうなるか考えてみてください。★
