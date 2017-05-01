1.年ごとの入社人数と配属地域を知りたい
/*
⇒★having句って何をしてるの？
　　　having句なしの形で正解なんだけど…
*/
SELECT
  DISTINCT to_char(A.HIREDATE, 'yyyy') AS "入社年",
  COUNT(A.ENAME) AS "入社人数",
  COUNT(DISTINCT(C.LOC)) AS "配属地域数"
FROM
  EMP A,
  DEPT C
WHERE
  A.DEPTNO = C.DEPTNO --内部結合
GROUP BY to_char(A.HIREDATE, 'yyyy') ;


入社年     入社人数 配属地域数
-------- ---------- ----------
1980              1          1
1981             10          3
1982              2          2
1983              1          1




２.直属の部下が２人以下の社員情報(名前、所属部署)と部下の人数を知りたい。
部下が居ない場合も表示する。-> IS NULL?

SELECT E.ENAME, D.DNAME,
CASE WHEN
  COUNT(BUKA.MGR) IS NULL THEN 0 ELSE COUNT(BUKA.MGR) END AS "部下人数"
FROM
  EMP E,
  EMP BUKA,
  DEPT D
WHERE
  E.EMPNO = BUKA.MGR(+)
AND
  E.DEPTNO = D.DEPTNO
GROUP BY (E.ENAME, D.DNAME) HAVING COUNT(BUKA.MGR) <= 2;

ENAME                DNAME                  部下人数
-------------------- -------------------- ----------
TURNER               SALES                         0
CARTER               SALES                         0
WILSON               SALES                         0
ADAMS                RESEARCH                      0
MARTIN               SALES                         0
JAMES                SALES                         0
WARD                 SALES                         0
SMITH                RESEARCH                      0
JONES                RESEARCH                      2
ALLEN                SALES                         0
SCOTT                RESEARCH                      1
FORD                 RESEARCH                      1




３．直属の上司と勤務地が違う社員の情報が知りたい。
上司の社員番号、名前、勤務地も表示する。
/*
SELECT E.ENAME, MNG.EMPNO, MNG.ENAME, D.LOC
FROM DEPT D LEFT JOIN EMP E ON D.DEPTNO = E.DEPTNO, EMP MNG
WHERE E.MGR = MNG.EMPNO ; --直属の上司と勤務地を表示
*/

/*
　⇒★結果がないよーと思ったら、buser2のデータが書き換えられててうまく表示が出来ないんすね。

　　　データを元に戻しましたのでもう一度selectしてみてください。
　　　上記selectでは結果が取れませんが、正しく直すと結果取れますので。
*/

SELECT
  E.ENAME,
  MNG.EMPNO,
  MNG.ENAME,
  D.LOC
FROM
  EMP E, EMP MNG, DEPT D, DEPT D2
WHERE E.MGR = MNG.EMPNO(+)
AND MNG.DEPTNO = D.DEPTNO(+)
AND E.DEPTNO = D2.DEPTNO
AND D.LOC NOT IN D2.LOC ;

ENAME                     EMPNO ENAME                LOC
-------------------- ---------- -------------------- --------------------
JONES                      7839 KING                 NEW YORK
BLAKE                      7839 KING                 NEW YORK





４．部門毎の所属人数と、それが全社員数に対して何％なのかを知りたい。
％は四捨五入で求める。
部門は全部門を知りたい。(所属人数が0人でも表示する)

/*SELECT句でサブクエリを利用する場合、メインクエリの結果として
サブクエリの結果を取得できます。*/

/*
結果はOKですが、
サブクエリはselect句に書かずにfrom句に書いてください（月曜日に解説します）
*/

SELECT D.DNAME, ROUND(COUNT(E.ENAME)) AS "所属人数",
ROUND(COUNT(E.ENAME) / c.allcnt * 100) AS "全体比(%)"
FROM
  (select count(*) AS allcnt from emp) c,
  DEPT D,
  EMP E
where D.deptno = E.deptno(+)
GROUP BY D.DNAME, D.deptno, c.allcnt ;

DNAME                  所属人数  全体比(%)
-------------------- ---------- ----------
ACCOUNTING                    3         21
RESEARCH                      5         36
SALES                         6         43
OPERATIONS                    0          0




５．職級(GRADE)毎の平均給与、最高額、最低額を知りたい。
その職級に該当する社員が居ない場合は、平均給与、最高額、最低額には-999を表示する。
--CASE WITH 列 条件 THEN 値(列) ELSE ~ END
--DECROD句-> DECODE(列, その値, 指定したい値)
/*
外部結合について
MAIN表 LEFT JOIN 結合させたい表 ON 条件
-> GROUP BY MAIN表の列指定
*/

SELECT
  G.GRADE AS "職級",
  CASE WHEN ROUND(AVG(E.SAL)) IS NULL THEN -999 ELSE ROUND(AVG(E.SAL)) END AS "平均給与",
  CASE WHEN MAX(E.SAL) IS NULL THEN -999 ELSE MAX(E.SAL) END AS "最高額" ,
  CASE WHEN MIN(E.SAL) IS NULL THEN -999 ELSE MIN(E.SAL) END AS "最低額"
FROM
  SALGRADE G,
  EMP E
WHERE E.SAL BETWEEN G.LOSAL AND G.HISAL(+)
GROUP BY G.GRADE
ORDER BY G.GRADE ;

職級   平均給与     最高額     最低額
---------- ---------- ---------- ----------
   1        950       1100        800
   2       1267       1300       1250
   3       1550       1600       1500
   4       2855       3000       2450
   5       5000       5000       5000



６．５の情報に、最高額受給者と最低額受給者の社員番号、社員名、勤務地を表示する。
最高額受給者、又は最低額受給者が複数人居る場合は、その中の誰か一人を表示する。
その職級に該当する社員が居ない場合は、社員名に'該当者なし'と表示する。
(誰を表示するかは、その人のセンスに任せる。
  例：任意、社員番号の小さい人、入社年月日の早い人　等)

CREATE TABLE EK (
  GRADE, SAL_AVE, MAX_SAL, MIN_SAL
)
AS SELECT
G.GRADE AS "職級",
CASE WHEN ROUND(AVG(E.SAL)) IS NULL THEN -999 ELSE ROUND(AVG(E.SAL)) END AS "平均給与",
CASE WHEN MAX(E.SAL) IS NULL THEN -999 ELSE MAX(E.SAL) END AS "最高額",
CASE WHEN MIN(E.SAL) IS NULL THEN -999 ELSE MIN(E.SAL) END AS "最低額"
FROM SALGRADE G LEFT JOIN EMP E ON E.SAL BETWEEN G.LOSAL AND G.HISAL
GROUP BY G.GRADE
ORDER BY G.GRADE ;

SELECT * FROM EK ;

     GRADE    SAL_AVE    MAX_SAL    MIN_SAL
---------- ---------- ---------- ----------
         1        963       1100        800
         2       -999       -999       -999
         3       1750       1875       1500
         4       2771       3000       2250
         5       -999       -999       -999


SELECT X.GRADE, X.SAL_AVE, X.MAX_SAL,
NVL((
  SELECT E.ENAME
  FROM SALGRADE S LEFT JOIN EMP E ON E.SAL BETWEEN S.LOSAL AND S.HISAL,
  EK X2
  WHERE (S.GRADE = X.GRADE AND X2.MAX_SAL = E.SAL AND ROWNUM = 1)
), '該当者なし') AS "従業員名(高)",
(
  SELECT E.EMPNO
  FROM SALGRADE S LEFT JOIN EMP E ON E.SAL BETWEEN S.LOSAL AND S.HISAL,
  EK X2
  WHERE S.GRADE = X.GRADE AND X2.MAX_SAL = E.SAL AND ROWNUM = 1
) AS "従業員番号",
(
  SELECT D2.LOC
  FROM (SALGRADE S LEFT JOIN EMP E ON E.SAL BETWEEN S.LOSAL AND S.HISAL)
  LEFT JOIN DEPT D2 ON E.DEPTNO = D2.DEPTNO,
  EK X2
  WHERE S.GRADE = X.GRADE AND X2.MAX_SAL = E.SAL AND ROWNUM = 1
) AS "勤務地",
X.MIN_SAL,
NVL((
  SELECT E.ENAME
  FROM SALGRADE S LEFT JOIN EMP E ON E.SAL BETWEEN S.LOSAL AND S.HISAL,
  EK X2
  WHERE S.GRADE = X.GRADE AND X2.MIN_SAL = E.SAL AND ROWNUM = 1
), '該当者なし') AS "従業員名(低)",
(
  SELECT E.EMPNO
  FROM SALGRADE S LEFT JOIN EMP E ON E.SAL BETWEEN S.LOSAL AND S.HISAL,
  EK X2
  WHERE S.GRADE = X.GRADE AND X2.MIN_SAL = E.SAL AND ROWNUM = 1
) AS "従業員番号",
(
  SELECT D1.LOC
  FROM (SALGRADE S LEFT JOIN EMP E ON E.SAL BETWEEN S.LOSAL AND S.HISAL)
  LEFT JOIN DEPT D1 ON E.DEPTNO = D1.DEPTNO,
  EK X2
  WHERE S.GRADE = X.GRADE AND X2.MIN_SAL = E.SAL AND ROWNUM = 1
) AS "勤務地"
FROM EK X ;


GRADE    SAL_AVE    MAX_SAL 従業員名(高)         従業員番号 勤務地                  MIN_SAL 従業員名(低)         従
---------- ---------- ---------- -------------------- ---------- -------------------- ---------- ---
    1        963       1100 ADAMS                      7876 DALLAS                      800 SMITH                      7369 DALLAS
    2       -999       -999 該当者なし                                                 -999 該当者なし
    3       1750       1875 MARTIN                     7654 CHICAGO                    1500 WILSON                     7955 CHICAGO
    4       2771       3000 FORD                       7902 CHICAGO                    2250 TURNER                     7844 CHICAGO
    5       -999       -999 該当者なし                                                 -999 該当者なし
    ６．５の情報に、最高額受給者と最低額受給者の社員番号、社員名、勤務地を表示する。
    最高額受給者、又は最低額受給者が複数人居る場合は、その中の誰か一人を表示する。
    その職級に該当する社員が居ない場合は、社員名に'該当者なし'と表示する。
    (誰を表示するかは、その人のセンスに任せる。
      例：任意、社員番号の小さい人、入社年月日の早い人　等)

-- ===============================================================

　⇒★まず新規テーブルEKは反則。
　　　データはそのときそのときで変わるものなので、別テーブルにデータを置いてしまったらempの値が変わっても
　　　上記SQLの結果が変わらないです。

　　　問５のSQLを副問い合わせ(サブクエリ)として使うところがスタートラインになります。


　　　以下考え方
　　　① サブクエリ問５の最高額、最低額にそれぞれempを外部結合する（＝最高額と最低額の社員情報を取得する）
　　　② 同一給与のため複数行取れてしまった場合を考慮してmin(empno)にする
　　　③ ②までの結合をさらにサブクエリにして、さらにempを結合して社員の情報を取得する

SELECT
 EK.GRADE,
 EK.SAL_AVE,
 EK.MAX_SAL,
 SAIKO.EMPNO,
 EK.MIN_SAL,
 SAITEI.EMPNO
FROM
  (
    SELECT
      MIN(MAX.EMPNO), MIN(MIN.EMPNO)
    FROM
      EMP MAX,
      EMP MIN,
      (
        SELECT
          G.GRADE AS "職級",
          CASE WHEN ROUND(AVG(E.SAL)) IS NULL THEN -999 ELSE ROUND(AVG(E.SAL)) END AS "平均給与",
          CASE WHEN MAX(E.SAL) IS NULL THEN -999 ELSE MAX(E.SAL) END AS "最高額" ,
          CASE WHEN MIN(E.SAL) IS NULL THEN -999 ELSE MIN(E.SAL) END AS "最低額"
        FROM
          SALGRADE G,
          EMP E
        WHERE E.SAL BETWEEN G.LOSAL AND G.HISAL(+)
        GROUP BY G.GRADE
        ORDER BY G.GRADE ;
      ) EK
    WHERE EK.MAX(E.SAL) = MAX.SAL(+)
    AND EK.MIN(E.SAL) = MIN.SAL(+)
  ),
  EMP SAITEI,
  EMP SAIKO
  WHERE SAIKO.EMPNO = MIN(MAX.EMPNO)
  AND SAITEI.EMPNO = MIN(MIN.EMPNO);


select
	(表示すべき情報)
from
	emp, emp
	(
	select
		min(最低額社員No),
		min(最高額社員No)
	from
		emp, emp,
		(問５のSQL)						-- ここが①
	where 最低額とempを外部結合
	and   最高額とempを外部結合
	)									-- ここが②
where 最低額社員Noとempを外部結合
and   最高額社員Noとempを外部結合		-- ここが③



-- ===============================================================
