--plSQLの実行

-- ログ出力開始
spool c:\テキスト.txt

-- ログ出力終了
spool off


-- コンソールを表示する
set serveroutput on
-- 文字列をコンソールに表示する
dbms_output.put_line(文字列);
