drop table MovieExecInfo cascade constraints;
drop type movie_tab force;
drop type studio_tab force;
drop type movie_ty force;
drop type studio_ty force;

create type movie_ty as object (
  title         varchar(255),
  year          smallint,
  contract_date date,    -- 계약 날짜
  salary        number(20) -- 계약 금액
)
/
create type studio_ty as object (
  name          varchar(30),  -- 영화사 이름
  emp_count	    number(6)   -- 영화사에 근무하는 직원 수
)
/
create or replace type movie_tab as table of movie_ty
/
create or replace type studio_tab as table of studio_ty
/
create table MovieExecInfo (
  name      varchar(30) primary key,
  address   varchar(255),
  networth  int,
  movies   movie_tab,
  studios studio_tab)
  nested table movies store as mm_table
  nested table studios store as studio_table
/
commit;
