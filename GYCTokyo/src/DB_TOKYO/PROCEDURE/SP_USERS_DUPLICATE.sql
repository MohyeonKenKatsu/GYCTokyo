CREATE OR REPLACE PROCEDURE SP_USERS_DUPLICATE
(
    iOBJ    	IN	VARCHAR2,		-- 작업상태
    iINPUT  	IN  NVARCHAR2,		-- 입력값
	oCur		OUT	SYS_REFCURSOR	-- 결과 반환용 커서
)
IS
BEGIN
    --------------------------------------------------------
	IF		iOBJ = 'EMAIL' THEN GOTO EMAIL_;
	ELSIF	iOBJ = 'NICKNAME' THEN GOTO NICKNAME_;
	END IF;
    
	RETURN;
	--------------------------------------------------------
    <<EMAIL_>>
	BEGIN
		OPEN oCur FOR
		SELECT	EMAIL
		FROM	TB_USERS
		WHERE	(EMAIL = iINPUT);
	END;
    
    RETURN;
    --------------------------------------------------------
    <<NICKNAME_>>
	BEGIN
		OPEN oCur FOR
		SELECT	NICKNAME
		FROM	TB_USERS
		WHERE	(NICKNAME = iINPUT);
	END;
    
	RETURN;
    --------------------------------------------------------
END SP_USERS_DUPLICATE;