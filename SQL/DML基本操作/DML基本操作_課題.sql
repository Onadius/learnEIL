-- 35.表NEWEMPに指定のデータ追加
INSERT INTO NEWEMP (EMPNO, ENAME, HIREDATE)
VALUES (9000, 'KENNY', '90-10-25') ;

1行が作成されました。

SQL> SELECT * FROM NEWEMP WHERE ENAME = 'KENNY' ;

     EMPNO ENAME                JOB                       MGR HIREDATE        SAL       COMM     DEPTNO
---------- -------------------- ------------------ ---------- -------- ---------- ---------- -------
      9000 KENNY                                              90-10-25

-- 36.表NEWEMPに指定のデータ追加
INSERT INTO NEWEMP (EMPNO, ENAME, JOB, HIREDATE, SAL, DEPTNO)
VALUES (9021, 'ALICE', 'CLERK', '93-02-01', 1000, 10) ;

SELECT * FROM NEWEMP WHERE ENAME = 'ALICE' ;

EMPNO ENAME                JOB                       MGR HIREDATE        SAL       COMM     DEPTNO
---------- -------------------- ------------------ ---------- -------- ---------- ---------- -------
 9021 ALICE                CLERK                         93-02-01       1000                    10


-- 37. 表NEWEMPに指定のデータを追加
 INSERT INTO NEWEMP (EMPNO, ENAME, HIREDATE)
 VALUES (9040, 'JOHN', TO_DATE('92/04/10 9:00:00', 'YY/MM/DD HH24:MI:SS')) ;

 SELECT EMPNO, ENAME, TO_CHAR( HIREDATE, 'YY/MM/DD AMHH24:MI') AS HIREDATE
 FROM NEWEMP
 WHERE ENAME = 'JOHN' ;

 EMPNO ENAME                HIREDATE
---------- -------------------- ------------------------------------
 9040 JOHN                 92/04/10 午前09:00



 -- 38. 指定のデータを表EMPから表BONUSに追加
INSERT INTO BONUS (ENAME, JOB, SAL, COMM)
SELECT ENAME, JOB, SAL, COMM FROM EMP
WHERE SUBSTR(ENAME, 3, 1) = 'A';

SQL> SELECT * FROM BONUS ;

ENAME                JOB                       SAL       COMM
-------------------- ------------------ ---------- ----------
BLAKE                MANAGER                  3000
ADAMS                CLERK                    1100


-- 39.表NEWEMPに対して。職種がSALESMANの月給を一律SALESMANの平均月給1.1倍にする
UPDATE NEWEMP
SET SAL = (
  SELECT AVG(SAL) * 1.1 FROM NEWEMP
  GROUP BY JOB HAVING JOB = 'SALESMAN'
)
WHERE JOB = 'SALESMAN' ;

SQL> SELECT * FROM NEWEMP WHERE JOB = 'SALESMAN' ;

     EMPNO ENAME                JOB                       MGR HIREDATE        SAL       COMM     DEPTNO
---------- -------------------- ------------------ ---------- -------- ---------- ---------- -------
      7499 ALLEN                SALESMAN                 7698 81-02-20       1540        300         30
      7521 WARD                 SALESMAN                 7698 81-02-22       1540        500         30
      7654 MARTIN               SALESMAN                 7698 81-09-28       1540       1400         30
      7844 TURNER               SALESMAN                 7698 81-09-08       1540          0         30


-- 40.表NEWEMPに対して80年入社の社員の給与に200加算。
UPDATE NEWEMP
SET SAL = SAL + 200
WHERE SUBSTR(HIREDATE, 1, 2) = '80' ;

SELECT * FROM NEWEMP WHERE SUBSTR(HIREDATE, 1, 2) = '80' ;

EMPNO ENAME                JOB                       MGR HIREDATE        SAL       COMM     DEPTNO
---------- -------------------- ------------------ ---------- -------- ---------- ---------- -------
 7369 SMITH                CLERK                    7902 80-12-17       1000                    20


 -- 41.表NEWEMPのKINGさんのデータ消去
 DELETE FROM NEWEMP
 WHERE ENAME = (
   SELECT ENAME FROM NEWEMP
   WHERE ENAME = 'KING'
 );

 EMPNO ENAME                JOB                       MGR HIREDATE        SAL       COMM     DEPTNO
--------- -------------------- ------------------ ---------- -------- ---------- ---------- -------
 7369 SMITH                CLERK                    7902 80-12-17       1000                    20
 7499 ALLEN                SALESMAN                 7698 81-02-20       1540        300         30
 7521 WARD                 SALESMAN                 7698 81-02-22       1540        500         30
 7566 JONES                MANAGER                  7839 81-04-02       2975                    20
 7654 MARTIN               SALESMAN                 7698 81-09-28       1540       1400         30
 7698 BLAKE                MANAGER                  7839 81-05-01       2850                    30
 7782 CLARK                MANAGER                  7839 81-06-09       2450                    10
 7788 SCOTT                ANALYST                  7566 82-12-09       3000                    20
 7844 TURNER               SALESMAN                 7698 81-09-08       1540          0         30
 7876 ADAMS                CLERK                    7788 83-01-12       1100                    20
 7900 JAMES                CLERK                    7698 81-12-03        950                    30
 7902 FORD                 ANALYST                  7566 81-12-03       3000                    20
 7934 MILLER               CLERK                    7782 82-01-23       1300                    10
 9000 KENNY                                              90-10-25
 9021 ALICE                CLERK                         93-02-01       1000                    10
 9040 JOHN                                               92-04-10


-- 42.表NEWEMPに対してJONESさんと同じJOBの人を消去
DELETE FROM NEWEMP
WHERE JOB = (
  SELECT JOB FROM NEWEMP
  WHERE ENAME = 'JONES'
);

EMPNO ENAME                JOB                       MGR HIREDATE        SAL       COMM     DEPTNO
---------- -------------------- ------------------ ---------- -------- ---------- ---------- -------
 7369 SMITH                CLERK                    7902 80-12-17       1000                    20
 7499 ALLEN                SALESMAN                 7698 81-02-20       1540        300         30
 7521 WARD                 SALESMAN                 7698 81-02-22       1540        500         30
 7654 MARTIN               SALESMAN                 7698 81-09-28       1540       1400         30
 7788 SCOTT                ANALYST                  7566 82-12-09       3000                    20
 7844 TURNER               SALESMAN                 7698 81-09-08       1540          0         30
 7876 ADAMS                CLERK                    7788 83-01-12       1100                    20
 7900 JAMES                CLERK                    7698 81-12-03        950                    30
 7902 FORD                 ANALYST                  7566 81-12-03       3000                    20
 7934 MILLER               CLERK                    7782 82-01-23       1300                    10
 9000 KENNY                                              90-10-25
 9021 ALICE                CLERK                         93-02-01       1000                    10
 9040 JOHN                                               92-04-10


 -- 43. NEWEMPのデータをすべて削除した後、新たに表EMPから部門番号20の人のデータ追加
 DELETE FROM NEWEMP ;

 INSERT INTO NEWEMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
 SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO FROM EMP
 WHERE DEPTNO = 20 ;

 SQL> SELECT * FROM NEWEMP ;
 
      EMPNO ENAME                JOB                       MGR HIREDATE        SAL       COMM     DEPTNO
 ---------- -------------------- ------------------ ---------- -------- ---------- ---------- -------
       7369 SMITH                CLERK                    7902 80-12-17        800                    20
       7566 JONES                MANAGER                  7839 81-04-02       2975                    20
       7788 SCOTT                ANALYST                  7566 82-12-09       3000                    20
       7876 ADAMS                CLERK                    7788 83-01-12       1100                    20
       7902 FORD                 ANALYST                  7566 81-12-03       3000                    20
