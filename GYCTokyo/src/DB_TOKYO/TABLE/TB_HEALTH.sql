CREATE TABLE TB_HEALTH
	(
        HEALTH_DATE         DATE                 NOT NULL,  -- 건강기록 날짜
		USER_ID		        NUMBER(20, 0)	     NOT NULL,	-- 사용자 아이디
		GOAL_WATER          CHAR(1)              NULL,  	-- 목표 음수량
        ACHIEVED_WATER      CHAR(1)              NULL,   -- 달성 음수량
        TYPE_EXERCISE       NVARCHAR2(10)        NULL,   -- 운동 종류
        GOAL_EXERCISE       CHAR(1)              NULL,   -- 목표 운동기록
        ACHIEVED_EXERCISE   CHAR(1)              NULL,   -- 달성 운동기록 
        BEDTIME             NVARCHAR2(10)        NULL,   -- 취침시간
        WAKETIME            NVARCHAR2(10)        NULL    -- 기상시간
	)
    ;
    
/*
INSERT INTO TB_HEALTH (health_date, user_id, goal_water, achieved_water, type_exercise, goal_exercise, achieved_exercise, bedtime, waketime)
                VALUES   ('2025-01-05', 1, 1, 1, 1, 1, 1, 1, 1); 

SELECT * FROM TB_HEALTH;

DROP TABLE TB_HEALTH;
*/