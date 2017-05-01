--4/20(木) コメント部分の修正と実行

-- 21.CHICAGOで働くすべての社員よりも多くSALを貰っている社員を、給料多い順に表示
/*★副問い合わせの問題なので回答としては満点ですが、
 一般的には副問い合わせの中でテーブル結合で取得します。
 （※次の章が結合なので知らなくて当然）
 */

--(修正)
SELECT ENAME, SAL FROM EMP
WHERE SAL > ALL (
  SELECT SAL FROM EMP, DEPT
  WHERE EMP.DEPTNO = DEPT.DEPTNO
  AND DEPT.LOC = 'CHICAGO'
)
ORDER BY SAL DESC ;

ENAME                       SAL
-------------------- ----------
KING                       5000
FORD                       3000
SCOTT                      3000
JONES                      2975


-- 24. GRADEが4以上の社員を表示
⇒★これはNGです（黒）
    EMPとSALGRADEの結合条件がないため、自然結合によりEMPの15行×SALGRADEの2行(GRADE>4)が30行表示になってます。
    SMITHさんがGRADE=4と5の2回表示されているのはそのため。
    ※テキストの2-38参照

--(修正版)
SELECT GRADE, ENAME FROM EMP E, SALGRADE G
WHERE E.SAL BETWEEN G.LOSAL AND G.HISAL
AND G.GRADE >= 4 ;

GRADE ENAME
---------- --------------------
    4 ALLEN
    4 JONES
    4 BLAKE
    4 CLARK
    4 SCOTT
    4 TURNER
    4 FORD
    5 KING



-- 25.所在地の頭文字Ｎで始まる部門と、そこに属する社員
⇒★これはNGのはずですが、結果を見るとOKに見えます。（黒）
    検証環境で実行すると以下になります。
    もう一回自分で流して確認してみてください。

--(修正版)
SELECT DNAME, ENAME FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO AND D.LOC LIKE 'N%' ;

DNAME                ENAME
-------------------- --------------------
ACCOUNTING           JAMES
ACCOUNTING           FORD
ACCOUNTING           MILLER




-- 26. (修正版)各部門のDNAME毎にSALの平均を表示
/*表の結合を行う際は、結合条件を指定。表に共通する情報が含めることが条件*/
SELECT D.DNAME, ROUND(AVG(E.SAL))
FROM EMP E, DEPT D
WHERE D.DEPTNO = E.DEPTNO --結合条件
GROUP BY D.DNAME ;

DNAME                ROUND(AVG(SAL))
-------------------- ---------------
ACCOUNTING                      2917
RESEARCH                        2175
SALES                           1567

 ⇒★OKです（黒）

=================================
<<補足>>

FROM句でテーブル名を修飾した場合、selectとgroup byで使用する項目全てにつけたほうがいいです。

SELECT D.DNAME, ROUND(AVG(E.SAL))
FROM EMP E, DEPT D
WHERE D.DEPTNO = E.DEPTNO
GROUP BY D.DNAME ;

理由は２つ
・どの項目を参照しているかSQLが見やすくなる
・EMPにDNAMEという項目を追加した場合、たちまちSQLが動かなくなる。

=================================


-- 27.(追記)社員が一人も存在しない部門名(DNAME)の表示
/*
⇒★OKです（黒）
    でも名称だけならこれだけでもいいかなと思います。

SELECT DEPTNO FROM DEPT
MINUS
SELECT DEPTNO FROM EMP;


<<補足>>
not inという条件で以下のように記述することも可能です。
※今回はminusの演習なので回答としては満点です。

select * from dept where deptno not in (select deptno from emp);

流してみてください。
*/
SELECT DNAME FROM DEPT
WHERE DEPTNO = (
  SELECT DEPTNO FROM DEPT
  MINUS
  SELECT DEPTNO FROM EMP
);


--NOT IN 使用(追記)
SELECT D.DNAME FROM DEPT D
WHERE D.DEPTNO NOT IN (
  SELECT E.DEPTNO FROM EMP E
);

DNAME
--------------------
OPERATIONS
