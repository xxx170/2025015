<?php
function p_error($id=null) {
    if($id == null) $e = oci_error();
    else $e = oci_error($id);
    print htmlentities($e['message']);
    exit();
}

$conn = oci_connect("db2020875015", "db59107669", "localhost/lecture");
if (!$conn) p_error();

//임원 목록 가져오기 (이름순 정렬, 대소문자 무시)
$query = "SELECT name, address, certno FROM movieexec ORDER BY LOWER(name) ASC";

$stmt = oci_parse($conn, $query);
oci_execute($stmt);
$nrows = oci_fetch_all($stmt, $execs, null, null, OCI_FETCHSTATEMENT_BY_ROW);

echo "<h3>[과제 #2] 영화 임원 목록</h3>";

// 스타일
print "<TABLE border=1 cellspacing=0 cellpadding=5 width=95% align=center>\n";
print "<TR bgcolor=cyan align=center>
        <TH>순번</TH> <TH>이름</TH> <TH>주소</TH>
        <TH>영화사</TH> <TH>제작 영화</TH> <TH>출연 영화</TH>
       </TR>\n";

for ($i = 0; $i < $nrows; $i++) {
    $row = $execs[$i];
    $certno = $row['CERTNO'];
    $name = $row['NAME'];
    
    // 영화사 조회
    $q_s = "SELECT name FROM studio WHERE presno = :cno ORDER BY name ASC";
    $s_st = oci_parse($conn, $q_s); 
    oci_bind_by_name($s_st, ":cno", $certno); 
    oci_execute($s_st);
    $cnt_s = oci_fetch_all($s_st, $res_s, null, null, OCI_FETCHSTATEMENT_BY_ROW);

    //  제작 영화 조회 (개봉년도 순 정렬)
    $q_p = "SELECT title, year FROM movie WHERE producerno = :cno ORDER BY year ASC";
    $p_st = oci_parse($conn, $q_p); 
    oci_bind_by_name($p_st, ":cno", $certno); 
    oci_execute($p_st);
    $cnt_p = oci_fetch_all($p_st, $res_p, null, null, OCI_FETCHSTATEMENT_BY_ROW);
    
    // 출연 영화 조회 (개봉년도 순 정렬)
    $q_a = "SELECT movietitle, movieyear FROM starsin WHERE starname = :sn ORDER BY movieyear ASC";
    $a_st = oci_parse($conn, $q_a); 
    oci_bind_by_name($a_st, ":sn", $name); 
    oci_execute($a_st);
    $cnt_a = oci_fetch_all($a_st, $res_a, null, null, OCI_FETCHSTATEMENT_BY_ROW);
    $max_rows = max($cnt_s, $cnt_p, $cnt_a, 1);
    
    // 첫 번째 줄 출력
    print "<TR bgcolor=lightcyan>\n";
    print "<TD rowspan=$max_rows align=center>" . ($i + 1) . "</TD>";
    print "<TD rowspan=$max_rows align=center>{$row['NAME']}</TD>";
    print "<TD rowspan=$max_rows align=center>{$row['ADDRESS']}</TD>";
    
    // 영화사
    if ($cnt_s <= 1) {
        $txt = ($cnt_s == 0) ? "<font color=red>없음</font>" : $res_s[0]['NAME'];
        print "<TD rowspan=$max_rows align=center>$txt</TD>";
    } else {
        print "<TD align=center>" . $res_s[0]['NAME'] . "</TD>";
    }

    // 제작 영화
    if ($cnt_p <= 1) {
        $txt = ($cnt_p == 0) ? "<font color=red>없음</font>" : $res_p[0]['TITLE'] . " <font color=deeppink>({$res_p[0]['YEAR']})</font>";
        print "<TD rowspan=$max_rows align=center>$txt</TD>";
    } else {
        print "<TD align=center>" . $res_p[0]['TITLE'] . " <font color=deeppink>({$res_p[0]['YEAR']})</font></TD>";
    }

    // 출연 영화
    if ($cnt_a <= 1) {
        $txt = ($cnt_a == 0) ? "<font color=red>없음</font>" : $res_a[0]['MOVIETITLE'] . " <font color=deeppink>({$res_a[0]['MOVIEYEAR']})</font>";
        print "<TD rowspan=$max_rows align=center>$txt</TD>";
    } else {
        print "<TD align=center>" . $res_a[0]['MOVIETITLE'] . " <font color=deeppink>({$res_a[0]['MOVIEYEAR']})</font></TD>";
    }
    print "</TR>\n";

    // 나머지 줄 출력
    for ($k = 1; $k < $max_rows; $k++) {
        print "<TR bgcolor=lightcyan>\n";
        
        if ($cnt_s > 1) {
            $txt = ($k < $cnt_s) ? $res_s[$k]['NAME'] : "&nbsp;";
            print "<TD align=center>$txt</TD>";
        }
        if ($cnt_p > 1) {
            $txt = ($k < $cnt_p) ? $res_p[$k]['TITLE'] . " <font color=deeppink>({$res_p[$k]['YEAR']})</font>" : "&nbsp;";
            print "<TD align=center>$txt</TD>";
        }
        if ($cnt_a > 1) {
            $txt = ($k < $cnt_a) ? $res_a[$k]['MOVIETITLE'] . " <font color=deeppink>({$res_a[$k]['MOVIEYEAR']})</font>" : "&nbsp;";
            print "<TD align=center>$txt</TD>";
        }
        print "</TR>\n";
    }
    
    oci_free_statement($s_st);
    oci_free_statement($p_st);
    oci_free_statement($a_st);
}
print "</TABLE>\n";

oci_free_statement($stmt);
oci_close($conn);
?>