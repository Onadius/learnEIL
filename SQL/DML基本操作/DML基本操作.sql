--行の追加
--列無指定方法
INSERT INTO EMP
VALUES (
  7954, 'CARTER', 'CLEARK', 7968, '88-4-1', 1000, NULL, 30
) ;

--列指定方法(これがいい)
INSERT INTO EMP (EMPNO, ENAME, HIREDATE, DEPTNO, SAL)
VALUES (
  7955, 'WILSON', SYSDATE, 30, 1500
);

--副問い合わせを含む行の追加
/*
INSERT INTO 表名 (列名, ...)
問い合わせ文
*/
INSERT INTO BONUS (ENAME, JOB, SAL, COMM)
SELECT ENAME, JOB, SAL, COMM FROM EMP
WHERE JOB = 'MANAGER' OR COMM > SAL * 0.25 ;


--既存値の更新
/*
UPDATE 表名
SET 列名 = 変更後の値, ...
WHERE 条件 <-場所の指定 ;
*/
UPDATE EMP
SET SAL = SAL*1.5
WHERE JOB = 'SALESMAN' ;


--BLAKEさんの給与をFORDさんと同じ給与に更新し、確認
UPDATE EMP
SET SAL = (
  SELECT SAL FROM EMP
  WHERE ENAME = 'FORD'
)
WHERE ENAME = 'BLAKE' ;

SELECT * FROM EMP
WHERE ENAME = 'BLAKE' ;



--表EMPに新しい列DEPT_NAMEを追加し、各社員が属する部門を挿入。
ALTER TABLE EMP ADD DEPT_NAME VARCHAR(15);

UPDATE EMP
SET DEPT_NAME = (
  SELECT DNAME FROM DEPT
  WHERE DEPT.DEPTNO = EMP.DEPTNO
);

--行の削除
--NewYorkに勤務する社員の削除
/*
DELETE FROM 表名
WHERE 列名 = (問い合わせ文) ;

*/
DELETE FROM EMP
WHERE DEPTNO = (
  SELECT DEPTNO FROM DEPT
  WHERE LOC = 'NEW YORK'
);

SELECT ENAME, LOC FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO ;

ENAME                LOC
-------------------- --------------------
SMITH                DALLAS
SCOTT                DALLAS
FORD                 DALLAS
ADAMS                DALLAS
JONES                DALLAS
BLAKE                CHICAGO
WILSON               CHICAGO
TURNER               CHICAGO
CARTER               CHICAGO
MARTIN               CHICAGO
JAMES                CHICAGO
WARD                 CHICAGO
ALLEN                CHICAGO


--ビューを用いたデータ変更における制限
--EMPとDEPTの結合ビューを作成
CREATE VIEW EMPDEPT
AS SELECT ENAME, JOB, SAL, DNAME, LOC FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO ;

ビューが作成されました・

--データ変更制限の確認
INSERT INTO EMPDEPT
VALUES('DONALD', 'CLERK', 2000, 'TECHNICAL', 'SAN FRANCISCO') ;

行1でエラーが発生しました。:
ORA-01779: キー保存されていない表にマップする列は変更できません

UPDATE EMPDEPT
SET JOB = 'ANALYST'
WHERE ENAME = 'SMITH' ;

行2でエラーが発生しました。:
ORA-01779: キー保存されていない表にマップする列は変更できません
