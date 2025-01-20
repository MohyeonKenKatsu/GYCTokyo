CREATE TABLE TB_SUPPLEMENT
	(
        HEALTH_DATE         DATE            NOT NULL,   -- 건강기록 날짜
		USER_ID		        NUMBER(20, 0)	NOT NULL,	-- 사용자 아이디
		SUP_ID              NUMBER(20, 0)   NOT NULL,	-- 영양제 아이디 
        TYPE_SUP            CHAR(1)         NOT NULL,   -- 영양제 종류
        TIME_SUP            CHAR(1)         NOT NULL,   -- 먹는 시간
        ACHIEVED_SUP        NUMBER(1)       NOT NULL    -- 달성 여부
	)
    ;

/*    
INSERT INTO TB_SUPPLEMENT (health_date, USER_ID, sup_id, type_sup, time_sup, achieved_sup)
                VALUES   ('2025-01-05', 1, 1, 1, 1, 1); 

SELECT * FROM TB_SUPPLEMENT;
*/