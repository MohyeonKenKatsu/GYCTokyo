/* SP_USERS_CUD : USERS 테이블에 사용자 등록(회원가입) / 사용자 정보 변경(마이페이지)
단, 생일 정보는 'YYYY-MM-DD' 형식의 String 값으로 받아서 DATE 타입으로 변환해야함
*/
CREATE OR REPLACE PROCEDURE SP_USERS_SEARCH
(
    iOBJ    	IN	VARCHAR2,		-- 검색 대상
    iEMAIL		IN	VARCHAR2,	    -- 이메일
    iBDATE		IN  VARCHAR2,		-- 생일
    iTEL		IN	VARCHAR2,		-- 전화번호 뒤 4자리
	oCur		OUT	SYS_REFCURSOR	-- 결과 반환용 커서
)
IS
BEGIN
    --------------------------------------------------------
	IF		iOBJ = 'EMAIL'    THEN GOTO EMAIL_;
	ELSIF	iOBJ = 'PASSWORD' THEN GOTO PASSWORD_;
	END IF;
    
	RETURN;
	--------------------------------------------------------
    <<EMAIL_>>
	BEGIN
		OPEN oCur FOR
		SELECT	EMAIL
		FROM	TB_USERS
		WHERE	(BDATE = TO_DATE(iBDATE, 'YYYY-MM-DD')) AND
                (TEL = iTEL);
	END;
    
    RETURN;
    --------------------------------------------------------
    <<PASSWORD_>>
	BEGIN
		OPEN oCur FOR
		SELECT	USER_ID
		FROM	TB_USERS
		WHERE	(EMAIL = iEMAIL) AND
                (BDATE = TO_DATE(iBDATE, 'YYYY-MM-DD')) AND
                (TEL = iTEL);
	END;
    
	RETURN;
    --------------------------------------------------------
END SP_USERS_SEARCH;