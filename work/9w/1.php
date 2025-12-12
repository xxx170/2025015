<?php
function p_error($id=null) {
    if($id == null) $e = oci_error();
    else $e = oci_error($id);
    print htmlentities($e['message']);
    exit();
}

$conn = oci_connect("db2020875015", "db59107669", "localhost/lecture");
if (!$conn) p_error();

$query = "SELECT m.title, m.year, m.length, 
                 me_prod.name as prodName, 
                 s.name as studioName, 
                 me_boss.name as bossName 
          FROM movie m, studio s, movieexec me_prod, movieexec me_boss
          WHERE m.studioname = s.name 
            AND m.producerno = me_prod.certno 
            AND s.presno = me_boss.certno
          ORDER BY m.year ASC, m.length ASC"; 

$stmt = oci_parse($conn, $query);
if (!$stmt) p_error($conn);

$r = oci_execute($stmt);
if (!$r) p_error($stmt);

print "<TABLE border=1 cellspacing=2 bgcolor=#ccddee>\n";
print "<TR bgcolor=#aabbcc align=center><TH>제목<TH>년도<TH>상영시간<TH>제작자<TH>영화사사장<TH>출연배우수<TH>출연배우진</TR>\n";

while ($row = oci_fetch_array($stmt, OCI_ASSOC)) {
    $title = $row['TITLE'];
    $year = $row['YEAR'];
    $title_esc = str_replace("'", "''", $title);

    $star_query = "SELECT ms.name 
                   FROM starsin si, moviestar ms 
                   WHERE si.movietitle = '$title_esc' 
                     AND si.movieyear = $year 
                     AND si.starname = ms.name 
                   ORDER BY ms.birthdate DESC NULLS LAST";
    
    $stmt_star = oci_parse($conn, $star_query);
    if (!$stmt_star) p_error($conn);
    
    $r_star = oci_execute($stmt_star);
    if (!$r_star) p_error($stmt_star);

    $actors = [];
    while ($star_row = oci_fetch_array($stmt_star, OCI_ASSOC)) {
        $actors[] = $star_row['NAME'];
    }
    
    $actor_count = count($actors);
    $actor_list = ($actor_count > 0) ? implode(", ", $actors) : "정보없음";
    $actor_count_str = ($actor_count > 0) ? $actor_count."명" : "정보없음";

    print "<TR> <TD> {$row['TITLE']} <TD> {$row['YEAR']}년 <TD> {$row['LENGTH']}분"
                . "<TD> {$row['PRODNAME']} <TD> <font color=red><b>{$row['BOSSNAME']}</b></font>"
                . "<TD> $actor_count_str <TD> $actor_list </TR>\n";
    
    oci_free_statement($stmt_star);
}
print "</TABLE>\n";

oci_free_statement($stmt);
oci_close($conn);
?>