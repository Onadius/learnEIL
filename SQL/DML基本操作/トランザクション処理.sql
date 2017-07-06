--変更した内容の確定
--トランザクション = 作業単位

COMMIT ;

--暗黙のコミットを行っているコマンド
ALTER, CREATE, DROP, GRANT, RENAME, REVOKE


--変更の取り消し
ROLLBACK ;

--オブジェクト権限の付与
GRANT SELECT ON EMP TO SMITH ;

--権限の取り消し
REVOKE SELECT ON EMP TO SMITH ;
















COMMIT ;
