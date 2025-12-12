CREATE OR REPLACE TYPE t_string_array AS 
    VARRAY(10) OF VARCHAR2(100);
/

-- 실제 로직을 수행할 저장 프로시저를 생성
CREATE OR REPLACE PROCEDURE sp_print_exec_by_address (
    p_search_list IN t_string_array
)
IS
    -- 쿼리 문자열 변수
    v_sql_count     VARCHAR2(1000);
    v_sql_avg       VARCHAR2(1000);
    v_sql_details   VARCHAR2(1000);
    
    -- 결과 저장 변수
    v_count         NUMBER;
    v_avg_networth  NUMBER;
    v_search_term   VARCHAR2(100);
    v_row_num       NUMBER;
    
    -- 포맷팅 변수
    v_formatted_avg   VARCHAR2(100);
    v_formatted_worth VARCHAR2(100);
    
    -- 커서 변수
    v_cursor        SYS_REFCURSOR;
    v_exec_record   MOVIEEXEC%ROWTYPE; 

BEGIN
    -- 받은 목록을 하나씩 반복
    FOR i IN 1..p_search_list.COUNT LOOP
    
        v_search_term := p_search_list(i);
        
        -- Dynamic SQL 쿼리 정의
        v_sql_count   := 'SELECT COUNT(*) FROM MOVIEEXEC WHERE UPPER(address) LIKE UPPER(:1)';
        v_sql_avg     := 'SELECT AVG(networth) FROM MOVIEEXEC WHERE UPPER(address) LIKE UPPER(:1)';
        v_sql_details := 'SELECT * FROM MOVIEEXEC WHERE UPPER(address) LIKE UPPER(:1)';
        
        -- COUNT 쿼리 실행
        EXECUTE IMMEDIATE v_sql_count INTO v_count USING '%' || v_search_term || '%';
        
        -- 결과에 따라 분기하여 헤더 출력
        IF v_count = 0 THEN
            -- 결과가 없는 경우
            -- 해더 출력
            DBMS_OUTPUT.PUT_LINE('[' || i || '] ' || v_search_term || ' 가 주소에 있는 임원들 : 해당 정보 없음.');
        ELSE
            -- 결과가 있는 경우
            -- 평균 재산 구하고 해더 출력
            EXECUTE IMMEDIATE v_sql_avg INTO v_avg_networth USING '%' || v_search_term || '%';
            v_formatted_avg := TO_CHAR(v_avg_networth, 'FM999,999,999,999.00') || '원';
            DBMS_OUTPUT.PUT_LINE('[' || i || '] ' || v_search_term || ' 가 주소에 있는 임원들 : 평균재산 액수 - ' || v_formatted_avg);
            
            -- 상세 목록 출력을 위한 커서 열기
            v_row_num := 1; 
            OPEN v_cursor FOR v_sql_details USING '%' || v_search_term || '%';
            
            LOOP
                FETCH v_cursor INTO v_exec_record;
                EXIT WHEN v_cursor%NOTFOUND;
                
                -- 개별 재산 포맷팅 및 출력
                v_formatted_worth := TO_CHAR(v_exec_record.networth, 'FM999,999,999,999.00') || '원';
                DBMS_OUTPUT.PUT_LINE('(' || v_row_num || ') ' || v_exec_record.name || '(' || v_exec_record.address || '에 거주) : 재산 : ' || v_formatted_worth);
                v_row_num := v_row_num + 1;
                
            END LOOP;
            CLOSE v_cursor;     
            
        END IF;
        DBMS_OUTPUT.PUT_LINE('');
        
    END LOOP;
    
END;
/


-- 서버 출력을 활성화
SET SERVEROUTPUT ON;

-- 위에서 생성한 프로시저를 호출
DECLARE
    -- 앞에서 만든 t_string_array 타입을 변수로 선언
    v_search_list t_string_array; 
BEGIN
    -- 검색할 목록을 초기화
    v_search_list := t_string_array('uk', '_', 'california', 'ZZZ', 'new york', 'texas', 'chicago');
    
    -- 목록을 파라미터로 넘겨주면서 프로시저를 호출
    sp_print_exec_by_address(v_search_list); 
END;
/