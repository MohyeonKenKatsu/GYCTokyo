create or replace PROCEDURE SP_INVITEGROUP_CU
(
	iGroupId	IN	int,			-- 그룹번호
	iEmail		IN	nvarchar2		-- 이메일
)
IS
BEGIN
	DECLARE
		mCount	int;
		mUserId int;

	BEGIN
		DBMS_OUTPUT.ENABLE;

		SELECT	COUNT(*) INTO mCount
		FROM	TB_USERS a
		WHERE	a.EMAIL = iEmail;

		IF mCount > 0 THEN
			SELECT	a.USER_ID INTO mUserId
			FROM	TB_USERS a
			WHERE	a.EMAIL = iEmail;

			SELECT	COUNT(*) INTO mCount
			FROM	TB_GROUPUSERLIST a
			WHERE	a.GROUP_ID = iGroupId	AND
					a.USER_ID  = mUserId;

			IF mCount = 0 THEN
				INSERT	INTO TB_GROUPUSERLIST VALUES (iGroupId, mUserId);
			END IF;
		END IF;
	END;
END SP_INVITEGROUP_CU;