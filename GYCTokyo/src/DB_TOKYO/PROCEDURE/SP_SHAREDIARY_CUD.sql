create or replace PROCEDURE SP_SHAREDIARY_CUD
(
	iJopStatus	IN	varchar2,		-- 작업상태
	iDate		IN	nvarchar2,		-- 날짜
	iGroupId	IN	int,		    -- 그룹번호
	iUserId		IN	int, 			-- 유저번호
	iContentId	IN	int, 			-- 내용번호
	iSDContent	IN	nvarchar2 		-- 내용
)
IS
BEGIN
	DECLARE
		nContentId		int;

	BEGIN
		--------------------------------------------------------
		IF		iJopStatus = 'INSERT' THEN GOTO INSERT_;
		ELSIF	iJopStatus = 'UPDATE' THEN GOTO UPDATE_;
		ELSIF	iJopStatus = 'DELETE' THEN GOTO DELETE_;
		END IF;

		RETURN;
		--------------------------------------------------------
<<INSERT_>>
		SELECT	COUNT(*)+1 INTO nContentId
		FROM	TB_SHAREDIARY a
		WHERE	a.SD_DATE	= iDate		AND
				a.GROUP_ID	= iGroupId	AND
				a.USER_ID	= iUserId;

		INSERT INTO TB_SHAREDIARY
		VALUES (iDate, iGroupId, iUserId, nContentId, iSDContent);

		RETURN;
		--------------------------------------------------------
<<UPDATE_>>
		UPDATE	TB_SHAREDIARY
		SET		SD_CONTENT	= iSDContent
		WHERE	SD_DATE		= iDate		AND
				GROUP_ID	= iGroupId	AND
				USER_ID		= iUserId	AND
				CONTENT_ID	= iContentId;

		RETURN;
		--------------------------------------------------------
<<DELETE_>>
		DELETE	TB_SHAREDIARY
		WHERE	SD_DATE		= iDate		AND
				GROUP_ID	= iGroupId	AND
				USER_ID		= iUserId	AND
				CONTENT_ID	= iContentId;

		RETURN;
		--------------------------------------------------------
	END;
END SP_SHAREDIARY_CUD;