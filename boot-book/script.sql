
create table tblBook (
    seq number primary key,
    title varchar2(1000) not null,
    link varchar2(500) null,
    description varchar2(4000) not null,
    image varchar2(500) null,
    author varchar2(300) null,
    discount number null,
    publisher varchar2(300) null,
    isbn varchar2(100) null,
    pubdate varchar2(30) null
);

create sequence seqBook start with 101;








