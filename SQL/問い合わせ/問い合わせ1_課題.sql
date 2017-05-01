-- 練習問題_問い合わせ

/*
実行結果の省略を、
...
にて表記しています。
*/

-- 1.従業員番号を表示
SELECT EMPNO
FROM EMP
;

EMPNO
----------
 7369
 7499
 7521
 7566
 7654
 7698
 7782
 ...

 -- 2.会社に従事している全社員の全データ表示(実行結果省略)
 SELECT *
 FROM EMP ;

 ...

 -- 3.ENAME列のヘッダーをEmployeeに変更
 SELECT ENAME AS "Employee"
 FROM EMP ;

 Employee
-------------------
SMITH
ALLEN
WARD
JONES
MARTIN
...

-- 4.文字列Mr.を連結して従業員名の表示
SELECT 'Mr.' || ENAME AS "従業員名"
FROM EMP ;

従業員名
--------------------------
Mr.SMITH
Mr.ALLEN
Mr.WARD
Mr.JONES
...

-- 5.部門ごとにどのような職種があるのか表示
SELECT DISTINCT DEPTNO, JOB
FROM EMP
ORDER BY DEPTNO ;

DEPTNO JOB
---------- ----------------
    10 CLERK
    10 MANAGER
    10 PRESIDENT
    20 ANALYST
    20 CLERK
    20 MANAGER
    30 CLERK
    30 MANAGER
    30 SALESMAN

-- 6.職種がCLERKの社員を表示
SELECT ENAME
FROM EMP
WHERE JOB = 'CLERK' ;

ENAME
--------------------
SMITH
ADAMS
JAMES
MILLER

-- 7.入社日が81-04-01より前の社員を表示
SELECT ENAME
FROM EMP
WHERE HIREDATE <= '81-04-01' ;

ENAME
--------------------
SMITH
ALLEN
WARD

-- 8.部門10に所属し、職種がMANAGERの社員
SELECT ENAME
FROM EMP
WHERE DEPTNO = 10 AND JOB = 'MANAGER' ;

ENAME
--------------------
CLARK

-- 9.基本給、歩合給あわせて$3000より多くもらっている社員
SELECT ENAME
FROM EMP
WHERE (SAL + NVL(COMM, 0)) > 3000 ; --NVL関数 -> NVL(値1, 値2) NULLのとき値2返す

ENAME
--------------------
KING

-- 10.職種がPRESODENT及びMANAGER以外の社員を表示
SELECT ENAME
FROM EMP
WHERE JOB NOT IN ('PRESODENT', 'MANAGER') ;

ENAME
--------------------
SMITH
ALLEN
WARD
MARTIN
SCOTT
KING
TURNER
ADAMS
JAMES
FORD
MILLER

-- 11.JOBがSALESMANもしくは、$3000よりも多くSALを貰っている社員を表示
SELECT ENAME
FROM EMP
WHERE JOB = 'SALESMAN' OR SAL > 3000 ;

ENAME
--------------------
ALLEN
WARD
MARTIN
KING
TURNER

-- 12.頭文字がＢではじまる社員を表示
SELECT ENAME
FROM EMP
WHERE ENAME LIKE 'B%' ;

ENAME
--------------------
BLAKE

-- 13.名前にKという文字を含まない社員の表示
SELECT ENAME
FROM EMP
WHERE ENAME NOT LIKE '%K%' ;

ENAME
--------------------
SMITH
ALLEN
WARD
JONES
MARTIN
SCOTT
TURNER
ADAMS
JAMES
FORD
MILLER


-- 14.勤続年数の長い順番に社員表示
SELECT ENAME, HIREDATE
FROM EMP
ORDER BY HIREDATE ;

ENAME                HIREDATE
-------------------- --------
SMITH                80-12-17
ALLEN                81-02-20
WARD                 81-02-22
JONES                81-04-02
BLAKE                81-05-01
CLARK                81-06-09
TURNER               81-09-08
MARTIN               81-09-28
KING                 81-11-17
JAMES                81-12-03
FORD                 81-12-03
MILLER               82-01-23
SCOTT                82-12-09
ADAMS                83-01-12

-- 15.DEPTNO毎に、給料を多くもらっている社員を順に表示
SELECT DEPTNO, ENAME, SAL
FROM EMP
ORDER BY DEPTNO, SAL DESC ;

DEPTNO ENAME                       SAL
---------- -------------------- ----------
    10 KING                       5000
    10 CLARK                      2450
    10 MILLER                     1300
    20 SCOTT                      3000
    20 FORD                       3000
    20 JONES                      2975
    20 ADAMS                      1100
    20 SMITH                       800
    30 BLAKE                      2850
    30 ALLEN                      1600
    30 TURNER                     1500
    30 MARTIN                     1250
    30 WARD                       1250
    30 JAMES                       950

-- 16.JOB毎に、社員が何人いるのか表示
SELECT JOB, COUNT(ENAME) AS "所属人数"
FROM EMP
GROUP BY JOB ;

JOB                  所属人数
------------------ ----------
ANALYST                     2
CLERK                       4
MANAGER                     3
PRESIDENT                   1
SALESMAN                    4


-- 17.社員が二人以上いるJOB毎に、給料の平均を表示
/*
WHERE句は、1行1行のデータに対して条件を指定するキーワードであるため、
グループ化した結果に対して使うことができません。
*/
SELECT JOB, AVG(SAL) AS "給与平均"
FROM EMP
GROUP BY JOB
HAVING COUNT(ENAME) >= 2 ;

JOB                  給与平均
------------------ ----------
ANALYST                  3000
CLERK                  1037.5
MANAGER            2758.33333
SALESMAN                 1400
