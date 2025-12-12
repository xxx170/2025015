  CREATE OR REPLACE  VIEW StarPlays (title, year,name) AS 
  SELECT  movietitle, movieyear, starname
  FROM starsin;