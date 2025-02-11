create or replace PROCEDURE SP_SHAREGROUPMEMBER_R
(
	iGroupId	IN	int,		    -- 그룹번호
	oCur		OUT	SYS_REFCURSOR	-- 결과 반환용 커서
)
IS
BEGIN
	OPEN oCur FOR
	SELECT	a.*,
			(
				SELECT	b.GROUPNAME
				FROM	TB_GROUPLIST b
				WHERE	a.GROUP_ID	= b.GROUP_ID
			) AS GROUPNAME,
			(
				SELECT	c.NICKNAME
				FROM	TB_USERS c
				WHERE	a.USER_ID	= c.USER_ID
			) AS NICKNAME,
			(
				SELECT	c.EMAIL
				FROM	TB_USERS c
				WHERE	a.USER_ID	= c.USER_ID
			) AS EMAIL		
	FROM	TB_GROUPUSERLIST a
	WHERE	a.GROUP_ID	= iGroupId
	ORDER BY a.USER_ID;

END SP_SHAREGROUPMEMBER_R;