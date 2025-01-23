create or replace PROCEDURE SP_GATHERING_CUD
(
    iJobStatus	        IN	VARCHAR2,		    -- 작업상태
	iGROUP_ID		    IN	NUMBER,			    -- 소모임 아이디
	iUSER_ID		    IN	NUMBER,		        -- 사용자 아이디
    iTITLE		        IN	NVARCHAR2,		    -- 제목
	iSTART_DATE		    IN	DATE,			    -- 모집시작날짜
	iFINISH_DATE		IN	DATE,			    -- 모집종료날짜
    iACTIVITY_DAY		IN	DATE,			    -- 활동일
    iNUMBER_LIMIT		IN	NUMBER,			    -- 모집인원수
    iCONTENT		    IN	NVARCHAR2	        -- 상세내용
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
	INSERT INTO TB_GATHERING
	VALUES (iGROUP_ID, iUSER_ID, iTITLE, iSTART_DATE, iFINISH_DATE,
            iACTIVITY_DAY, iNUMBER_LIMIT, iCONTENT);
	RETURN;
    --------------------------------------------------------
    <<UPDATE_>>
		UPDATE TB_GATHERING
		SET	TITLE		    = iTITLE,
			START_DATE		= iSTART_DATE,
			FINISH_DATE		= iFINISH_DATE,
			ACTIVITY_DAY	= iACTIVITY_DAY,
            NUMBER_LIMIT	= iNUMBER_LIMIT,
			CONTENT		    = iCONTENT
        WHERE   (GROUP_ID	= iGROUP_ID AND
                 USER_ID    = iUSER_ID);

		RETURN;
    --------------------------------------------------------
    <<DELETE_>>
	DELETE TB_GATHERING
    WHERE  (GROUP_ID	= iGROUP_ID);
	RETURN;
END SP_GATHERING_CUD;