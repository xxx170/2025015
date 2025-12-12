drop table StarsIn cascade constraints;
drop table MovieStar cascade constraints;
drop table Movie cascade constraints;
drop table Studio cascade constraints;
drop table MovieExec cascade constraints;

  CREATE TABLE "MOVIEEXEC" 
   (	"NAME" VARCHAR2(100) constraint me_name UNIQUE, 
	"ADDRESS" VARCHAR2(255), 
	"CERTNO" NUMBER(*,0) constraint me_key Primary Key, 
	"NETWORTH" NUMBER(*,0)
   )
/
REM INSERTING into MOVIEEXEC
SET DEFINE OFF;
Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH) values ('sharky','hollywood',1,1000000);
Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH) values ('walt disney','california',2,258000000);
Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH) values ('harry conick jr.','hollywood',3,12000);
Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH) values ('seok hee hong','daeyun_dong nam_gu, pusan',4,158000000);
Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH) values ('john picolo','washington',5,248000000);
Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH) values ('malcom mac','seattle',6,258000000);
Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH) values ('fernando buttanda','canada',7,342001);
Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH) values ('john alan simon','chicago, illnois',8,258000000);
Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH) values ('george lucas','modesto, california',9,4300020);
Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH) values ('ian bryce','hollywood',10,5400020);
Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH) values ('robert redford','santa monica, california',11,92100000);
Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH) values ('mike meyers','malibu, california',12,2000000);
Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH) values ('james l. brooks','north bergen, new jersey',13,3000000);
Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH) values ('dan kolsrud','trollhuset, norway',14,4000000);
Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH) values ('danny devito','neptune nj',15,500000);
Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH) values ('alfred molina','london, england, uk',16,640000);
Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH) values ('merv griffin','san mateo, california',17,3000000);
Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH) values ('jack smith','santa babara, california',18,368000000);
Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH) values ('smile kang','neptune newyork',19,12340000);
Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH) values ('albert t. viola','stone ridge mall rd., california',20,340000);
Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH) values ('clark gable','cadiz_street, ohio',21,1234560);
Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH) values ('michael mann','buzz_ld., florida, USA',22,9231234560);
Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH) values ('rechard jung','banff, new york, usa',23,87795848400);
Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH) values ('seok hee park','caemroon, texas, usa',24,560000);
Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH) values ('steven spielberg','Cincinnati, Ohio, USA',25,823160000);
Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH) values ('victoria alonso','500 S. Buena Vista Street, Burbank, California, USA',26,128923000);
Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH) values ('denis villeneuve','Trois_Rivieres, Quebec, Canada',31,69795848400);
Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH) values ('cary joji fukunaga','Oakland, California, USA',37,8260000);
Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH) values ('todd phillips','Brooklyn, New York City, New York, USA',43,5400000);
Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH) values ('robert zemeckis','448 S Franklin St, Chicago, Illinois, USA',32,9448310);
Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH) values ('jon favreau','5302 68th St, queens, New york, USA',33,202448310);
Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH) values ('jon watts','900 Jimmy Camp Rd, Fountain, Colorado, USA',34,900100);
Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH) values ('E0','hollywood',45,468445);
Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH) values ('E1','hollywood',50,69795848400);

--------------------------------------------------------
--  DDL for Table MOVIESTAR
--------------------------------------------------------

  CREATE TABLE "MOVIESTAR" 
   (	"NAME" VARCHAR2(100) constraint st_key primary key, 
	"ADDRESS" VARCHAR2(255), 
	"GENDER" CHAR(6), 
	"BIRTHDATE" DATE,
    CONSTRAINT "SEX_CHK" CHECK (gender in ('male', 'female'))
   )
/
REM INSERTING into MOVIESTAR
SET DEFINE OFF;
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('mark hamill','456 oak rd. brentwood','male',to_date('1945-09-13','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('harrison ford','wilson road jackson hole, wy','male',to_date('1942-06-13','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('joon-hun park','Choom-mu-ro, Joong-gu, Seould, South Korea','male',to_date('1961-08-21','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('emilio estevez','450 malibu, new york','male',to_date('1962-01-03','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('dana carvey','pleasanton, california, USA','male',to_date('1965-11-09','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('mike meyers','Malibu, california','male',to_date('1951-03-02','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('carrie fisher','123 maple st., hollywood','female',to_date('1954-05-01','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('sigourney weaver','8942 w. b. beverly hills','female',to_date('1949-10-08','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('carrie henn','new york','male',to_date('1942-01-12','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('karen allen','1776 broadway, ny','female',to_date('1951-10-05','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('rutger hauer','22-32 west cromwell road london, sw5 9qj','male',to_date('1944-01-23','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('sean young','louisville, kentucky','female',to_date('1959-11-20','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('meryl streep','summit st., malibu, new jersey','female',to_date('1949-06-22','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('robert redford','santa monica, California','male',to_date('1937-08-18','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('winona ryder','winona, minnesota','female',to_date('1971-10-29','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('ethan hawke','austin, texas','male',to_date('1970-11-06','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('paul newman','cleveland, ohio','male',to_date('1925-01-25','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('ryan o''neal','los angeles, california','male',to_date('1941-04-20','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('sandra bullock','washington st., California','female',to_date('1965-07-26','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('tommy lee jones','san saba, texas','male',to_date('1946-09-15','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('alec baldwin','massapequa, new york','male',to_date('1958-04-03','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('kim basinger','massapequa, new york','female',to_date('1953-12-08','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('debra winger','cleveland, ohio','female',to_date('1955-05-16','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('jack nicholson','neptune, new jersey','male',to_date('1937-04-22','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('danny devito','neptune nj','male',to_date('1944-11-17','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('john travolta','englewood, new jersey, usa','male',to_date('1954-02-18','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('gene hackman','san bernadino, california','male',to_date('1930-01-30','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('rene russo','burbank, california','female',to_date('1954-02-17','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('ben kingsley','scarborough, england, uk','male',to_date('1943-12-31','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('alfred molina','london, england, uk','female',to_date('1953-05-24','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('vivien leigh','darjeeling, india','female',to_date('1913-11-05','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('clark gable','cadiz, ohio','male',to_date('1901-02-01','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('thomas mitchell','Elizabeth, New Jersey, USA','male',to_date('1901-02-01','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('richard gere','philadelphia, pennsylvania, usa','male',to_date('1949-08-31','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('julia roberts','smyrna, georgia, usa','female',to_date('1967-10-28','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('catherine zeta-jones','swansea, west glamorgan, wales, uk','female',to_date('1969-09-25','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('queen latifah','newark, new jersey, usa','female',to_date('1970-03-18','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('kate capshaw','792 fort worth bl., california, usa','female',to_date('1953-11-03','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('sean connery','edinburgh, midlothian, scotland, uk','male',to_date('1930-08-25','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('eileen brennan','1293, bay street, los angeles, california, USA','female',to_date('1932-09-03','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('audrey campbell','new york city, New York, USA','female',to_date('1929-08-05','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('melynda albrecht','grand circle bd, ohio, USA','male',to_date('1922-12-25','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('vera allik','paris, france','female',to_date('1935-01-20','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('johnny depp','Owensboro, Kentucky, USA','male',to_date('1963-06-09','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('rebecca hall','London, England, UK','female',to_date('1982-05-03','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('morgan freeman','Memphis, Tennessee, USA','male',to_date('1937-06-01','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('jon favreau','5302 68th St, queens, New york, USA','male',to_date('1966-10-16','RRRR-MM-DD'));
--------------------------------------------
---- inserted in 2024.05.09
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('anne hathaway','5302 68th St, Brooklyn, New York, USA','female',to_date('1982-11-12','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('anya taylor-joy','Miami, Florida, USA','female',to_date('1996-04-16','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('emily blunt','Roehampton, London, England, UK','female',to_date('1983-02-23','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('chris hemsworth','Melbourne, Victoria, Australia','male',to_date('1983-08-11','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('ryan gosling','London, Ontario, Canada','male',to_date('1980-11-12','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('winston duke','Tabaquite Rd, Tabaquite, Trinidad & Tobago','male',to_date('1986-11-15','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('ariana grande','Boca Raton, Florida, USA','female',to_date('1993-06-26','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('cynthia erivo','Stockwell, London, England, UK','female',to_date('1987-01-08','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('S1','Stockwell, London, England, UK','male',to_date('2001-01-08','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('S2','Stockwell, London, England, UK','male',to_date('2003-11-08','RRRR-MM-DD'));
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE) values ('S3','Stockwell, London, England, UK','male',to_date('2005-06-08','RRRR-MM-DD'));
--------------------------------------------------------
--  DDL for Table STUDIO
--------------------------------------------------------

  CREATE TABLE "STUDIO" 
   (	"NAME" VARCHAR2(100) constraint std_key primary key, 
	"ADDRESS" VARCHAR2(255), 
	"PRESNO" NUMBER(*,0)
   )
/
REM INSERTING into STUDIO
SET DEFINE OFF;
Insert into STUDIO (NAME,ADDRESS,PRESNO) values ('fox','edinburgh, midlothian, scotland, uk',1);
Insert into STUDIO (NAME,ADDRESS,PRESNO) values ('paramount','4101 nw urbandale drive, urbandale, ia 50322',2);
Insert into STUDIO (NAME,ADDRESS,PRESNO) values ('disney','9750 airport blvd. los angeles, ca 90045',3);
Insert into STUDIO (NAME,ADDRESS,PRESNO) values ('warner bros','8585 santa monica blvd. west hollywood, ca 90069',4);
Insert into STUDIO (NAME,ADDRESS,PRESNO) values ('mgm','30 east 30th street new york, ny 10016',5);
Insert into STUDIO (NAME,ADDRESS,PRESNO) values ('neue const film','167 rue de rome paris,  75017',17);
Insert into STUDIO (NAME,ADDRESS,PRESNO) values ('touchstone pictures','22-32 west cromwell road london, sw5 9qj',7);
Insert into STUDIO (NAME,ADDRESS,PRESNO) values ('dream box','2751 Buena Vista Ave, Walnut Creek, CA, Usa',11);
Insert into STUDIO (NAME,ADDRESS,PRESNO) values ('new york film','catsle rock rd., california, usa',2);
Insert into STUDIO (NAME,ADDRESS,PRESNO) values ('Cold spring','830 Market St, San Francisco, california, usa',21);
Insert into STUDIO (NAME,ADDRESS,PRESNO) values ('new cinema','209 Broadway, New York, USA',18);
Insert into STUDIO (NAME,ADDRESS,PRESNO) values ('wild character','stoneridge rd., pleasanton, ca, usa',16);
Insert into STUDIO (NAME,ADDRESS,PRESNO) values ('columbia','Anchorage, Alaska, USA',6);
Insert into STUDIO (NAME,ADDRESS,PRESNO) values ('Amblin Entertainment', 'Universal City, California, usa', 25);
Insert into STUDIO (NAME,ADDRESS,PRESNO) values ('Marvel Studios', '500 S. Buena Vista Street, Burbank, California, Usa', 26);
Insert into STUDIO (NAME,ADDRESS,PRESNO) values ('KS Studio', '325 SooYoung-Ro, Nam-Gu, Busan, South Korea', 33);
Insert into STUDIO (NAME,ADDRESS,PRESNO) values ('Skywalker', '123-3 DongJak-Ro, DongJak-Gu, Seoul, South Korea', 9);
Insert into STUDIO (NAME,ADDRESS,PRESNO) values ('A24', 'New York, New York, United States', 37);
-- Insert into STUDIO (NAME,ADDRESS,PRESNO) values ('S1', 'New York, New York, United States', 10);
--------------------------------------------------------
--  Ref Constraints for Table STUDIO
--------------------------------------------------------

  ALTER TABLE "STUDIO" ADD  constraint studio_fk FOREIGN KEY ("PRESNO")
	  REFERENCES "MOVIEEXEC" ("CERTNO") -- ON DELETE CASCADE disable
/

--------------------------------------------------------
--  DDL for Table MOVIE
--------------------------------------------------------

  CREATE TABLE "MOVIE" 
   (	"TITLE" VARCHAR2(255), 
	"YEAR" NUMBER(*,0), 
	"LENGTH" NUMBER(*,0), 
	"INCOLOR" CHAR(1), 
	"STUDIONAME" VARCHAR2(100), 
	"PRODUCERNO" NUMBER(*,0),
    constraint mv_key primary key(title,year),
    constraint mv_chk CHECK (length > 50 and year > 1900 and year <= 2025)
   )
/
REM INSERTING into MOVIE
SET DEFINE OFF;
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('mighty ducks',1991,274,'t','disney',25); 
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('mr. smith goes to washington',1939,274,'t','disney',25);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('pretty woman',1990,119,'t','disney',8);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('wayne''s world',1992,95,'t','paramount',3);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('star wars',1977,124,'t','fox',9);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('star Wars',1980,124,'t','fox',9);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('Star wars',1983,131,'t','fox',9);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('aliens',1986,137,'t','fox',1);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('raiders of the lost ark',1981,115,'t','paramount',9);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('blade runner',1982,117,'t','warner bros',4);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('out Of africa',1985,150,'t','mgm',11);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('house of the spirits',1993,140,'t','neue const film',6);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('reality bites',1994,99,'t','mgm',5);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('butch cassidy and the sundance kid',1969,110,'t','fox',1);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('sting',1973,129,'t','mgm',12);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('up close and personal',1996,124,'t','touchstone pictures',7);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('love story',1970,99,'t','paramount',3);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('a woman in Love',1970,88,'t','new york film',20);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('speed',1994,115,'t','fox',10);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('coal miner''s daughter',1980,222,'t','mgm',5);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('getaway',1994,115,'t','fox',8);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('terms of endearment',1983,232,'t','paramount',13);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('l.a. confidential',1997,136,'t','warner bros',14);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('get shorty',1995,105,'t','mgm',15);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('species',1995,108,'t','mgm',16);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('gone with the wind',1939,222,'t','fox',2);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('aliens',1996,137,'t','fox',3);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('fool''s running',2000,107,'t','mgm',11);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('Chicago',2002,113,'t','disney',24);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('indiana jones aND the temple of doom',1984,118,'t','paramount',9);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('indiana jones and the last crusade',1989,127,'t','paramount',9);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('The Amazing Spider-Man 2',2014,142,'t','columbia',3);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('Captain America: The Winter Soldier',2014,136,'t','mgm',1);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('Ready Player One',2018,140,'t','Amblin Entertainment',25);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('Avengers: Infinity War',2018,149,'t','Marvel Studios',24);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('blade runner',2017,195,'t','Amblin Entertainment',26);
--------------------------------------------------------
-- Inserted in 2022.05.11
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('Schindler''s List',1994,149,'f','Amblin Entertainment',25);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('%% Ant-Man %%',2003,99,'t','columbia',19);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('%%Lady Bugs%%',2013,102,'f','Marvel Studios',43);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('%forrest%Gump%',2021,131,'t','warner bros',22);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('The Lighthouse',2019,109,'f','A24',37);
-- Inserted in 2023.11.24
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('Forrest Gump',1994,162,'t','paramount',32);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('iron man',2008,126,'t','paramount',33);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('iron man 2',2010,124,'t','paramount',33);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('iron man 3',2013,130,'t','paramount',33);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('Spider-Man: Far from Home',2019,129,'t','columbia',34);
--------------------------------------------------------
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('M',2020,100,'t','new cinema',31);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('M_M',2021,150,'t','wild character',1);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('M',2022,100,'t','Amblin Entertainment',31);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('M',2023,100,'t','KS Studio',1);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('MZ__1',2023,99,'t','Skywalker',20);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('MZ_2',2023,99,'t','disney',50);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('MZ__3',2023,199,'t','disney',31);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('Kim''s World',2022,131,'t','dream box',9);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('Kim''s World',2023,131,'t','Cold spring',9);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('Kim''s World',2024,131,'t','mgm',9);

  ALTER TABLE "MOVIE" ADD constraint mv_prod FOREIGN KEY ("PRODUCERNO")
	  REFERENCES "MOVIEEXEC" ("CERTNO") -- ON DELETE CASCADE disable
 /
  ALTER TABLE "MOVIE" ADD constraint mv_studio FOREIGN KEY ("STUDIONAME")
	  REFERENCES "STUDIO" ("NAME") -- ON DELETE CASCADE disable
/


Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH) values ('K1','hollywood',30,777777777);
Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH) values ('K2','hollywood',40,999999999);
Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH) values ('K3','hollywood',29,88899999);
Insert into STUDIO (NAME,ADDRESS,PRESNO) values ('K1', 'New York, New York, United States', 29);
Insert into STUDIO (NAME,ADDRESS,PRESNO) values ('K2', 'New York, New York, United States', 29);
Insert into STUDIO (NAME,ADDRESS,PRESNO) values ('K3', 'New York, New York, United States', 29);
Insert into STUDIO (NAME,ADDRESS,PRESNO) values ('K4', 'New York, New York, United States', 29);
Insert into STUDIO (NAME,ADDRESS,PRESNO) values ('K5', 'New York, New York, United States', 29);
Insert into STUDIO (NAME,ADDRESS,PRESNO) values ('K6', 'New York, New York, United States', 29);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('K1',1966,99,'t','fox',30);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('K2',1966,99,'t','mgm',40);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('K2',1976,99,'t','mgm',40);
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO) values ('K2',1986,99,'t','mgm',40);
--------------------------------------------------------
--  DDL for Table STARSIN
--------------------------------------------------------

  CREATE TABLE "STARSIN" 
   (	"MOVIETITLE" VARCHAR2(255), 
	"MOVIEYEAR" NUMBER(*,0), 
	"STARNAME" VARCHAR2(100),
    constraint stin_key primary key(movietitle,movieyear, starname)
   )
/
REM INSERTING into STARSIN
SET DEFINE OFF;
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('Chicago',2002,'catherine zeta-jones');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('Chicago',2002,'queen latifah');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('Chicago',2002,'richard gere');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('a woman in Love',1970,'audrey campbell');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('a woman in Love',1970,'melynda albrecht');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('a woman in Love',1970,'vera allik');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('aliens',1986,'carrie henn');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('aliens',1986,'sigourney weaver');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('aliens',1996,'sigourney weaver');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('blade runner',1982,'harrison ford');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('blade runner',1982,'rutger hauer');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('blade runner',1982,'sean young');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('butch cassidy and the sundance kid',1969,'clark gable');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('butch cassidy and the sundance kid',1969,'paul newman');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('butch cassidy and the sundance kid',1969,'robert redford');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('coal miner''s daughter',1980,'eileen brennan');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('coal miner''s daughter',1980,'tommy lee jones');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('fool''s running',2000,'gene hackman');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('fool''s running',2000,'robert redford');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('fool''s running',2000,'tommy lee jones');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('get shorty',1995,'danny devito');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('get shorty',1995,'gene hackman');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('get shorty',1995,'john travolta');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('get shorty',1995,'rene russo');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('getaway',1994,'alec baldwin');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('getaway',1994,'kim basinger');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('gone with the wind',1939,'clark gable');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('gone with the wind',1939,'vivien leigh');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('house of the spirits',1993,'meryl streep');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('house of the spirits',1993,'winona ryder');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('indiana jones and the last crusade',1989,'harrison ford');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('indiana jones and the last crusade',1989,'sean connery');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('indiana jones aND the temple of doom',1984,'harrison ford');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('indiana jones aND the temple of doom',1984,'kate capshaw');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('l.a. confidential',1997,'danny devito');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('l.a. confidential',1997,'kim basinger');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('love story',1970,'ryan o''neal');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('love story',1970,'tommy lee jones');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('mighty ducks',1991,'emilio estevez');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('out Of africa',1985,'meryl streep');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('out Of africa',1985,'robert redford');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('pretty woman',1990,'julia roberts');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('pretty woman',1990,'richard gere');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('raiders of the lost ark',1981,'harrison ford');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('raiders of the lost ark',1981,'karen allen');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('reality bites',1994,'ethan hawke');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('reality bites',1994,'winona ryder');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('species',1995,'alfred molina');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('species',1995,'ben kingsley');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('speed',1994,'sandra bullock');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('star wars',1977,'carrie fisher');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('star wars',1977,'harrison ford');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('star wars',1977,'mark hamill');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('sting',1973,'eileen brennan');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('sting',1973,'paul newman');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('sting',1973,'robert redford');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('terms of endearment',1983,'danny devito');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('terms of endearment',1983,'debra winger');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('terms of endearment',1983,'jack nicholson');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('up close and personal',1996,'clark gable');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('up close and personal',1996,'robert redford');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('wayne''s world',1992,'dana carvey');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('wayne''s world',1992,'mike meyers');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('The Amazing Spider-Man 2', 2014, 'rebecca hall');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('iron man',2008,'jon favreau');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('iron man 2',2010,'jon favreau');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('iron man 3',2013, 'jon favreau');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('Spider-Man: Far from Home',2019, 'jon favreau');  
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('mr. smith goes to washington',1939,'thomas mitchell');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('gone with the wind',1939,'thomas mitchell');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('butch cassidy and the sundance kid',1969,'thomas mitchell');
--------------------------------------------------------
--- inserted in 2024.05.09
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('%% Ant-Man %%',2003,'anne hathaway');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('%% Ant-Man %%',2003,'winston duke');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('%%Lady Bugs%%',2013,'anya taylor-joy');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('%%Lady Bugs%%',2013,'emily blunt');
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME) values ('%%Lady Bugs%%',2013,'ryan gosling');

  ALTER TABLE "STARSIN" ADD constraint stin_fk1 FOREIGN KEY ("MOVIETITLE", "MOVIEYEAR")
	  REFERENCES "MOVIE" ("TITLE", "YEAR") -- ON DELETE CASCADE ENABLE
 /
  ALTER TABLE "STARSIN" ADD constraint stin_fk2 FOREIGN KEY ("STARNAME")
	  REFERENCES "MOVIESTAR" ("NAME") -- ON DELETE CASCADE ENABLE
/
create or replace view Prod_Studio (producer, p_title, studio, s_title) as
select e.name, pm.title, s.name, sm.title
from ((movieexec e left outer join movie pm on ( certno = pm.producerno )) left outer join 
    studio s on (certno = presno) ) left outer join movie sm on (s.name = sm.studioname);
commit;
quit;
