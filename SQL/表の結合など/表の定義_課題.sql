--表の定義

--28.テキスト内の定義にて、表PRODUCTを作成せよ
CREATE TABLE PRODUCT (
  PRODID NUMBER(3),
  NAME VARCHAR2(20),
  DESCRIPTION VARCHAR2(255)
);

DESCRIBE PRODUCT
 名前                                      NULL?    型
 ----------------------------------------- -------- ----------------------------
 PRODID                                             NUMBER(3)
 NAME                                               VARCHAR2(20)
 DESCRIPTION                                        VARCHAR2(255)


--29. EMP表と同一の定義及びデータを持つ表NEWEMPを作成せよ
CREATE TABLE NEWEMP AS SELECT * FROM EMP ;

SQL> SELECT * FROM NEWEMP ;

     EMPNO ENAME                JOB                       MGR HIREDATE
---------- -------------------- ------------------ ---------- --------
       SAL       COMM     DEPTNO
---------- ---------- ----------
      7369 SMITH                CLERK                    7902 80-12-17
       800                    20

      7499 ALLEN                SALESMAN                 7698 81-02-20
      1600        300         30

      7521 WARD                 SALESMAN                 7698 81-02-22
      1250        500         30

      7566 JONES                MANAGER                  7839 81-04-02
      2975                    20

      7654 MARTIN               SALESMAN                 7698 81-09-28
      1250       1400         30

      7698 BLAKE                MANAGER                  7839 81-05-01
      2850                    30

      7782 CLARK                MANAGER                  7839 81-06-09
      2450                    10

      7788 SCOTT                ANALYST                  7566 82-12-09
      3000                    20

      7839 KING                 PRESIDENT                     81-11-17
      5000                    10

      7844 TURNER               SALESMAN                 7698 81-09-08
      1500          0         30

      7876 ADAMS                CLERK                    7788 83-01-12
      1100                    20

      7900 JAMES                CLERK                    7698 81-12-03
       950                    30

      7902 FORD                 ANALYST                  7566 81-12-03
      3000                    20

      7934 MILLER               CLERK                    7782 82-01-23
      1300                    10

14行が選択されました。


--30. EMP表のMANAGER職のデータのみを検索できるビューMANAGERを作成せよ
CREATE VIEW MANAGER AS
  SELECT * FROM EMP
  WHERE JOB = 'MANAGER' ;

  SQL> SELECT * FROM MANAGER ;

       EMPNO ENAME                JOB                       MGR HIREDATE
  ---------- -------------------- ------------------ ---------- --------
         SAL       COMM     DEPTNO
  ---------- ---------- ----------
        7566 JONES                MANAGER                  7839 81-04-02
        2975                    20

        7698 BLAKE                MANAGER                  7839 81-05-01
        2850                    30

        7782 CLARK                MANAGER                  7839 81-06-09
        2450                    10


--31. 表PRODUCTのDESCRIPTIONの定義をLONG型に変更
ALTER TABLE PRODUCT MODIFY DESCRIPTION LONG ;

SQL> DESCRIBE PRODUCT ;
 名前                                      NULL?    型
 ----------------------------------------- -------- ----------------------------
 PRODID                                             NUMBER(3)
 NAME                                               VARCHAR2(20)
 DESCRIPTION                                        LONG



--32.表PRODUCTにSUM NUMBER(5) 列を追加
ALTER TABLE PRODUCT ADD SUM NUMBER(5) ;

SQL> DESCRIBE PRODUCT ;
 名前                                      NULL?    型
 ----------------------------------------- -------- ----------------------------
 PRODID                                             NUMBER(3)
 NAME                                               VARCHAR2(20)
 DESCRIPTION                                        LONG
 SUM                                                NUMBER(5)


 --33.表PRODUCTの削除
 DROP TABLE PRODUCT ;
 表が削除されました・

 --34. ビューMANAGERの削除
 DROP VIEW MANAGER ;
 ビューが削除されました。
