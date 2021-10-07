/* PATSTAT NPL WOS links */
 
 /* Assign time period and cpc_class_symbol code of the technology */
  /* Select NUTS regions */

DROP TABLE IF EXISTS tech
SELECT distinct a.appln_id, b.cpc_class_symbol, d.cited_npl_publn_id, e.ut, nuts2=left(h.[nuts_level3_code],4), i.source
INTO tech
  FROM patstat_2020autumn..tls201_appln as a 
  join patstat_2020autumn..tls224_appln_cpc as b on a.appln_id=b.appln_id
  join patstat_2020autumn..tls211_pat_publn as c on a.appln_id=c.appln_id
  join patstat_2020autumn..tls212_citation as d on c.pat_publn_id=d.pat_publn_id
  join cwtsdb_patstat..Patstat2020Autumn_WoS as e on d.cited_npl_publn_id=e.npl_publn_id
  join wos_2052..pub_affiliation as f on e.ut=f.ut
  join wos_2052_geolocation..pub_affiliation_city_geolocation as g on f.ut=g.ut and f.affiliation_seq=g.affiliation_seq
  join wos_2052_geolocation..city_geolocation as h on g.city_geolocation_id=h.city_geolocation_id
  join wos_2052.dbo.pub_detail as i on i.ut = e.ut
  where b.cpc_class_symbol LIKE 'Y02E  10/5%' and i.pub_year between 1991 and 2018 and left(h.[nuts_level3_code],4) != 'NULL'

 /*unique ut (tech_ut = sample)*/
DROP TABLE IF EXISTS tech_ut
SELECT DISTINCT ut 
INTO tech_ut	
FROM tech

SELECT*
FROM tech_ut

/* uts per NUTS3  */
DROP TABLE IF EXISTS tech_ut_all_nuts
SELECT a.ut, nuts2=left(h.[nuts_level3_code],4)
INTO tech_ut_all_nuts
FROM tech_ut as a
JOIN wos_2052.dbo.pub_detail as b ON a.ut = b.ut
join wos_2052..pub_affiliation as f on a.ut=f.ut
join wos_2052_geolocation..pub_affiliation_city_geolocation as g on f.ut=g.ut and f.affiliation_seq=g.affiliation_seq
join wos_2052_geolocation..city_geolocation as h on g.city_geolocation_id=h.city_geolocation_id
where left(h.[nuts_level3_code],4) != 'NULL'

SELECT nuts2, count(*) AS counts 
FROM  tech_ut_all_nuts
GROUP BY nuts2
ORDER BY counts DESC

/*Cluster*/
/* Cluster selection */
/* wos clusters (combining ut and cluster id) */
drop table if exists #cluster_ut_tech
select distinct cluster_id1, a.ut
into #cluster_ut_tech
from wos_2013_classification..clustering as a
join tech_ut as b on b.ut=a.ut

SELECT*
FROM #cluster_ut_tech


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
join wos_2052..pub as b on a.ut=b.ut
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
JOIN wos_2113_classification.vosviewer.map_micro_level_fields AS b on b.id = a.cluster_id1 

SELECT*
FROM mapfile

/*Sample*/
SELECT*
FROM wos_2052.dbo.pub_detail
WHERE ut = '000084910300014'