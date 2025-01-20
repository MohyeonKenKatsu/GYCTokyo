/* SP_USERS_CUD : USERS 테이블에 사용자 등록(회원가입) / 사용자 정보 변경(마이페이지)
단, 생일 정보는 'YYYY-MM-DD' 형식의 String 값으로 받아서 DATE 타입으로 변환해야함
*/
CREATE OR REPLACE PROCEDURE SP_USERS_CUD
(
    iJOBSTATUS	IN	VARCHAR2,		-- 작업상태
    iUSER_ID	IN	INT,	        -- 사용자 아이디
    iEMAIL		IN	VARCHAR2,	    -- 이메일
    iPASSWORD   IN	VARCHAR2,		-- 비밀번호
    iNICKNAME	IN  NVARCHAR2,		-- 닉네임
    iBDATE		IN  VARCHAR2,		-- 생일
    iTEL		IN	VARCHAR2,		-- 전화번호 뒤 4자리
    iCOURSE		IN	INT		        -- 교육과정
)
IS
BEGIN
    --------------------------------------------------------
	IF		iJOBSTATUS = 'INSERT' THEN GOTO INSERT_;
	ELSIF	iJOBSTATUS = 'UPDATE' THEN GOTO UPDATE_;
	END IF;

	RETURN;
	--------------------------------------------------------
    <<INSERT_>>
	INSERT INTO TB_USERS
                (USER_ID,            EMAIL,  PASSWORD,   NICKNAME,   BDATE,                          TEL,    COURSE)
        VALUES  (SQ_USER_ID.NEXTVAL, iEMAIL, iPASSWORD,  iNICKNAME,  TO_DATE(iBDATE, 'YYYY-MM-DD'),  iTEL,   iCOURSE);
    
	RETURN;
    --------------------------------------------------------
    <<UPDATE_>>
	UPDATE TB_USERS
	SET	    PASSWORD	= iPASSWORD,
            NICKNAME	= iNICKNAME,
            TEL         = iTEL,
            COURSE      = iCOURSE
	WHERE USER_ID = iUSER_ID;

	RETURN;
    --------------------------------------------------------
END SP_USERS_CUD;