CREATE OR REPLACE TRIGGER Exec_Update
BEFORE UPDATE ON MovieExec
FOR EACH ROW
DECLARE
    v_is_president NUMBER;
    v_is_producer NUMBER;
    v_max_networth NUMBER;
    v_avg_networth NUMBER;
    v_random_studio VARCHAR2(100);
    v_is_actor NUMBER;
BEGIN
    -- 사장 여부 확인
    SELECT COUNT(*) INTO v_is_president
    FROM Studio
    WHERE presno = :OLD.certno;
    
    -- 영화 제작자 여부 확인
    SELECT COUNT(*) INTO v_is_producer
    FROM Movie
    WHERE producerno = :OLD.certno;
    
    -- 사장 또는 영화 제작자인 경우 name 변경 방지
    IF (v_is_president > 0 OR v_is_producer > 0) AND :NEW.name != :OLD.name THEN
        :NEW.name := :OLD.name;
    END IF;
    
    -- netWorth가 null로 변경되는 경우
    IF :NEW.networth IS NULL THEN
        SELECT MAX(networth) INTO v_max_networth
        FROM MovieExec;
        :NEW.networth := v_max_networth;
    END IF;
    
    -- netWorth가 증가하는 경우
    IF :NEW.networth > :OLD.networth THEN
        -- 사장도 아니고 제작자도 아닌 경우
        IF v_is_president = 0 AND v_is_producer = 0 THEN
            SELECT AVG(networth) INTO v_avg_networth
            FROM MovieExec;
            
            -- 평균보다 큰 경우
            IF :NEW.networth > v_avg_networth THEN
                -- random하게 영화사 선택
                SELECT name INTO v_random_studio
                FROM (
                    SELECT name
                    FROM Studio
                    ORDER BY DBMS_RANDOM.VALUE
                )
                WHERE ROWNUM = 1;
                
                -- 해당 영화사의 사장으로 설정
                UPDATE Studio
                SET presno = :NEW.certno
                WHERE name = v_random_studio;
            END IF;
        END IF;
    END IF;
    
    -- 배우인 경우 address 변경
    SELECT COUNT(*) INTO v_is_actor
    FROM StarsIn
    WHERE starname = :NEW.name;
    
    IF v_is_actor > 0 THEN
        IF :NEW.address NOT LIKE '%에 배우가 삽니다!' THEN
            :NEW.address := :NEW.address || '에 배우가 삽니다!';
        END IF;
    END IF;
END;
/