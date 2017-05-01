-- 副問い合わせ --
/*
最終的に求めたい結果であるSQL文を「主問合せ」、
主問合せの結果を得るための副次的な問合せを、「副問合せ」と呼びます。

副問合せは括弧で囲んで指定します。副問合せを実行すると、
Oracle Databaseの内部的には、まず括弧内に指定されたSQL文（副問合せ）を実行し、
その結果を使って主問合せを実行します。
*/
SELECT ENAME, SAL
FROM EMP
WHERE DEPTNO = ( SELECT DEPTNO
                 FROM EMP
                 WHERE EMPNO = 7698)
;

ENAME                       SAL
-------------------- ----------
ALLEN                      1600
WARD                       1250
MARTIN                     1250
BLAKE                      2850
TURNER                     1500
JAMES                       950

--従業員番号7654,7902と同じ部門にいる人の名前と給与を調べろ
SELECT ENAME, SAL
FROM EMP
WHERE DEPTNO IN ( SELECT DEPTNO
                  FROM EMP
                  WHERE EMPNO IN (7654, 7902))
;

--給与が最も低い社員は誰？
SELECT ENAME, SAL
FROM EMP
WHERE SAL = (SELECT MIN(SAL)
             FROM EMP)
;

ENAME                       SAL
-------------------- ----------
SMITH                       800


--部門の中で最も平均給与が低い部門はどれ
/*
（1） 副問合せで、部門ごとの平均給与の最低値を調べる
（2） 主問合せで、副問合せで調べた給与が平均給与である部門を調べる
*/
SELECT DEPTNO, TRUNC(AVG(SAL)) AS "AVE_SAL" --TRUNC関数は小数点切り捨て、ROUND関数は四捨五入
FROM EMP
GROUP BY DEPTNO
HAVING AVG(SAL) = (SELECT MIN(AVG(SAL))
                   FROM EMP
                   GROUP BY DEPTNO) ;

-- 給与が2900以上になる可能性のある職種についている人は誰か
/*複数の値(複数行副問い合わせ)と比較する場合には、
「＝」条件ではなく、「IN」条件を指定する必要がある*/

SELECT JOB, ENAME, SAL FROM EMP
WHERE JOB IN (SELECT JOB FROM EMP
              WHERE SAL > 2900 ) ;

              JOB                ENAME         SAL
------------------ -------------------- ----------
ANALYST            SCOTT                      3000
ANALYST            FORD                       3000
MANAGER            BLAKE                      2850
MANAGER            JONES                      2975
MANAGER            CLARK                      2450
PRESIDENT          KING                       5000


-- SMITHと同じ職種の社員を表示
SELECT ENAME FROM EMP
WHERE JOB = (SELECT JOB FROM EMP
             WHERE ENAME = 'SMITH') ;

ENAME
--------------------
SMITH
ADAMS
JAMES
MILLER

-- 副問い合わせを含む問い合わせ結果に順序を与える
SELECT ENAME, SAL FROM EMP
WHERE DEPTNO IN (SELECT DEPTNO FROM DEPT
                 WHERE DNAME = 'SALES')
ORDER BY SAL DESC ;


--自分が所属する部門の平均給与よりも、給与が高い社員は誰か
/*
「相関副問合せ」とは、
主問合せで処理したい行によって副問合せの条件を変えながら検索することができる構文

副問合せの中に主問合せで使用する表の名前（別名）を
指定することで、主問合せと副問合せの関係を記述します

副問合せ（i）の条件で使用する部門番号は、主問合せ（o）の候補行の部門番号を使う

主問合せに指定されたEMP表から、1行を選択（候補行）
その人が所属する部門番号を特定
その人が所属する部門番号を使って、副問合せを実行（所属する部門の平均給与を求める）
所属する部門の平均給与と、候補行となっている社員の給与を比較し、社員の給与の方が高ければ、検索結果として選択
表の次の候補行に対しても、上記1から4の処理を繰り返す

*/
SELECT ENAME, DEPTNO, SAL FROM EMP o
WHERE SAL > (SELECT AVG(SAL) FROM EMP i
             GROUP BY DEPTNO
             HAVING i.DEPTNO = o.DEPTNO ) ;

SELECT ENAME, SAL FROM EMP X
WHERE SAL > (
  SELECT AVG(SAL) FROM EMP O
  GROUP BY DEPTNO
  HAVING O.DEPTNO = X.DEPTNO
);
