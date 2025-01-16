CREATE TABLE TB_SHAREDIARY
	(
        SD_DATE     DATE            NOT NULL,	-- 공유일기 날짜
        GROUP_ID    NUMBER(20, 0)   NOT NULL,	-- 그룹 아이디
        USER_ID     NUMBER(20, 0)   NOT NULL,	-- 사용자 아이디
        SD_CONTENT  NVARCHAR2(1000) NOT NULL	-- 공유일기 내용
	);

/*
INSERT INTO TB_SHAREDIARY   (SD_DATE, GROUP_ID, USER_ID, SD_CONTENT)
            VALUES          (TO_DATE('2025-01-04', 'YYYY-MM-DD'), 1, 3,
                             '컴퓨터와 싸웠다. 내가 졌다. 그래서 모두와 피자를 먹었다. 겡끼니 나리마시따.할리갈리를 한 덕분에 손에서 불이 났지만 다시 컴퓨터와 싸우러 갔다. 내가 이기고 말겠어');

SELECT * FROM TB_SHAREDIARY;
SELECT * FROM TB_SHAREDIARY WHERE SD_DATE=TO_DATE('2025-01-04', 'YYYY-MM-DD') AND GROUP_ID=1;
*/
