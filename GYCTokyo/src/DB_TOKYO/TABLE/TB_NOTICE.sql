CREATE TABLE TB_NOTICE
	(
		USER_ID		    NUMBER(20, 0)	NOT NULL,   -- 사용자 아이디
		NOTICE_CONTENT  NVARCHAR2(100)  NOT NULL,   -- 알림 내용
        NOTICE_READ     NUMBER(1, 0)    NOT NULL    -- 확인 여부
	);

/*
INSERT INTO TB_NOTICE   (USER_ID, NOTICE_CONTENT, NOTICE_READ)
            VALUES      (1, '"라떼아트천재" 님이 "태우" 님을 "사랑비 내리는 켄카츠" 그룹에 초대했습니다.', 1);
INSERT INTO TB_NOTICE   (USER_ID, NOTICE_CONTENT, NOTICE_READ)
            VALUES      (1, '예시 알림', 0);

SELECT * FROM TB_NOTICE;
*/
