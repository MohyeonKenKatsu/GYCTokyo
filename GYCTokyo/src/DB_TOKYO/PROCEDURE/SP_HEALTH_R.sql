/*-----------------------------------------------------------------
	VAR oCur REFCURSOR;
	EXEC SP_HEALTH_R('2025-01-16', 11, :oCur);
	PRINT oCur;
------------------------------------------------------------------*/
CREATE OR REPLACE PROCEDURE SP_HEALTH_R
(
	iHEALTH_DATE	IN	nvarchar2,		-- 날짜
	iUSER_ID		IN	NUMBER,			-- 사용자 아이디
	oCur			OUT	SYS_REFCURSOR	-- 결과 반환용 커서
)
IS
BEGIN
	OPEN oCur FOR
	SELECT	*
	FROM	TB_HEALTH a
	WHERE	HEALTH_DATE = iHEALTH_DATE	AND
			USER_ID		= iUSER_ID;
END SP_HEALTH_R;
