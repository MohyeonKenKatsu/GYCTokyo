/*-----------------------------------------------------------------
	VAR oCur REFCURSOR;
	EXEC SP_USERS_HEADERDATA(1);
	PRINT oCur;
------------------------------------------------------------------*/
CREATE OR REPLACE PROCEDURE SP_USERS_HEADERDATA
(
    iUSER_ID	IN	INT,	    -- 사용자 아이디
	oCur		OUT	SYS_REFCURSOR	-- 결과 반환용 커서
)
IS
BEGIN
	BEGIN
		OPEN oCur FOR
		SELECT	NICKNAME, COURSE
		FROM	TB_USERS
		WHERE	(USER_ID = iUSER_ID);
	END;
END SP_USERS_HEADERDATA;