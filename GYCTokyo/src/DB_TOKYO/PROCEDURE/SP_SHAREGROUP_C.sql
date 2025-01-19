create or replace PROCEDURE SP_SHAREGROUP_C
(
	iGroupName	IN	nvarchar2,	    -- 그룹이름
	iUserId		IN  int				-- 유저번호
)
IS
BEGIN
	DECLARE
		nGroupId		int := SQ_GROUP_ID.NEXTVAL;
		
	BEGIN
		INSERT INTO TB_GROUPLIST
		VALUES (nGroupId, iGroupName);

		INSERT INTO TB_GROUPUSERLIST
		VALUES (nGroupId, iUserId);

		RETURN;
	END;	
END SP_SHAREGROUP_C;