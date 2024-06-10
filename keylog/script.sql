select * from tblBoard;

INSERT INTO tblBoard (id, userid, title, content, regdate, viewcnt, reportcnt, likecnt, scrapcnt)
VALUES (seqBoard.nextVal, 'user01', '오늘날씨입니다.', '너무 덥네요', sysdate, 1, 2, 3, 4);

select * from tblUser;
INSERT INTO tblUser (id, password, name, nickName, tel, address, state, user_level, score, userImg, reportCnt, likeCnt, scrapCnt, followCnt, followingCnt)
VALUES ('user01', 'password01', '홍길동', '길동이', '010-1234-5678', '서울시 강남구 역삼동', '활동', 1, 0, 'defaultImg', 0, 0, 0, 0, 0);
commit;