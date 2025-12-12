CREATE OR REPLACE TRIGGER StarPlays_Trigger
INSTEAD OF INSERT ON StarPlays
FOR EACH ROW
DECLARE
    v_movie_exists NUMBER;
    v_star_exists NUMBER;
    v_top_producer NUMBER;
    v_max_movie_count NUMBER;
    v_youngest_gender CHAR(6);
    v_random_addr VARCHAR2(255);
    v_random_birth DATE;
    v_producer_count NUMBER;
BEGIN
    -- title, year가 Movie 테이블에 있는지 확인
    SELECT COUNT(*) INTO v_movie_exists
    FROM Movie
    WHERE title = :NEW.title AND year = :NEW.year;
    
    -- Movie가 없으면 삽입
    IF v_movie_exists = 0 THEN
        -- 가장 많은 영화를 제작한 제작자 찾기
        SELECT COUNT(*) INTO v_producer_count
        FROM Movie;
        
        IF v_producer_count > 0 THEN
            -- 최다 제작 제작자 중 random 하게선택
            SELECT producerno INTO v_top_producer
            FROM (
                SELECT producerno, COUNT(*) as movie_count
                FROM Movie
                GROUP BY producerno
                ORDER BY COUNT(*) DESC, DBMS_RANDOM.VALUE
            )
            WHERE ROWNUM = 1;
        ELSE
            -- 영화가 하나도 없으면 random 제작자 선택
            SELECT certno INTO v_top_producer
            FROM (
                SELECT certno
                FROM MovieExec
                ORDER BY DBMS_RANDOM.VALUE
            )
            WHERE ROWNUM = 1;
        END IF;
        
        INSERT INTO Movie (title, year, length, incolor, studioname, producerno)
        VALUES (:NEW.title, :NEW.year, NULL, NULL, NULL, v_top_producer);
    END IF;
    
    -- name의 MovieStar 튜플이 있는지 확인
    SELECT COUNT(*) INTO v_star_exists
    FROM MovieStar
    WHERE name = :NEW.name;
    
    -- MovieStar가 없으면 삽입
    IF v_star_exists = 0 THEN
        -- 임의의 주소 생성
        v_random_addr := DBMS_RANDOM.STRING('U', 5) || '-로, ' || 
                        DBMS_RANDOM.STRING('U', 4) || '-구, ' ||
                        CASE TRUNC(DBMS_RANDOM.VALUE(1, 4))
                            WHEN 1 THEN '서울'
                            WHEN 2 THEN '부산'
                            ELSE '인천'
                        END || ', 한국';
        
        -- 가장 어린 배우의 성별 찾기
        BEGIN
            SELECT gender INTO v_youngest_gender
            FROM (
                SELECT gender
                FROM MovieStar
                WHERE birthdate = (SELECT MAX(birthdate) FROM MovieStar)
                ORDER BY DBMS_RANDOM.VALUE
            )
            WHERE ROWNUM = 1;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                -- 배우가 없으면 기본값 설정
                v_youngest_gender := 'male';
        END;
        
        -- 1980년 이후의 임의 생년월일
        v_random_birth := TO_DATE('1980-01-01', 'YYYY-MM-DD') + 
                         TRUNC(DBMS_RANDOM.VALUE(0, 365 * 45));
        
        -- MovieStar 삽입
        INSERT INTO MovieStar (name, address, gender, birthdate)
        VALUES (:NEW.name, v_random_addr, v_youngest_gender, v_random_birth);
    END IF;
    
    -- StarsIn에 튜플 삽입
    BEGIN
        INSERT INTO StarsIn (movietitle, movieyear, starname)
        VALUES (:NEW.title, :NEW.year, :NEW.name);
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            NULL;
    END;
    
END;
/