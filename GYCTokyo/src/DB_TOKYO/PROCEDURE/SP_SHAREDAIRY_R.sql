/*-----------------------------------------------------------------
	VAR oCur REFCURSOR;
	--EXEC SP_SHAREDAIRY_R('2025-01-14', 1, 1, :oCur);
	EXEC SP_SHAREDAIRY_R('2025-01-14', 1, -1, :oCur);
	PRINT oCur;
------------------------------------------------------------------*/
CREATE OR REPLACE PROCEDURE SP_SHAREDAIRY_R
(
	iDate		IN	nvarchar2,		-- 날짜
	iGroupId	IN	int,		    -- 그룹번호
	iUserId		IN	int, 			-- 유저번호
	oCur		OUT	SYS_REFCURSOR	-- 결과 반환용 커서
)
IS
BEGIN
	OPEN oCur FOR
	SELECT	a.*
	FROM	TB_SHAREDIARY a
	WHERE	a.SD_DATE	= iDate		AND
			a.GROUP_ID	= iGroupId	AND
			(iUserId	= -1		OR a.USER_ID	= iUserId);
END SP_SHAREDAIRY_R;
