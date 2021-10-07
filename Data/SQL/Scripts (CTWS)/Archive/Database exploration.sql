/* PATSTAT NPL WOS links */
  /* Y02E  10/70 case (Wind) */ 
 /* NUTS codes */
 /* Assigned NUTS codes (0) // For period 1991-2018 (57) */

DROP TABLE IF EXISTS wind
SELECT distinct a.appln_id, b.cpc_class_symbol, d.cited_npl_publn_id, e.ut, nuts2=left(h.[nuts_level3_code],4), i.source,
j.keyword_id, k.keyword_plus_id
INTO wind
  FROM patstat_2020autumn..tls201_appln as a 
  join patstat_2020autumn..tls224_appln_cpc as b on a.appln_id=b.appln_id
  join patstat_2020autumn..tls211_pat_publn as c on a.appln_id=c.appln_id
  join patstat_2020autumn..tls212_citation as d on c.pat_publn_id=d.pat_publn_id
  join cwtsdb_patstat..Patstat2020Autumn_WoS as e on d.cited_npl_publn_id=e.npl_publn_id
  join wos_2052..pub_affiliation as f on e.ut=f.ut
  join wos_2052_geolocation..pub_affiliation_city_geolocation as g on f.ut=g.ut and f.affiliation_seq=g.affiliation_seq
  join wos_2052_geolocation..city_geolocation as h on g.city_geolocation_id=h.city_geolocation_id
  join wos_2052.dbo.pub_detail as i on i.ut = e.ut
  join wos_2052.dbo.pub_keyword as j on j.ut = i.ut
  join wos_2052.dbo.pub_keyword_plus as k on k.ut = i.ut
  where b.cpc_class_symbol = 'Y02E  10/70' and i.pub_year between 1991 and 2018 and left(h.[nuts_level3_code],4) != 'NULL'

  SELECT*
  FROM wind



  SELECT TOP 100*
  FROM wos_2052_geolocation..pub_affiliation_city_geolocation

  SELECT TOP 100*
  FROM  wos_2052..pub_affiliation



  /*keyword (80)*/
  SELECT DISTINCT a.keyword_id, b.keyword
  FROM wind AS a
  join wos_2052.dbo.keyword AS b ON a.keyword_id = b.keyword_id
  ORDER BY keyword ASC

  SELECT a.keyword_id, b.keyword
  FROM wind AS a
  join wos_2052.dbo.keyword AS b ON a.keyword_id = b.keyword_id
  ORDER BY keyword ASC


  /*keyword plus (108)*/
  SELECT DISTINCT a.keyword_plus_id, b.keyword_plus
  FROM wind AS a
  join wos_2052.dbo.keyword_plus AS b ON a.keyword_plus_id = b.keyword_plus_id
  ORDER BY keyword_plus ASC
  
  /*top keyword plus (108)*/
  DROP TABLE IF EXISTS wind_keyword_plus
  SELECT DISTINCT a.keyword_plus_id, b.keyword_plus
  INTO wind_keyword_plus
  FROM wind AS a
  join wos_2052.dbo.keyword_plus AS b ON a.keyword_plus_id = b.keyword_plus_id
  ORDER BY keyword_plus ASC

  DROP TABLE IF EXISTS keyword_counts
  SELECT 
  COUNT (*) AS counts, keyword_plus_id
  INTO keyword_counts
  FROM wind_keyword_plus AS a
  GROUP BY keyword_plus_id

 SELECT DISTINCT a.counts, a.keyword_plus_id, b.keyword_plus
 FROM keyword_counts AS a
 JOIN wind_keyword_plus as b on a.keyword_plus_id = b.keyword_plus_id
 ORDER BY counts DESC



   /*top keyword (80)*/
  DROP TABLE IF EXISTS wind_keyword
  SELECT a.keyword_id, b.keyword
  INTO wind_keyword
  FROM wind AS a
  join wos_2052.dbo.keyword AS b ON a.keyword_id = b.keyword_id
  ORDER BY keyword ASC

  SELECT*
  FROM wind_keyword

  DROP TABLE IF EXISTS keyword_counts
  SELECT 
  COUNT (*) AS counts, keyword_id
  INTO keyword_counts
  FROM wind_keyword AS a
  GROUP BY keyword_id

  SELECT*
  FROM keyword_counts

 SELECT DISTINCT a.counts, a.keyword_id, b.keyword
 FROM keyword_counts AS a
 JOIN wind_keyword as b on a.keyword_id = b.keyword_id
 ORDER BY counts DESC


  /*Journals*/
  DROP TABLE IF EXISTS wind_journals
  SELECT 
  COUNT(*) AS counts, source
  INTO wind_journals
  FROM wind
  GROUP BY source

  /*Structure*/

 SELECT*
 FROM wind_journals
 ORDER BY counts DESC

 SELECT TOP 1000*
 FROM wos_2052.dbo.keyword
 

 SELECT TOP 1000*
 FROM wos_2052.dbo.pub_keyword


 SELECT TOP 1000*
 FROM wos_2052.dbo.keyword_plus

 SELECT*
 FROM wos_2052.dbo.source
 WHERE source_title = 'wind energy'

 /*all publications from Wind Energy journal*/
 SELECT a.source_id, b.ut, nuts2=left(e.[nuts_level3_code],4)
 FROM wos_2052.dbo.source AS a
 JOIN wos_2052.dbo.pub_detail AS b ON a.source_title = b.source
 join wos_2052..pub_affiliation as c on b.ut=c.ut
 join wos_2052_geolocation..pub_affiliation_city_geolocation as d on d.ut=c.ut and d.affiliation_seq=c.affiliation_seq
 join wos_2052_geolocation..city_geolocation as e on e.city_geolocation_id=d.city_geolocation_id
 where b.pub_year between 1991 and 1999 and left(e.[nuts_level3_code],4) != 'NULL' and a.source_id = 25457

 
 /*all publications from Wind Energy journal*/
 SELECT a.source_id, b.ut, nuts2=left(e.[nuts_level3_code],4)
 FROM wos_2052.dbo.source AS a
 JOIN wos_2052.dbo.pub_detail AS b ON a.source_title = b.source
 join wos_2052..pub_affiliation as c on b.ut=c.ut
 join wos_2052_geolocation..pub_affiliation_city_geolocation as d on d.ut=c.ut and d.affiliation_seq=c.affiliation_seq
 join wos_2052_geolocation..city_geolocation as e on e.city_geolocation_id=d.city_geolocation_id
 where b.pub_year between 2000 and 2008 and left(e.[nuts_level3_code],4) != 'NULL' and a.source_id = 25457

 
 /*all publications from Wind Energy journal*/
 SELECT a.source_id, b.ut, nuts2=left(e.[nuts_level3_code],4)
 FROM wos_2052.dbo.source AS a
 JOIN wos_2052.dbo.pub_detail AS b ON a.source_title = b.source
 join wos_2052..pub_affiliation as c on b.ut=c.ut
 join wos_2052_geolocation..pub_affiliation_city_geolocation as d on d.ut=c.ut and d.affiliation_seq=c.affiliation_seq
 join wos_2052_geolocation..city_geolocation as e on e.city_geolocation_id=d.city_geolocation_id
 where b.pub_year between 1991 and 2018 and left(e.[nuts_level3_code],4) != 'NULL' and a.source_id = 25457

 SELECT TOP 5*
 FROM wos_2052.dbo.pub_detail

 /*Counting nuts2*/
 DROP TABLE IF EXISTS wind_all
 SELECT distinct a.appln_id, b.cpc_class_symbol, d.cited_npl_publn_id, e.ut, nuts2=left(h.[nuts_level3_code],4)
 INTO wind_all
  FROM patstat_2020autumn..tls201_appln as a 
  join patstat_2020autumn..tls224_appln_cpc as b on a.appln_id=b.appln_id
  join patstat_2020autumn..tls211_pat_publn as c on a.appln_id=c.appln_id
  join patstat_2020autumn..tls212_citation as d on c.pat_publn_id=d.pat_publn_id
  join cwtsdb_patstat..Patstat2020Autumn_WoS as e on d.cited_npl_publn_id=e.npl_publn_id
  join wos_2052..pub_affiliation as f on e.ut=f.ut
  join wos_2052_geolocation..pub_affiliation_city_geolocation as g on f.ut=g.ut and f.affiliation_seq=g.affiliation_seq
 join wos_2052_geolocation..city_geolocation as h on g.city_geolocation_id=h.city_geolocation_id
  join wos_2052.dbo.pub_detail as i on i.ut = e.ut
  where b.cpc_class_symbol = 'Y02E  10/30' and i.pub_year between 1991 and 2018 and left(h.[nuts_level3_code],4) != 'NULL'

  DROP TABLE IF EXISTS wind_all_regions
  SELECT 
  COUNT(nuts2) AS counts
  INTO wind_all_regions
  FROM wind_all
  GROUP BY nuts2


SELECT*
FROM wind_all_regions

SELECT TOP 500*
FROM wos_2013_classification..clustering 


SELECT DISTINCT cluster_id3
from wos_2013_classification..clustering 


SELECT DISTINCT cluster_id3
from wos_2113_classification..clustering 



/*explore structure database*/
SELECT DATA_TYPE from INFORMATION_SCHEMA.COLUMNS where
table_name = 'clusters'


/*grammar of cast*/

DROP TABLE IF EXISTS cluster_weight
SELECT cluster_id1, counts, perc_cluster = cast(((counts /270.00) * 100.00) as decimal (4) ) 
INTO cluster_weight
FROM cluster_counts ORDER BY perc_cluster DESC

/*Type of article*/

SELECT DISTINCT doc_type
FROM wos_2113.dbo.pub_detail



