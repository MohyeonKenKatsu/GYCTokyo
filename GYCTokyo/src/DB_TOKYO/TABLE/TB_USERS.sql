CREATE TABLE TB_USERS
	(
		USER_ID		NUMBER(20, 0)	NOT NULL,	    -- 사용자 아이디
		EMAIL		VARCHAR2(30)	NOT NULL,		-- 이메일
		PASSWORD    VARCHAR2(12)	NOT NULL,		-- 비밀번호
		NICKNAME	NVARCHAR2(8)	NOT NULL,		-- 닉네임
        BDATE		DATE		    NOT NULL,		-- 생일
        TEL			VARCHAR2(4)	    NOT NULL,		-- 전화번호 뒤 4자리
		COURSE		NUMBER(3, 0)	NOT NULL		-- 교육과정
	);

CREATE UNIQUE INDEX IX1_USERS ON TB_USERS (USER_ID);

/*
INSERT INTO TB_USERS    (USER_ID, EMAIL, PASSWORD, NICKNAME, BDate, Tel, COURSE)
            VALUES      (1, 'tw999634@gmail.com', 'gyctokyo', '태우', TO_DATE('1999-04-26', 'YYYY-MM-DD'), '9643', 1);
INSERT INTO TB_USERS    (USER_ID, EMAIL, PASSWORD, NICKNAME, BDate, Tel, COURSE)
            VALUES      (2, 'wonpil@jyp.co.kr', 'gyctokyo', '라떼아트천재', TO_DATE('2000-01-04', 'YYYY-MM-DD'), '5218', 1);
INSERT INTO TB_USERS    (USER_ID, EMAIL, PASSWORD, NICKNAME, BDate, Tel, COURSE)
            VALUES      (3, 'rimirimi@hufs.ac.kr', 'yurimtenshi', '리무리무유리무', TO_DATE('1990-02-06', 'YYYY-MM-DD'), '0206', 1);
INSERT INTO TB_USERS    (USER_ID, EMAIL, PASSWORD, NICKNAME, BDate, Tel, COURSE)
            VALUES      (4, 'taetiseo@sm.co.kr', 'gyctokyo', '숨겨둔트윙클어쩌', TO_DATE('2025-01-04', 'YYYY-MM-DD'), '1234', 3);

SELECT * FROM TB_USERS;
*/
