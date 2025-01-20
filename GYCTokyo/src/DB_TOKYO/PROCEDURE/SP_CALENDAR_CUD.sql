create or replace PROCEDURE SP_CALENDAR_CUD
(
    iJobStatus	        IN	VARCHAR2,		    -- 작업상태
	iCALENDAR_ID		IN	NUMBER,			    -- 캘린더 아이디
	iUSER_ID		    IN	NUMBER,		        -- 사용자 아이디
    iPLAN		        IN	NVARCHAR2,		    -- 일정명
	iCALENDAR_DATE		IN	VARCHAR2,			    -- 날짜
	iCATEGORY		    IN	CHAR,			    -- 카테고리
    iMEMO		        IN	NVARCHAR2			-- 메모
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
	INSERT INTO TB_CALENDAR
	VALUES (iCALENDAR_ID, iUSER_ID, iPLAN, TO_DATE(iCALENDAR_DATE, 'YYYY-MM-DD'), iCATEGORY, iMEMO);
	RETURN;
    --------------------------------------------------------
    <<UPDATE_>>
		UPDATE TB_CALENDAR
		SET	PLAN		    = iPLAN,
			CALENDAR_DATE	= TO_DATE(iCALENDAR_DATE, 'YYYY-MM-DD'),
			CATEGORY	    = iCATEGORY,
            MEMO	        = iMEMO
        WHERE   (CALENDAR_ID= iCALENDAR_ID AND
                 USER_ID    = iUSER_ID);

		RETURN;
    --------------------------------------------------------
    <<DELETE_>>
	DELETE TB_CALENDAR
    WHERE   (CALENDAR_ID= iCALENDAR_ID AND
                 USER_ID    = iUSER_ID);
	RETURN;
END SP_CALENDAR_CUD;