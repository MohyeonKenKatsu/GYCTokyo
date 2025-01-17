CREATE TABLE TB_PRIVATEDIARY
	(
        PD_DATE     DATE            NOT NULL,	-- 개인일기 날짜
        USER_ID     NUMBER(20, 0)   NOT NULL,	-- 사용자 아이디
        DQ_ID       NUMBER(3, 0)    NOT NULL,	-- 일기질문 아이디
        PD_CONTENT  NVARCHAR2(1000) NOT NULL,	-- 개인일기 내용
        EMOJI       VARCHAR2(8)     NOT NULL    -- 이모지
	);

/*
INSERT INTO TB_PRIVATEDIARY     (PD_DATE, USER_ID, DQ_ID, PD_CONTENT, EMOJI)
            VALUES              (TO_DATE('2025-01-04', 'YYYY-MM-DD'), 2, 0, '콘서트를 갔다. 하영이라는 아이와 눈이 마주쳤다. 그녀의 눈은 참으로 예뻤다. 나중에 꼭 번호 물어봐야지', '😘');
INSERT INTO TB_PRIVATEDIARY     (PD_DATE, USER_ID, DQ_ID, PD_CONTENT, EMOJI)
            VALUES              (TO_DATE('2025-01-05', 'YYYY-MM-DD'), 1, 9, '홋카이도에 가서 하얀 눈을 맞고 싶다.', '⛄');

SELECT * FROM TB_PRIVATEDIARY;
*/
