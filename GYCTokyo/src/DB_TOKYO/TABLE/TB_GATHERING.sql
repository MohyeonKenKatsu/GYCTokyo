CREATE TABLE TB_GATHERING
	(
        GROUP_ID            NUMBER(20, 0)   NOT NULL,   -- 소모임 아이디 
		USER_ID		        NUMBER(20, 0)	NOT NULL,	-- 사용자 아이디
		TITLE               NVARCHAR2(20)   NOT NULL,	-- 제목 
        START_DATE          DATE            NOT NULL,   -- 모집시작날짜 
        FINISH_DATE         DATE            NOT NULL,   -- 모집종료날짜 
        ACTIVITY_DAY        DATE            NOT NULL,   -- 활동일
        NUMBER_LIMIT        NUMBER(2, 0)   NOT NULL,    -- 모집인원수
        CONTENT             NVARCHAR2(1000) NOT NULL    -- 상세내용 
	)
    ;
    
/*
INSERT INTO TB_GATHERING ( group_id, user_id, title, start_date, finish_date, activity_day, number_limit, content)
                VALUES   (1, 1, '초코호떡 먹으러 갈 사람~', '2025-01-05', '2025-12-25', '2025-12-31', 5, '할리갈리로 의욕한판 채우고, 피자로 열정 한판 채우고 후식으로 달달한 호떡 먹으러갈 사람 괌'); 

SELECT * FROM TB_GATHERING; 
*/