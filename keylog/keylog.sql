-- 시퀀스 생성
CREATE SEQUENCE seqUser;
CREATE SEQUENCE seqAdmin;
CREATE SEQUENCE seqFollow;
CREATE SEQUENCE seqBoard;
CREATE SEQUENCE seqTag;
CREATE SEQUENCE seqHashTag;
CREATE SEQUENCE seqImg;
CREATE SEQUENCE seqComment;
CREATE SEQUENCE seqGroup;
CREATE SEQUENCE seqChatRoom;
CREATE SEQUENCE seqMessage;
CREATE SEQUENCE seqGroupBoard;
CREATE SEQUENCE seqScrap;
CREATE SEQUENCE seqLike;
CREATE SEQUENCE seqBoardReport;
CREATE SEQUENCE seqReportCat;
CREATE SEQUENCE seqCommentReport;




-- 테이블 생성
/* 회원 */
CREATE TABLE tblUser (
	id VARCHAR2(20) NOT NULL, /* 회원아이디 */
	password VARCHAR2(50) NOT NULL, /* 비밀번호 */
	name VARCHAR2(20) NOT NULL, /* 이름 */
	nickName VARCHAR2(50) NOT NULL, /* 닉네임 */
	tel VARCHAR2(20) NOT NULL, /* 연락처 */
	address VARCHAR2(255) NOT NULL, /* 주소 */
	state VARCHAR2(10) DEFAULT '활동' CHECK (state IN ('활동', '탈퇴', '휴면', '정지')) NOT NULL, /* 상태 */
	user_level NUMBER DEFAULT 1 NOT NULL, /* 등급 */
	score NUMBER DEFAULT 0 NOT NULL, /* 활동점수 */
	userImg VARCHAR2(200) DEFAULT 'defaultImg' NOT NULL, /* 회원이미지 */
	reportCnt NUMBER DEFAULT 0 NOT NULL, /* 신고횟수 */
	likeCnt NUMBER DEFAULT 0 NOT NULL, /* 좋아요수 */
	scrapCnt NUMBER DEFAULT 0 NOT NULL, /* 스크랩수 */
	followCnt NUMBER, /* 팔로우수 */
	followingCnt NUMBER, /* 팔로잉수 */
	CONSTRAINT PK_tblUser PRIMARY KEY (id)
);

/* 관리자 */
CREATE TABLE tblAdmin (
	id VARCHAR2(20) NOT NULL, /* 관리자아이디 */
	password VARCHAR2(50) NOT NULL, /* 비밀번호 */
	name VARCHAR2(20) NOT NULL, /* 이름 */
	nickName VARCHAR2(50) NOT NULL, /* 닉네임 */
	tel VARCHAR2(20) NOT NULL, /* 연락처 */
	address VARCHAR2(225) NOT NULL, /* 주소 */
	admin_level NUMBER DEFAULT 2 NOT NULL, /* 등급 */
	CONSTRAINT PK_tblAdmin PRIMARY KEY (id)
);

/* 신고 카테고리 */
CREATE TABLE tblReportCat (
	id NUMBER NOT NULL, /* 신고카테고리 번호 */
	content VARCHAR2(2000) NOT NULL, /* 내용 */
	CONSTRAINT PK_tblReportCat PRIMARY KEY (id)
);

/* 태그 */
CREATE TABLE tblTag (
	id NUMBER NOT NULL, /* 태그아이디 */
	tagName VARCHAR2(100) NOT NULL, /* 태그이름 */
	CONSTRAINT PK_tblTag PRIMARY KEY (id)
);

/* 그룹 */
CREATE TABLE tblGroup (
	id NUMBER NOT NULL, /* 그룹아이디 */
	userId VARCHAR2(20) NOT NULL, /* 방장아이디 */
	groupPw VARCHAR2(20) NOT NULL, /* 그룹비밀번호 */
	groupName VARCHAR2(50) NOT NULL, /* 그룹이름 */
	groupImg VARCHAR2(200) DEFAULT 'defaultImg' NOT NULL, /* 그룹이미지 */
	CONSTRAINT PK_tblGroup PRIMARY KEY (id),
	CONSTRAINT FK_tblUser_TO_tblGroup FOREIGN KEY (userId) REFERENCES tblUser (id)
);

/* 게시글 */
CREATE TABLE tblBoard (
	id NUMBER NOT NULL, /* 게시글아이디 */
	userId VARCHAR2(20) NOT NULL, /* 회원아이디 */
	title VARCHAR2(50) NOT NULL, /* 게시글 제목 */
	content VARCHAR2(2000) NOT NULL, /* 본문 */
	regdate DATE DEFAULT SYSDATE NOT NULL, /* 작성일 */
	viewCnt NUMBER DEFAULT 0 NOT NULL, /* 조회수 */
	reportCnt NUMBER DEFAULT 0 NOT NULL, /* 신고횟수 */
	likeCnt NUMBER DEFAULT 0 NOT NULL, /* 좋아요수 */
	scrapCnt NUMBER DEFAULT 0 NOT NULL, /* 스크랩수 */
	CONSTRAINT PK_tblBoard PRIMARY KEY (id),
	CONSTRAINT FK_tblUser_TO_tblBoard FOREIGN KEY (userId) REFERENCES tblUser (id)
);

/* 차단계정 테이블 */
CREATE TABLE tblBlackList (
	id VARCHAR2(20) NOT NULL, /* 회원아이디 */
	CONSTRAINT PK_tblBlackList PRIMARY KEY (id),
	CONSTRAINT FK_tblUser_TO_tblBlackList FOREIGN KEY (id) REFERENCES tblUser (id)
);

/* 팔로우 */
CREATE TABLE tblFollow (
	id NUMBER NOT NULL, /* 팔로우아이디 */
	followerId VARCHAR2(20) NOT NULL, /* 팔로워아이디 */
	followingId VARCHAR2(20) NOT NULL, /* 팔로잉아이디 */
	state CHAR(1) DEFAULT 'y' CHECK (state IN ('y', 'n')), /* 상태 */
	CONSTRAINT PK_tblFollow PRIMARY KEY (id),
	CONSTRAINT FK_tblUser_TO_tblFollow FOREIGN KEY (followerId) REFERENCES tblUser (id),
	CONSTRAINT FK_tblUser_TO_tblFollow2 FOREIGN KEY (followingId) REFERENCES tblUser (id)
);

/* 게시글_해쉬태그 */
CREATE TABLE tblHashTag (
	id NUMBER NOT NULL, /* 해쉬태그아이디 */
	tagId NUMBER NOT NULL, /* 태그아이디 */
	boardId NUMBER NOT NULL, /* 게시글아이디 */
	CONSTRAINT PK_tblHashTag PRIMARY KEY (id),
	CONSTRAINT FK_tblTag_TO_tblHashTag FOREIGN KEY (tagId) REFERENCES tblTag (id),
	CONSTRAINT FK_tblBoard_TO_tblHashTag FOREIGN KEY (boardId) REFERENCES tblBoard (id)
);

/* 이미지 */
CREATE TABLE tblImg (
	id NUMBER NOT NULL, /* 이미지아이디 */
	imgAddress VARCHAR2(255), /* 이미지주소 */
	boardId NUMBER, /* 게시판아이디 */
	CONSTRAINT PK_tblImg PRIMARY KEY (id),
	CONSTRAINT FK_tblBoard_TO_tblImg FOREIGN KEY (boardId) REFERENCES tblBoard (id)
);

/* 댓글 */
CREATE TABLE tblComment (
	id NUMBER NOT NULL, /* 댓글아이디 */
	content VARCHAR2(2000) NOT NULL, /* 내용 */
	writerId VARCHAR2(20) NOT NULL, /* 작성자아이디 */
	boardId NUMBER NOT NULL, /* 부모 게시글번호 */
	reportCnt NUMBER DEFAULT 0 NOT NULL, /* 신고횟수 */
	regdate DATE DEFAULT SYSDATE NOT NULL, /* 작성날짜 */
	CONSTRAINT PK_tblComment PRIMARY KEY (id),
	CONSTRAINT FK_tblUser_TO_tblComment FOREIGN KEY (writerId) REFERENCES tblUser (id),
	CONSTRAINT FK_tblBoard_TO_tblComment FOREIGN KEY (boardId) REFERENCES tblBoard (id)
);

/* 게시글 화이트리스트 테이블 */
CREATE TABLE boardWhiteList (
	id NUMBER NOT NULL, /* 게시글아이디 */
	CONSTRAINT PK_boardWhiteList PRIMARY KEY (id),
	CONSTRAINT FK_tblBoard_TO_boardWL FOREIGN KEY (id) REFERENCES tblBoard (id)
);

/* 댓글 화이트리스트 테이블 */
CREATE TABLE commentWhiteList (
	id NUMBER NOT NULL, /* 댓글아이디 */
	CONSTRAINT PK_commentWhiteList PRIMARY KEY (id),
	CONSTRAINT FK_tblComment_TO_cmtWL FOREIGN KEY (id) REFERENCES tblComment (id)
);

/* 채팅방 */
CREATE TABLE tblChatRoom (
	id NUMBER NOT NULL, /* 채팅방아이디 */
	groupId NUMBER NOT NULL, /* 그룹아이디 */
	regdate DATE DEFAULT SYSDATE NOT NULL, /* 생성시간 */
	chatName VARCHAR2(50) NOT NULL, /* 채팅방이름 */
	CONSTRAINT PK_tblChatRoom PRIMARY KEY (id),
	CONSTRAINT FK_tblGroup_TO_tblChatRoom FOREIGN KEY (groupId) REFERENCES tblGroup (id)
);

/* 메세지 */
CREATE TABLE tblMessage (
	id NUMBER NOT NULL, /* 메세지아이디 */
	chatId NUMBER NOT NULL, /* 채팅방아이디 */
	userId VARCHAR2(20) NOT NULL, /* 보낸사람아이디 */
	content VARCHAR2(2000) NOT NULL, /* 메세지 내용 */
	regdate DATE DEFAULT SYSDATE NOT NULL, /* 보낸시간 */
	CONSTRAINT PK_tblMessage PRIMARY KEY (id),
	CONSTRAINT FK_tblChatRoom_TO_tblMsg FOREIGN KEY (chatId) REFERENCES tblChatRoom (id),
	CONSTRAINT FK_tblGroupUser_TO_tblMsg FOREIGN KEY (userId) REFERENCES tblGroupUser (userId)
);

/* 그룹멤버 */
CREATE TABLE tblGroupUser (
	userId VARCHAR2(20) NOT NULL, /* 회원아이디 */
	groupId NUMBER NOT NULL, /* 그룹아이디 */
	groupLevel NUMBER DEFAULT 1 NOT NULL, /* 등급 */
	CONSTRAINT PK_tblGroupUser PRIMARY KEY (userId),
	CONSTRAINT FK_tblGroup_TO_tblGroupUser FOREIGN KEY (groupId) REFERENCES tblGroup (id),
	CONSTRAINT FK_tblUser_TO_tblGroupUser FOREIGN KEY (userId) REFERENCES tblUser (id)
);

/* 채팅방 화이트리스트 테이블 */
CREATE TABLE tblChatRoomWhiteList (
	id NUMBER NOT NULL, /* 채팅방아이디 */
	CONSTRAINT PK_tblChatRoomWL PRIMARY KEY (id),
	CONSTRAINT FK_tblChatRoom_TO_CRWL FOREIGN KEY (id) REFERENCES tblChatRoom (id)
);

/* 그룹게시글 */
CREATE TABLE tblGroupBoard (
	id NUMBER NOT NULL, /* 그룹게시글아이디 */
	groupId NUMBER NOT NULL, /* 그룹아이디 */
	boardId NUMBER NOT NULL, /* 게시글아이디 */
	CONSTRAINT PK_tblGroupBoard PRIMARY KEY (id),
	CONSTRAINT FK_tblGroup_TO_tblGroupBrd FOREIGN KEY (groupId) REFERENCES tblGroup (id),
	CONSTRAINT FK_tblBoard_TO_tblGroupBrd FOREIGN KEY (boardId) REFERENCES tblBoard (id)
);

/* 그룹게시글 화이트리스트 테이블 */
CREATE TABLE tblGroupBoardWhiteList (
	id NUMBER NOT NULL, /* 그룹게시글아이디 */
	CONSTRAINT PK_tblGroupBoardWL PRIMARY KEY (id),
	CONSTRAINT FK_tblGroupBoard_TO_GBWL FOREIGN KEY (id) REFERENCES tblGroupBoard (id)
);

/* 스크랩 게시글 */
CREATE TABLE tblScrap (
	id NUMBER NOT NULL, /* 스크랩 게시글 아이디 */
	userId VARCHAR2(20) NOT NULL, /* 회원아이디 */
	boardId NUMBER NOT NULL, /* 게시글아이디 */
	state CHAR(1) DEFAULT 'y' CHECK (state IN ('y', 'n')), /* 상태 */
	CONSTRAINT PK_tblScrap PRIMARY KEY (id),
	CONSTRAINT FK_tblUser_TO_tblScrap FOREIGN KEY (userId) REFERENCES tblUser (id),
	CONSTRAINT FK_tblBoard_TO_tblScrap FOREIGN KEY (boardId) REFERENCES tblBoard (id)
);

/* 게시글 좋아요 기록 */
CREATE TABLE tblLike (
	id NUMBER NOT NULL, /* 게시글 좋아요 아이디 */
	userId VARCHAR2(20) NOT NULL, /* 회원아이디 */
	boardId NUMBER NOT NULL, /* 게시글아이디 */
	state CHAR(1) DEFAULT 'y' CHECK (state IN ('y', 'n')), /* 상태 */
	CONSTRAINT PK_tblLike PRIMARY KEY (id),
	CONSTRAINT FK_tblUser_TO_tblLike FOREIGN KEY (userId) REFERENCES tblUser (id),
	CONSTRAINT FK_tblBoard_TO_tblLike FOREIGN KEY (boardId) REFERENCES tblBoard (id)
);

/* 게시글 신고 기록 */
CREATE TABLE tblBoardReport (
	id NUMBER NOT NULL, /* 게시글 신고 아이디 */
	boardId NUMBER NOT NULL, /* 게시글아이디 */
	reportCat NUMBER NOT NULL, /* 신고카테고리 번호 */
	userId VARCHAR2(20) NOT NULL, /* 회원아이디 */
	CONSTRAINT PK_tblBoardReport PRIMARY KEY (id),
	CONSTRAINT FK_tblBoard_TO_tblBrdRpt FOREIGN KEY (boardId) REFERENCES tblBoard (id),
	CONSTRAINT FK_tblReportCat_TO_tblBrdRpt FOREIGN KEY (reportCat) REFERENCES tblReportCat (id),
	CONSTRAINT FK_tblUser_TO_tblBrdRpt FOREIGN KEY (userId) REFERENCES tblUser (id)
);

/* 댓글 신고 기록 */
CREATE TABLE tblCommentReport (
	id NUMBER NOT NULL, /* 댓글 신고 아이디 */
	commentId NUMBER NOT NULL, /* 댓글아이디 */
	reportCat NUMBER NOT NULL, /* 신고카테고리 번호 */
	userId VARCHAR2(20) NOT NULL, /* 회원아이디 */
	CONSTRAINT PK_tblCommentReport PRIMARY KEY (id),
	CONSTRAINT FK_tblComment_TO_tblCmtRpt FOREIGN KEY (commentId) REFERENCES tblComment (id),
	CONSTRAINT FK_tblReportCat_TO_tblCmtRpt FOREIGN KEY (reportCat) REFERENCES tblReportCat (id),
	CONSTRAINT FK_tblUser_TO_tblCmtRpt FOREIGN KEY (userId) REFERENCES tblUser (id)
);

-- 트리거 생성
CREATE OR REPLACE TRIGGER trg_tblReportCat_id
BEFORE INSERT ON tblReportCat
FOR EACH ROW
BEGIN
  SELECT seqReportCat.NEXTVAL INTO :NEW.id FROM DUAL;
END;
/

CREATE OR REPLACE TRIGGER trg_tblTag_id
BEFORE INSERT ON tblTag
FOR EACH ROW
BEGIN
SELECT seqTag.NEXTVAL INTO :NEW.id FROM DUAL;
END;
/
CREATE OR REPLACE TRIGGER trg_tblGroup_id
BEFORE INSERT ON tblGroup
FOR EACH ROW
BEGIN
SELECT seqGroup.NEXTVAL INTO :NEW.id FROM DUAL;
END;
/
CREATE OR REPLACE TRIGGER trg_tblBoard_id
BEFORE INSERT ON tblBoard
FOR EACH ROW
BEGIN
SELECT seqBoard.NEXTVAL INTO :NEW.id FROM DUAL;
END;
/
CREATE OR REPLACE TRIGGER trg_tblFollow_id
BEFORE INSERT ON tblFollow
FOR EACH ROW
BEGIN
SELECT seqFollow.NEXTVAL INTO :NEW.id FROM DUAL;
END;
/
CREATE OR REPLACE TRIGGER trg_tblHashTag_id
BEFORE INSERT ON tblHashTag
FOR EACH ROW
BEGIN
SELECT seqHashTag.NEXTVAL INTO :NEW.id FROM DUAL;
END;
/
CREATE OR REPLACE TRIGGER trg_tblImg_id
BEFORE INSERT ON tblImg
FOR EACH ROW
BEGIN
SELECT seqImg.NEXTVAL INTO :NEW.id FROM DUAL;
END;
/
CREATE OR REPLACE TRIGGER trg_tblComment_id
BEFORE INSERT ON tblComment
FOR EACH ROW
BEGIN
SELECT seqComment.NEXTVAL INTO :NEW.id FROM DUAL;
END;
/
CREATE OR REPLACE TRIGGER trg_tblChatRoom_id
BEFORE INSERT ON tblChatRoom
FOR EACH ROW
BEGIN
SELECT seqChatRoom.NEXTVAL INTO :NEW.id FROM DUAL;
END;
/
CREATE OR REPLACE TRIGGER trg_tblMessage_id
BEFORE INSERT ON tblMessage
FOR EACH ROW
BEGIN
SELECT seqMessage.NEXTVAL INTO :NEW.id FROM DUAL;
END;
/
CREATE OR REPLACE TRIGGER trg_tblGroupBoard_id
BEFORE INSERT ON tblGroupBoard
FOR EACH ROW
BEGIN
SELECT seqGroupBoard.NEXTVAL INTO :NEW.id FROM DUAL;
END;
/
CREATE OR REPLACE TRIGGER trg_tblScrap_id
BEFORE INSERT ON tblScrap
FOR EACH ROW
BEGIN
SELECT seqScrap.NEXTVAL INTO :NEW.id FROM DUAL;
END;
/
CREATE OR REPLACE TRIGGER trg_tblLike_id
BEFORE INSERT ON tblLike
FOR EACH ROW
BEGIN
SELECT seqLike.NEXTVAL INTO :NEW.id FROM DUAL;
END;
/
CREATE OR REPLACE TRIGGER trg_tblBoardReport_id
BEFORE INSERT ON tblBoardReport
FOR EACH ROW
BEGIN
SELECT seqBoardReport.NEXTVAL INTO :NEW.id FROM DUAL;
END;
/
CREATE OR REPLACE TRIGGER trg_tblCommentReport_id
BEFORE INSERT ON tblCommentReport
FOR EACH ROW
BEGIN
SELECT seqCommentReport.NEXTVAL INTO :NEW.id FROM DUAL;
END;
/


commit;

select * from tblUser;
show user;

desc tblBoard;

select * from tblUser;
delete tblUser;

INSERT INTO tblUser (id, password, name, nickName, tel, address, state, user_level, score, userImg, reportCnt, likeCnt, scrapCnt, followCnt, followingCnt)
VALUES ('user01', 'password01', '홍길동', '길동이', '010-1234-5678', '서울시 강남구 역삼동', '활동', 1, 0, 'defaultImg', 0, 0, 0, 0, 0);
select * from tbluser;