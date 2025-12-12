SET SERVEROUTPUT ON;

DECLARE
    -- 영화 출연 경력이 있는 배우 커서 (이름순 정렬)
    CURSOR actor_cursor IS
        SELECT DISTINCT ms.name
        FROM MOVIESTAR ms
        WHERE EXISTS (
            SELECT 1 
            FROM STARSIN si 
            WHERE si.starname = ms.name
        )
        ORDER BY ms.name;
    
    -- 각 배우가 출연한 영화 커서 (개봉년도순 정렬)
    CURSOR movie_cursor(p_actor_name VARCHAR2) IS
        SELECT si.movietitle, si.movieyear
        FROM STARSIN si
        WHERE si.starname = p_actor_name
        ORDER BY si.movieyear;
    
    counter NUMBER := 0;
    movie_list VARCHAR2(4000);
    movie_count NUMBER;
    first_movie BOOLEAN;
    
BEGIN
    -- 각 배우에 대해 반복
    FOR actor_rec IN actor_cursor LOOP
        counter := counter + 1;
        movie_list := '';
        movie_count := 0;
        first_movie := TRUE;
        
        -- 해당 배우가 출연한 영화 검색
        FOR movie_rec IN movie_cursor(actor_rec.name) LOOP
            movie_count := movie_count + 1;
            
            IF first_movie THEN
                movie_list := movie_rec.movietitle || '(' || 
                              movie_rec.movieyear || '년)';
                first_movie := FALSE;
            ELSE
                movie_list := movie_list || ', ' || 
                              movie_rec.movietitle || '(' || 
                              movie_rec.movieyear || '년)';
            END IF;
        END LOOP;
        
        -- 결과 출력
        DBMS_OUTPUT.PUT_LINE('[' || counter || '] ' || 
                           actor_rec.name || ' : ' || 
                           movie_list || ' ' || 
                           movie_count || '편 출연');
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE(CHR(10) || '총 ' || counter || '명의 배우가 출력되었습니다.');
    
END;
/