--行のグループ分け
--GROUP BY 列 ->FROM句で指定された表の中の列
/*
今回使用する「GROUP BY」句を使用すると、特定の列をキーにした合計値や
平均値などが表示される結果となります。
*/

/*
WHERE句は、1行1行のデータに対して条件を指定するキーワードであるため、
グループ化した結果に対して使うことができません。
*/

--「GROUP BY」句の制約
/*「SELECT」句には、GROUP BYで指定した列と集計関数のみを指定することができます。*/

SELECT DEPTNO, MIN(SAL), MAX(SAL)
FROM EMP
GROUP BY DEPTNO
HAVING MIN(SAL) < 1200
;

--
--
SELECT JOB, SUM(SAL)
FROM EMP
WHERE HIREDATE >= '81-04-01'
GROUP BY JOB HAVING SUM(SAL) >= 3000 --HAVING句-> GROUP BYによる集計行に対して抽出条件を指定
;

JOB                  SUM(SAL)
------------------ ----------
ANALYST                  6000
CLERK                    3350
MANAGER                  8275
PRESIDENT                5000


/*-------*/
SELECT DEPTNO, SUM(SAL)
FROM EMP
WHERE JOB != 'CLEARK'
GROUP BY DEPTNO
HAVING SUM(SAL) > 8000
ORDER BY SUM(SAL)
;
