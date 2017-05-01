-- 23. 2-34の問い合わせを降順に並び替え
SELECT ENAME FROM EMP
UNION
SELECT DNAME FROM DEPT
ORDER BY ENAME DESC ;

ENAME
--------------------
WARD
TURNER
SMITH
SCOTT
SALES
RESEARCH
OPERATIONS
MILLER
MARTIN
KING
JONES
JAMES
FORD
CLARK
BLAKE
ALLEN
ADAMS
ACCOUNTING


-- 24. GRADEが4以上の社員を表示
SELECT GRADE, ENAME FROM EMP, SALGRADE
WHERE GRADE >= 4 ;

GRADE ENAME
---------- --------------------
    4 SMITH
    4 ALLEN
    4 WARD
    4 JONES
    4 MARTIN
    4 BLAKE
    4 CLARK
    4 SCOTT
    4 KING
    4 TURNER
    4 ADAMS

GRADE ENAME
---------- --------------------
    4 JAMES
    4 FORD
    4 MILLER
    5 SMITH
    5 ALLEN
    5 WARD
    5 JONES
    5 MARTIN
    5 BLAKE
    5 CLARK
    5 SCOTT
    5 KING
    5 TURNER
    5 ADAMS
    5 JAMES
    5 FORD
    5 MILLER


-- 25.所在地の頭文字Ｎで始まる部門と、そこに属する社員
SELECT DNAME, ENAME FROM EMP, DEPT
WHERE DNAME = (
  SELECT DNAME FROM DEPT
  WHERE LOC LIKE 'N%'
);

DNAME                ENAME
-------------------- --------------------
ACCOUNTING           JAMES
ACCOUNTING           FORD
ACCOUNTING           MILLER

-- 26. 各部門のDNAME毎にSALの平均を表示
/*表の結合を行う際は、結合条件を指定。表に共通する情報が含めれることが条件*/
SELECT DNAME, ROUND(AVG(SAL))
FROM EMP E, DEPT D
WHERE D.DEPTNO = E.DEPTNO
GROUP BY DNAME ;

DNAME                ROUND(AVG(SAL))
-------------------- ---------------
ACCOUNTING                      2917
RESEARCH                        2175
SALES                           1567

-- 27.社員が一人も存在しない部門名(DNAME)の表示
SELECT DNAME FROM DEPT
WHERE DEPTNO = (
  SELECT DEPTNO FROM DEPT
  MINUS
  SELECT DEPTNO FROM EMP
);
