/*-----------------------------------------------------------------
	EXEC SP_SHAREDAIRY_CUD('INSERT', '2025-01-14', 1, 1, '안녕하세요.1');
	EXEC SP_SHAREDAIRY_CUD('INSERT', '2025-01-14', 1, 1, '안녕하세요.2');
	EXEC SP_SHAREDAIRY_CUD('INSERT', '2025-01-14', 1, 1, '안녕하세요.3');
	EXEC SP_SHAREDAIRY_CUD('INSERT', '2025-01-14', 1, 1, '안녕하세요.4');
	SELECT * FROM TB_SHAREDIARY;
------------------------------------------------------------------*/
CREATE OR REPLACE PROCEDURE SP_SHAREDAIRY_CUD
(
	iJopStatus	IN	varchar2,		-- 작업상태
	iDate		IN	nvarchar2,		-- 날짜
	iGroupId	IN	int,		    -- 그룹번호
	iUserId		IN	int, 			-- 유저번호
	iSDContent	IN	nvarchar2 		-- 내용
)
IS
BEGIN
	--------------------------------------------------------
	IF		iJopStatus = 'INSERT' THEN GOTO INSERT_;
	ELSIF	iJopStatus = 'UPDATE' THEN GOTO UPDATE_;
	ELSIF	iJopStatus = 'DELETE' THEN GOTO DELETE_;
	END IF;

	RETURN;
	--------------------------------------------------------
<<INSERT_>>
	INSERT INTO TB_SHAREDIARY
	VALUES (iDate, iGroupId, iUserId, iSDContent);

	RETURN;
	--------------------------------------------------------
<<UPDATE_>>
--	UPDATE TB_MAN
--	SET	Name	= iName,
--		Age		= iAge,
--		Gender	= iGender,
--		Tel		= iTel,
--		Dept	= iDept,
--		StCd	= iStCd,
--		BDate	= iBDate,
--		Address	= iAddress
--	WHERE Sabun	= iSabun;

	RETURN;
	--------------------------------------------------------
<<DELETE_>>
--	DELETE TB_MAN
--	WHERE Sabun	= iSabun;

	RETURN;
END SP_SHAREDAIRY_CUD;
