drop table StudioInfo;
drop type movie_tab force;
drop type star_tab force;
drop type mv_ty force;
drop type star_ty force;

create type mv_ty as object (
  title         varchar(255),
  year          number(4),
  budget        number(20),     -- 이 영화 제작에 필요한 예산
  producer      varchar(30)     -- 이 영화의 제작자 이름
);
/
create type star_ty as object (
  name          varchar(30),
  salary        number(8),      -- 이 배우의 계약금액
  cont_period   number(2)       -- 이 배우의 계약 기간 (년 단위)
);
/
create or replace type movie_tab as table of mv_ty;
/
create or replace type star_tab as table of star_ty;
/
create table StudioInfo (
  name      varchar(30),    -- 영화사 이름
  address   varchar(255),   -- 영화사 주소
  president varchar(30),    -- 영화사 사장 이름
  movies    movie_tab,      -- 이 영화사가 제작한 영화 리스트
  stars     star_tab)       -- 이 영화사에 소속된 배우들
  nested table movies store as movie_table
  nested table stars store as star_table;
/
commit;