<?php
function p_error($id=null) {
    if($id == null) $e = oci_error();
    else $e = oci_error($id);
    print htmlentities($e['message']);
    exit();
}

$conn = oci_connect("db2020875015", "db59107669", "localhost/lecture");
if (!$conn) p_error();

$query = "SELECT s.name, count(*) as cnt 
          FROM studio s, movie m 
          WHERE s.name = m.studioname 
          GROUP BY s.name 
          HAVING count(*) >= 1 
          ORDER BY s.name";

$stmt = oci_parse($conn, $query);
if (!$stmt) p_error($conn);

$r = oci_execute($stmt);
if (!$r) p_error($stmt);

print "<TABLE border=1 cellspacing=2 bgcolor=#ddeeff>\n";
print "<TR bgcolor=#bbccdd align=center><TH>영화사<TH>제작한 영화수</TR>\n";

while ($row = oci_fetch_array($stmt, OCI_ASSOC)) {
    $s_name = $row['NAME'];
    $cnt = $row['CNT'];
    $s_name_enc = urlencode($s_name);

    print "<TR> <TD> <a href='2_view_studio.php?name=$s_name_enc'><font color=green>$s_name</font></a>"
                . "<TD> <a href='2_view_movies.php?name=$s_name_enc'>$cnt</a> </TR>\n";
}
print "</TABLE>\n";

oci_free_statement($stmt);
oci_close($conn);
?>