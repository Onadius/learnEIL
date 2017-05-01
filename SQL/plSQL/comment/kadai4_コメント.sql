/*
修正済み
4.EMP表に存在する人物のSALを全て足して、
RESULTテーブルのNRESULT2にinsertするPLSQLを書きなさい。
このとき、Qより後のアルファベットで始まるJOBの人物のSALは
DEPTNO倍して足しなさい。
*/

DECLARE
 sal1 number ;
 sal2 number ;

BEGIN
  select
    sum(a.sal * a.deptno) into sal1
  from
    emp a
  where
    substr(a.job,1,1) >= 'Q'
  order by a.job;

  select
    sum(e.sal) into sal2
  from
    emp e
  where substr(e.job,1,1) < 'Q' ;

  DBMS_OUTPUT.PUT_LINE(sal1 + sal2);

  insert into RESULT (
    NRESULT2
  )
  values (
    sal1 + sal2
  ) ;

END ;
/

188425


/* 添削 */

これも意図しない結果が…

a.job like 'C%'⇒頭がCで始まる人。
a.job not like 'C%'⇒頭がCで始まらない人

"Cより後のアルファベットで始まるJOBの人物"は

-- これ
select * from emp a where substr(a.job,1,1) >= 'C' order by job;

-- 大文字小文字を考慮するならこれ
select * from emp a where upper(substr(a.job,1,1)) >= 'C';


          EMPNO ENAME                JOB                            MGR HIREDATE                    SAL            COMM          DEPTNO
--------------- -------------------- ------------------ --------------- --------------- --------------- --------------- ---------------
           7934 MILLER               CLERK                         7782 19820123 000000            1300 @                            10
           7900 JAMES                CLERK                         7698 19811203 000000             950 @                            30
           7876 ADAMS                CLERK                         7788 19830112 000000            1100 @                            20
           7369 SMITH                CLERK                         7902 19801217 000000             800 @                            20
           7566 JONES                MANAGER                       7839 19810402 000000            2975 @                            20
           7698 BLAKE                MANAGER                       7839 19810501 000000            2850 @                            30
           7782 CLARK                MANAGER                       7839 19810609 000000            2450 @                            10
           7839 KING                 PRESIDENT          @               19811117 000000            5000 @                            10
           7844 TURNER               SALESMAN                      7698 19810908 000000            1500               0              30
           7521 WARD                 SALESMAN                      7698 19810222 000000            1250             500              30
           7499 ALLEN                SALESMAN                      7698 19810220 000000            1600             300              30
           7654 MARTIN               SALESMAN                      7698 19810928 000000            1250            1400              30



ちなみに問題は'C'じゃなくて'Q'だったと思いますが…これはどっちでもいいです。
