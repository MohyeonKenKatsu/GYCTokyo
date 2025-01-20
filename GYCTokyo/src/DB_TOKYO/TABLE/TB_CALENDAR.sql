CREATE TABLE TB_CALENDAR
	(
        CALENDAR_ID     NUMBER(20, 0)   NOT NULL,   -- 캘린더 아이디
		USER_ID		    NUMBER(20, 0)	NOT NULL,	-- 사용자 아이디
		PLAN		    NVARCHAR2(15)	NOT NULL,	-- 일정명
		CALENDAR_DATE   DATE	        NOT NULL,	-- 날짜
		CATEGORY	    CHAR(1)	        NOT NULL,	-- 카테고리
        MEMO		    NVARCHAR2(1000) NOT NULL	-- 메모
	)
    ;
    
/*
INSERT INTO TB_CALENDAR (CALENDAR_ID, USER_ID, PLAN, CALENDAR_DATE, CATEGORY, MEMO)
                VALUES   (1, 1, '유림누나랑 피자약속', '2025-01-05', 1, '아기다리고기다리던 유림누나와의 피자약속! 두근두근 설레서 밤잠을 설쳤다. 오늘 피자 몇판먹을거예요~? 백판~! 야호 신난다~'); 

SELECT * FROM TB_CALENDAR;                
*/