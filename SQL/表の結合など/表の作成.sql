/*
表(table)の作成
CREATE TABLE 表名 (
  列名 データ型(列の幅) [DEFAULT値] [制約]
  ・・・
) ;


*/


CREATE TABLE PROJ (
  PROJNO NUMBER(3) NOT NULL,
  PNAME VARCHAR2(5),
  BUDGET NUMBER(7, 2)
);

DESCRIBE PROJ

CREATE TABLE PROJ (
  PROJNO NUMBER(3) NOT NULL,
  PNAME VARCHAR2(5),
  BUDGET NUMBER(7, 2) DEFAULT 2000
);


CREATE TABLE DEPT
(
  DEPTNO NUMBER CONSTRAINT SYU_DEPTNO PRIMARY KEY,
  DNAME VARCHAR2(9) CONSTRAINT ICII_DNAME UNIQUE,
  LOC VARCHAR2(10)
);


-- 整合性制約
/*
表の各列に対して任意にルールを設定可能。
・NOT NULL制約
・UNIQUE制約
・PRIMARY KEY制約
・FOREIGN KEY制約
・CHECK制約
*/





/*
副問い合わせを含む表の作成
CREATE TABLE 表明 (列名, ....) AS 問い合わせ文
↑
列名を指定しない場合は、問い合わせで選択された列名が割り当てられる
*/

-- 部門10に所属する社員で構成される表EMP2を作成
CREATE TABLE EMP2 (
  NAME, SALARY, DEPARTMENT_NO
)
AS SELECT ENAME, SAL, DEPTNO FROM EMP
WHERE DEPTNO = 10 ;

-- MANAGER職、もしくは給与の25%よりも歩合のほうが高い社員で構成される表BOUNUSの作成
CREATE TABLE BOUNUS
AS SELECT ENAME, JOB, SAL, COMM FROM EMP
WHERE JOB = 'MANAGER' OR COMM > 0.25 * SAL ;



--ビューの作成
/*
表の情報を参照したり。変更したりできる。
データベース内には実在しないが、見かけ上は表と同様で、
表と同様に扱える。

*/

-- 部門10の社員で構成されるビューを、表EMPから作成
CREATE VIEW EMP10
AS SELECT EMPNO, ENAME, JOB FROM EMP
WHERE DEPTNO = 10 ;

EMPNO ENAME                JOB
---------- -------------------- ------------------
 7782 CLARK                MANAGER
 7839 KING                 PRESIDENT
 7934 MILLER               CLERK

-- 職種がANALYSTで構成されるビューANALYSTを列名を変えて作成
CREATE VIEW ANALYST (ENO, NAME, JOB, DNO) AS
  SELECT EMPNO, ENAME, JOB, DEPTNO FROM EMP
  WHERE JOB = 'ANALYST'
WITH CHECK OPTION ;



-- 列定義の変更
--表PROJに各種データを追加する
/*
ALTER TABLE 表名 MODIFY 列名 データ型(列の幅) [NULL値の取り扱い];

*/
INSERT INTO PROJ VALUES (101, 'ALPHA', 105000);

行1でエラーが発生しました。:
ORA-01438: この列に許容される指定精度より大きな値です

ALTER TABLE PROJ MODIFY BUDGET NUMBER(8, 2);

表が変更されました

INSERT INTO PROJ VALUES (101, 'ALPHA', 105000);

SQL> SELECT * FROM PROJ ;

    PROJNO PNAME          BUDGET
---------- ---------- ----------
       101 ALPHA          105000


--列の追加
--表DEPTにPROJNO列を追加
/*
ALTER TABLE 表名 ADD 列名 データ型(列幅) [[NULL値の取り扱い];
表定義の最後に新しい列を追加する
既に存在している列の右側に新しい列の追加。列の初期値はNULL値
*/
ALTER TABLE DEPT
ADD PROJNO NUMBER(3) ;
SQL> SELECT * FROM DEPT ;

    DEPTNO DNAME                LOC                      PROJNO
---------- -------------------- -------------------- ----------
        10 ACCOUNTING           NEW YORK
        20 RESEARCH             DALLAS
        30 SALES                CHICAGO
        40 OPERATIONS           BOSTON

-- 表、ビューの改名
--DEPTをDEPARTMENTに改名
/*
RENAME 表名/ビュー名 TO 新しい名前
改名前の表またはビューを参照するビューは無効になる
改定あるいは削除の必要ある
*/
RENAME DEPT TO DEPARTMENT ;


--表とビューの削除
--データベースからPROJを削除
/*
削除された表に基づくビューは無効になる
改定及び削除の必要あり
*/
DROP TABLE PROJ ;

DROP VIEW EMP10 ;--元の表には影響なし
