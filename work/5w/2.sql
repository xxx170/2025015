SET SERVEROUTPUT ON;

DECLARE
    -- 제작자 커서 (이름순 정렬)
    CURSOR exec_cursor IS
        SELECT certno, name
        FROM MOVIEEXEC
        ORDER BY name;
    
    -- 각 제작자가 운영하는 영화사 커서 (역순 정렬)
    CURSOR studio_cursor(p_certno NUMBER) IS
        SELECT name
        FROM STUDIO
        WHERE presno = p_certno
        ORDER BY name DESC;
    
    counter NUMBER := 0;
    studio_list VARCHAR2(4000);
    studio_count NUMBER;
    first_studio BOOLEAN;
    
BEGIN
    -- 각 제작자에 대해 반복
    FOR exec_rec IN exec_cursor LOOP
        counter := counter + 1;
        studio_list := '';
        studio_count := 0;
        first_studio := TRUE;
        
        -- 해당 제작자가 운영하는 영화사 검색
        FOR studio_rec IN studio_cursor(exec_rec.certno) LOOP
            studio_count := studio_count + 1;
            
            IF first_studio THEN
                studio_list := studio_rec.name;
                first_studio := FALSE;
            ELSE
                studio_list := studio_list || ', ' || studio_rec.name;
            END IF;
        END LOOP;
        
        -- 결과 출력
        IF studio_count = 0 THEN
            DBMS_OUTPUT.PUT_LINE('[' || counter || '] 제작자 ' || 
                               exec_rec.name || '는 영화사를 운영하지 않는다.');
        ELSIF studio_count = 1 THEN
            DBMS_OUTPUT.PUT_LINE('[' || counter || '] 제작자 ' || 
                               exec_rec.name || '는 ' || 
                               studio_list || '을 운영한다.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('[' || counter || '] 제작자 ' || 
                               exec_rec.name || '는 ' || 
                               studio_list || ' 을 운영한다.');
        END IF;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE(CHR(10) || '총 ' || counter || '명의 제작자가 출력되었습니다.');
    
END;
/