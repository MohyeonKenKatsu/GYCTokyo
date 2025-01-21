create or replace PROCEDURE SP_PRIVATEDIARY_CUD
(
    iJobStatus	        IN	VARCHAR2,		    -- 작업상태
	iUSER_ID		    IN	NUMBER,		        -- 사용자 아이디
	iPD_DATE		    IN	VARCHAR2,			-- 개인일기 날짜
    iPD_CONTENT		    IN	NVARCHAR2,		    -- 개인일기 내용
    iEMOJI		        IN	VARCHAR2	        -- 이모지
)
IS
BEGIN
    --------------------------------------------------------
    IF              iJobStatus = 'INSERT' THEN GOTO INSERT_;
    ELSIF           iJobStatus = 'UPDATE' THEN GOTO UPDATE_;
    ELSIF           iJobStatus = 'DELETE' THEN GOTO DELETE_;
    END IF;
    --------------------------------------------------------
    <<INSERT_>>
	INSERT INTO TB_PRIVATEDIARY
	VALUES (iUSER_ID, TO_DATE(iPD_DATE, 'YYYY-MM-DD'), iPD_CONTENT, iEMOJI);
	RETURN;
    --------------------------------------------------------
    <<UPDATE_>>
		UPDATE TB_PRIVATEDIARY
		SET	USER_ID		    = iUSER_ID,
			PD_DATE		    = TO_DATE(iPD_DATE, 'YYYY-MM-DD'),
			PD_CONTENT		= iPD_CONTENT,
			EMOJI	        = iEMOJI
            
        WHERE   (USER_ID    = iUSER_ID);

		RETURN;
    --------------------------------------------------------
    <<DELETE_>>
	DELETE TB_PRIVATEDIARY
    WHERE   (USER_ID     = iUSER_ID) AND
            (PD_DATE     = TO_DATE(iPD_DATE, 'YYYY-MM-DD'));
	RETURN;
END SP_PRIVATEDIARY_CUD;