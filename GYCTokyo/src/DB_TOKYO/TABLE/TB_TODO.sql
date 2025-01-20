CREATE TABLE TB_TODO
	(
        TODO_ID     NUMBER(20, 0)   NOT NULL,   -- 캘린더 아이디
		USER_ID		NUMBER(20, 0)	NOT NULL,	-- 사용자 아이디
		TODO_DATE   DATE	        NOT NULL,	-- 날짜 
        TODO		NVARCHAR2(30)   NOT NULL	-- 할일
	)
    ;
    
/*
INSERT INTO TB_TODO (TODO_ID, USER_ID, TODO_DATE, TODO)
                VALUES   (1, 1, '2025-01-05', '유림누나랑 피자먹기'); 

SELECT * FROM TB_TODO;
*/