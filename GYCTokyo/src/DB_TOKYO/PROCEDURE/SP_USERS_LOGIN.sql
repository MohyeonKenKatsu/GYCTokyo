/*-----------------------------------------------------------------
	VAR oCur REFCURSOR;
	EXEC SP_USERS_LOGIN('tw999634@gmail.com', 'gyctokyo');
	PRINT oCur;
------------------------------------------------------------------*/
CREATE OR REPLACE PROCEDURE SP_USERS_LOGIN
(
    iEMAIL		IN	VARCHAR2,	    -- 이메일
    iPASSWORD   IN  VARCHAR2,       -- 비밀번호
	oCur		OUT	SYS_REFCURSOR	-- 결과 반환용 커서
)
IS
BEGIN
	BEGIN
		OPEN oCur FOR
		SELECT	USER_ID, NICKNAME
		FROM	TB_USERS
		WHERE	(EMAIL      = iEMAIL    AND
                 PASSWORD   = iPASSWORD
                 );
	END;
END SP_USERS_LOGIN;