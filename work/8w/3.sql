CREATE OR REPLACE TRIGGER Movie_Insert
BEFORE INSERT ON Movie
FOR EACH ROW
DECLARE
    v_avg_length NUMBER;
    v_min_movie_count NUMBER;
    v_studio_name VARCHAR2(100);
    v_random_producer NUMBER;
BEGIN
    -- length가 NULL인 경우 평균 상영시간
    IF :NEW.length IS NULL THEN
        SELECT AVG(length) INTO v_avg_length
        FROM Movie;
        :NEW.length := ROUND(v_avg_length);
    END IF;
    
    -- inColor가 NULL인 경우 t
    IF :NEW.incolor IS NULL THEN
        :NEW.incolor := 't';
    END IF;
    
    -- studioname이 NULL인 경우
    IF :NEW.studioname IS NULL THEN
        -- 영화를 가장 적게 제작한 영화사 찾기
        SELECT name INTO v_studio_name
        FROM (
            SELECT s.name, COUNT(m.title) as movie_count
            FROM Studio s
            LEFT JOIN Movie m ON s.name = m.studioname
            GROUP BY s.name
            HAVING COUNT(m.title) > 0
            ORDER BY COUNT(m.title) ASC, DBMS_RANDOM.VALUE
        )
        WHERE ROWNUM = 1;
        
        :NEW.studioname := v_studio_name;
    END IF;
    
    -- producerNo가 NULL인 경우 random하게 선택
    IF :NEW.producerno IS NULL THEN
        SELECT certno INTO v_random_producer
        FROM (
            SELECT certno
            FROM MovieExec
            ORDER BY DBMS_RANDOM.VALUE
        )
        WHERE ROWNUM = 1;
        
        :NEW.producerno := v_random_producer;
    END IF;
END;
/