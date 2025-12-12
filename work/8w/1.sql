CREATE OR REPLACE TRIGGER Star_Insert
BEFORE INSERT ON MovieStar
FOR EACH ROW
DECLARE
    v_random_addr VARCHAR2(255);
    v_random_birth DATE;
    v_male_count NUMBER;
    v_female_count NUMBER;
    v_random_gender CHAR(6);
BEGIN
    --address, birthdate가 NULL인 경우 random하게 생성
    IF :NEW.address IS NULL THEN
        v_random_addr := DBMS_RANDOM.STRING('U', 5) || '-로, ' || 
                        DBMS_RANDOM.STRING('U', 4) || '-구, ' ||
                        CASE TRUNC(DBMS_RANDOM.VALUE(1, 4))
                            WHEN 1 THEN '서울'
                            WHEN 2 THEN '부산'
                            ELSE '인천'
                        END || ', 한국';
        :NEW.address := v_random_addr;
    END IF;
    
    IF :NEW.birthdate IS NULL THEN
        -- 1960년 1월 1일부터 2005년 12월 31일 사이의 random 날짜
        v_random_birth := TO_DATE('1960-01-01', 'YYYY-MM-DD') + 
                         TRUNC(DBMS_RANDOM.VALUE(0, 365 * 46));
        :NEW.birthdate := v_random_birth;
    ELSE
        v_random_birth := :NEW.birthdate;
    END IF;
    
    -- gender가 NULL인 경우 처리
    IF :NEW.gender IS NULL THEN
        -- birthdate보다 어린 배우들 중 성별 카운트
        SELECT COUNT(*) INTO v_male_count
        FROM MovieStar
        WHERE birthdate > v_random_birth AND gender = 'male';
        
        SELECT COUNT(*) INTO v_female_count
        FROM MovieStar
        WHERE birthdate > v_random_birth AND gender = 'female';
        
        -- 더 많은 성별 선택, 동수면 random
        IF v_male_count > v_female_count THEN
            :NEW.gender := 'male';
        ELSIF v_female_count > v_male_count THEN
            :NEW.gender := 'female';
        ELSE
            -- 동수인 경우 random 선택
            IF DBMS_RANDOM.VALUE(0, 1) < 0.5 THEN
                :NEW.gender := 'male';
            ELSE
                :NEW.gender := 'female';
            END IF;
        END IF;
    END IF;
END;
/