--副問い合わせ演習課題

-- 18. SCOTTさんと同じ職種(JOB)の社員すべて表示
SELECT ENAME, JOB FROM EMP
WHERE JOB = (SELECT JOB FROM EMP
             WHERE ENAME = 'SCOTT') ;

ENAME                JOB
-------------------- ------------------
SCOTT                ANALYST
FORD                 ANALYST

 ⇒★OKです（黒）

-- 19.SMITHさんのSALよりも多くの歩合を貰っている社員
SELECT ENAME, COMM FROM EMP
WHERE COMM > (
  SELECT SAL FROM EMP
  WHERE ENAME = 'SMITH'
) ;

ENAME                      COMM
-------------------- ----------
MARTIN                     1400

 ⇒★OKです（黒）


--20. すべてのMANAGER職より多く給料をもらっている社員表示
SELECT ENAME, SAL FROM EMP
WHERE SAL > ALL (
  SELECT SAL FROM EMP
  WHERE JOB = 'MANAGER'
) ;

ENAME                       SAL
-------------------- ----------
SCOTT                      3000
KING                       5000
FORD                       3000

 ⇒★OKです（黒）


-- 21.CHICAGOで働くすべての社員よりも多くSALを貰っている社員を、給料多い順に表示

SELECT ENAME, SAL FROM EMP
WHERE SAL > ALL (
  SELECT SAL FROM EMP
  WHERE DEPTNO = (
    SELECT DEPTNO FROM DEPT
    WHERE LOC = 'CHICAGO'
  )
)
ORDER BY SAL DESC ;

ENAME                       SAL
-------------------- ----------
KING                       5000
FORD                       3000
SCOTT                      3000
JONES                      2975

 ⇒★OKです（黒）

===================

-- 21.
★副問い合わせの問題なので回答としては満点ですが、
 一般的には副問い合わせの中でテーブル結合で取得します。
 （※次の章が結合なので知らなくて当然）

SELECT ENAME, SAL FROM EMP
WHERE SAL > ALL (
  SELECT SAL FROM EMP, DEPT
  WHERE EMP.DEPTNO = DEPT.DEPTNO
  AND DEPT.LOC = 'CHICAGO'
)
ORDER BY SAL DESC ;


SELECT ENAME, SAL FROM EMP
WHERE SAL > ALL (
  SELECT SAL FROM DEPT a,EMP b
  WHERE b.DEPTNO = a.DEPTNO
    AND a.LOC = 'CHICAGO'
)
ORDER BY SAL DESC ;

===================



-- 22.FORDさんと同じJOBもしくは、SCOTTさんと同じDEPTNOに所属している社員を表示
SELECT ENAME FROM EMP
WHERE JOB = (
  SELECT JOB FROM EMP
  WHERE ENAME = 'FORD'
) OR DEPTNO = (
  SELECT DEPTNO FROM EMP
  WHERE ENAME = 'SCOTT'
) ;

ENAME
--------------------
SMITH
JONES
SCOTT
ADAMS
FORD


 ⇒★OKです（黒）
