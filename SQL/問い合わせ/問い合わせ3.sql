--集合演算
-- UNION 別の表の内容を結合して表示
-- UNION ALL で重複すべて表示
SELECT ENAME FROM EMP
UNION
SELECT DNAME FROM DEPT ;

--INTERSECT 両方の表に共通するものを表示
SELECT DEPTNO FROM EMP
INTERSECT
SELECT DEPTNO FROM DEPT ;

--MINNUS 1の表にあり、2の表にないものを表示

--表の結合
--EQUI JOIN
SELECT D.DEPTNO, ENAME, DNAME, LOC FROM EMP E, DEPT D
WHERE D.DEPTNO = E.DEPTNO
ORDER BY D.DEPTNO ;

DEPTNO ENAME                DNAME                LOC
---------- -------------------- -------------------- --------------------
    10 CLARK                ACCOUNTING           NEW YORK
    10 KING                 ACCOUNTING           NEW YORK
    10 MILLER               ACCOUNTING           NEW YORK
    20 JONES                RESEARCH             DALLAS
    20 FORD                 RESEARCH             DALLAS
    20 ADAMS                RESEARCH             DALLAS
    20 SMITH                RESEARCH             DALLAS
    20 SCOTT                RESEARCH             DALLAS
    30 WARD                 SALES                CHICAGO
    30 TURNER               SALES                CHICAGO
    30 ALLEN                SALES                CHICAGO
    30 JAMES                SALES                CHICAGO
    30 BLAKE                SALES                CHICAGO
    30 MARTIN               SALES                CHICAGO

--NON EQUI-JOIN
SELECT GRADE, JOB, ENAME, SAL FROM EMP, SALGRADE
WHERE SAL BETWEEN LOSAL AND HISAL
AND JOB = 'CLERK'
ORDER BY GRADE ;

GRADE JOB                ENAME                       SAL
---------- ------------------ -------------------- ----------
    1 CLERK              SMITH                       800
    1 CLERK              ADAMS                      1100
    1 CLERK              JAMES                       950
    2 CLERK              MILLER                     1300

--SELF JOIN
SELECT WORKER.ENAME, WORKER.SAL, MANAGER.ENAME, MANAGER.SAL
FROM EMP WORKER, EMP MANAGER
WHERE WORKER.MGR = MANAGER.EMPNO
AND WORKER.SAL > MANAGER.SAL ;

ENAME                       SAL ENAME                       SAL
-------------------- ---------- -------------------- ----------
FORD                       3000 JONES                      2975
SCOTT                      3000 JONES                      2975

--部門平均より多く給与を貰っている社員の表示
SELECT DEPTNO, ENAME, SAL FROM EMP X
WHERE SAL > (
  SELECT AVG(SAL) FROM EMP
  WHERE DEPTNO = X.DEPTNO
);
