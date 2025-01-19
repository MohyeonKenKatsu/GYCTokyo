create or replace PROCEDURE SP_SHAREDIARY_R
(
	iDate		IN	nvarchar2,		-- 날짜
	iGroupId	IN	int,		    -- 그룹번호
	iUserId		IN	int, 			-- 유저번호
	iContentId	IN	int, 			-- 내용번호
	oCur		OUT	SYS_REFCURSOR	-- 결과 반환용 커서
)
IS
BEGIN
	OPEN oCur FOR
	SELECT	a.*,
			(
				SELECT	b.NICKNAME
				FROM	TB_USERS b
				WHERE	a.USER_ID	= b.USER_ID
			) AS NICKNAME
	FROM	TB_SHAREDIARY a
	WHERE	a.SD_DATE	= iDate		AND
			a.GROUP_ID	= iGroupId	AND
			(iUserId	= -1		OR
				(a.USER_ID	= iUserId	AND
				 a.CONTENT_ID	= iContentId)
			)
	ORDER BY a.SD_DATE, a.GROUP_ID, a.USER_ID, a.CONTENT_ID;

END SP_SHAREDIARY_R;