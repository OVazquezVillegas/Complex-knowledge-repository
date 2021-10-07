/* PATSTAT NPL WOS links */
 
 /* Assign time period and cpc_class_symbol code of the technology */
  /* Select NUTS regions */

DROP TABLE IF EXISTS tech
SELECT distinct a.appln_id, b.cpc_class_symbol, d.cited_npl_publn_id, e.ut
INTO tech
  FROM patstat_2020autumn..tls201_appln as a 
  join patstat_2020autumn..tls224_appln_cpc as b on a.appln_id=b.appln_id
  join patstat_2020autumn..tls211_pat_publn as c on a.appln_id=c.appln_id
  join patstat_2020autumn..tls212_citation as d on c.pat_publn_id=d.pat_publn_id
  join cwtsdb_patstat..Patstat2020Autumn_WoS as e on d.cited_npl_publn_id=e.npl_publn_id
  where b.cpc_class_symbol = 'Y02E  10/30' 

 SELECT*
 FROM tech

 /*unique ut*/
DROP TABLE IF EXISTS tech_ut
SELECT DISTINCT ut 
INTO tech_ut
FROM tech

SELECT*
FROM tech_ut

/*Increasing the sample with their references and publications that cited the sample*/
/* 1) References of the sample*/
DROP TABLE IF EXISTS tech_citing
SELECT DISTINCT cited_ut
INTO tech_citing
FROM tech_ut as a
JOIN wos_2113.dbo.citation as b ON a.ut = b.citing_ut

/* 2) Publications that cited the sample*/
DROP TABLE IF EXISTS tech_cited
SELECT DISTINCT citing_ut
INTO tech_cited
FROM tech_ut as a
JOIN wos_2113.dbo.citation as b ON a.ut = b.cited_ut

/* Join all datasets */
 DROP TABLE IF EXISTS #tech_ut_all
 SELECT DISTINCT ut
 INTO #tech_ut_all
 FROM tech_ut
 UNION ALL
 SELECT DISTINCT cited_ut
 FROM tech_citing
 UNION ALL
 SELECT DISTINCT citing_ut
 FROM tech_cited

 SELECT*
 FROM #tech_ut_all

 /* Narrowing to EU (year-year)*/
 DROP TABLE IF EXISTS tech_ut_all
 SELECT DISTINCT b.ut
 INTO tech_ut_all
 FROM #tech_ut_all as b
 JOIN wos_2113.dbo.pub_detail as a ON a.ut = b.ut
 JOIN wos_2113..pub_affiliation as c on c.ut=a.ut
 JOIN wos_2113_geolocation..pub_affiliation_city_geolocation as d on a.ut=d.ut and c.affiliation_seq = d.affiliation_seq
 JOIN wos_2113_geolocation..city_geolocation as e on d.city_geolocation_id=e.city_geolocation_id
 where a.pub_year between 1991 and 2018 and left(e.[nuts_level3_code],4) != 'NULL'

 SELECT*
 FROM  tech_ut_all

/* uts per NUTS3  */
DROP TABLE IF EXISTS tech_ut_all_nuts
SELECT a.ut, nuts2=left(h.[nuts_level3_code],4)
INTO tech_ut_all_nuts
FROM tech_ut_all as a
JOIN wos_2113.dbo.pub_detail as b ON a.ut = b.ut
join wos_2113..pub_affiliation as f on a.ut=f.ut
join wos_2113_geolocation..pub_affiliation_city_geolocation as g on f.ut=g.ut and f.affiliation_seq=g.affiliation_seq
join wos_2113_geolocation..city_geolocation as h on g.city_geolocation_id=h.city_geolocation_id
where left(h.[nuts_level3_code],4) != 'NULL'

SELECT nuts2, count(*) AS counts 
FROM  tech_ut_all_nuts
GROUP BY nuts2
ORDER BY counts DESC

/*NUTS RIPEET*/
SELECT nuts2, count(*) AS counts
FROM tech_ut_all_nuts
WHERE nuts2 = 'ES43' OR nuts2 = 'UKM6' OR nuts2 = 'FI19'
GROUP BY nuts2

/*Cluster*/
/* Cluster selection */
/* wos clusters (combining ut and cluster id) */
drop table if exists #cluster_ut_tech
select distinct cluster_id1, a.ut
into #cluster_ut_tech
from wos_2013_classification..clustering as a
join tech_ut_all as b on b.ut=a.ut


/* Assign weight (number of publications) to cluster_id*/
drop table if exists #cluster_pubs_tech
select cluster_id1, weight=count(distinct a.ut)
into #cluster_pubs_tech
from #cluster_ut_tech as a
group by cluster_id1

SELECT*
FROM #cluster_pubs_tech
ORDER BY weight DESC 


/* % Clusters*/ 
drop table if exists #cluster_pubs
select cluster_id1, pubs=count(distinct a.ut)
into #cluster_pubs
from wos_2013_classification..clustering as a
join wos_2013..pub as b on a.ut=b.ut
where b.pub_year between 1991 and 2018
group by cluster_id1


SELECT*
FROM  #cluster_pubs
ORDER BY pubs ASC

select distinct a.cluster_id1, cluster_pubs=a.pubs, tech_pubs=isnull(d.weight,0), perc_tech=isnull(cast(d.weight as float),0)/cast(a.pubs as float), 
b.label1, b.label2, b.label3, b.label4, b.label5, c.source1,c.source2, c.source3, c.source4
from #cluster_pubs as a
join [wos_2013_classification].[dbo].[labels1] as b on b.cluster_id1=a.cluster_id1
join [wos_2013_classification].[dbo].[sources1] as c on c.cluster_id1=a.cluster_id1
left join #cluster_pubs_tech as d on a.cluster_id1=d.cluster_id1
order by isnull(d.weight,0) desc


/*Visualization*/
DROP TABLE IF EXISTS mapfile
SELECT b.id, b.label, b.x, b.y, b.cluster, a.weight
INTO mapfile
FROM
#cluster_pubs_tech AS a
JOIN wos_2013_classification.vosviewer.map_micro_level_fields AS b on b.id = a.cluster_id1 

SELECT*
FROM mapfile


/*Network file*/
SELECT TOP 5*
FROM wos_2013_classification.vosviewer.network_micro_level_fields

DROP TABLE IF EXISTS network
SELECT b.cluster_id1, a.cited_cluster_id, a.n_cits
INTO network
FROM wos_2013_classification.vosviewer.network_micro_level_fields AS a
JOIN #cluster_pubs_tech AS b ON a.citing_cluster_id = b.cluster_id1
ORDER BY n_cits DESC

/*Counting sample and nuts*/
SELECT*
FROM  tech_ut_all

SELECT nuts2, count(*) AS counts 
FROM  tech_ut_all_nuts
GROUP BY nuts2
ORDER BY counts DESC