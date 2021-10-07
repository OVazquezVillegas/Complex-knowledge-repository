/* PATSTAT NPL WOS links */
 
 /* 1. Assign cpc_class_symbol code of the technology */
DROP TABLE IF EXISTS #tech_all
SELECT distinct a.appln_id, b.cpc_class_symbol, d.cited_npl_publn_id, e.ut
INTO #tech_all
  FROM patstat_2020autumn..tls201_appln as a 
  join patstat_2020autumn..tls224_appln_cpc as b on a.appln_id=b.appln_id
  join patstat_2020autumn..tls211_pat_publn as c on a.appln_id=c.appln_id
  join patstat_2020autumn..tls212_citation as d on c.pat_publn_id=d.pat_publn_id
  join cwtsdb_patstat..Patstat2020Autumn_WoS as e on d.cited_npl_publn_id=e.npl_publn_id
  where b.cpc_class_symbol LIKE 'Y02E  10/4%' 


 /*1.1 Calculate the frequency of ut's* (unique ut's)*/
   DROP TABLE IF EXISTS #tech_freq
   SELECT ut, freq = count(ut)
   INTO #tech_freq
   FROM #tech_all
   GROUP BY ut 
   ORDER BY freq DESC
   
   SELECT*
   FROM #tech_freq ORDER BY freq DESC
 
 /*1.1 Select ut's with more than 1 ut*/
   DROP TABLE IF EXISTS #tech_ut
   SELECT*  
   INTO #tech_ut
   FROM #tech_freq
   WHERE freq  != '1'



/*1.2 Increase the sample with their references and publications that cited the sample*/
/* 1.2.1 References of the sample*/
DROP TABLE IF EXISTS #tech_citing
SELECT DISTINCT cited_ut
INTO #tech_citing
FROM #tech_ut as a
JOIN wos_2113.dbo.citation as b ON a.ut = b.citing_ut

/* 1.2.2 Publications that cited the sample*/
DROP TABLE IF EXISTS #tech_cited
SELECT DISTINCT citing_ut
INTO #tech_cited
FROM #tech_ut as a
JOIN wos_2113.dbo.citation as b ON a.ut = b.cited_ut

/* 1.2.3 Join all datasets */
 DROP TABLE IF EXISTS #tech_ut_all
 SELECT DISTINCT ut
 INTO #tech_ut_all
 FROM #tech_ut
 UNION ALL
 SELECT DISTINCT cited_ut
 FROM tech_citing
 UNION ALL
 SELECT DISTINCT citing_ut
 FROM #tech_cited


 /* 2. Narrow to geographical and temporal scope (European regions, 1991-2018)*/
 DROP TABLE IF EXISTS #tech_ut_eu
 SELECT DISTINCT b.ut
 INTO #tech_ut_eu
 FROM #tech_ut_all as b
 JOIN wos_2113.dbo.pub_detail as a ON a.ut = b.ut
 JOIN wos_2113..pub_affiliation as c on c.ut=a.ut
 JOIN wos_2113_geolocation..pub_affiliation_city_geolocation as d on a.ut=d.ut and c.affiliation_seq = d.affiliation_seq
 JOIN wos_2113_geolocation..city_geolocation as e on d.city_geolocation_id=e.city_geolocation_id
 where a.pub_year between 1991 and 2018 and left(e.[nuts_level3_code],4) != 'NULL'


/*3. Clustering publications (publications are clustered from 2001 onwards)*/
/* 3.1 Assign a cluster id to each ut (2013 classification, microlevel) */
drop table if exists #cluster_ut_tech
select distinct cluster_id1, a.ut
into #cluster_ut_tech
from wos_2013_classification..clustering as a
join #tech_ut_eu as b on b.ut=a.ut

SELECT*
FROM #cluster_ut_tech
ORDER BY cluster_id1 DESC

/* 3.1.1 Calculate the number clusters */
DROP TABLE IF EXISTS #cluster_counts
SELECT cluster_id1, counts = count(cluster_id1)
INTO #cluster_counts
FROM #cluster_ut_tech
GROUP BY cluster_id1 
ORDER BY counts DESC

SELECT*
FROM #cluster_ut_tech

/* 3.2 Assign a cluster id to each ut of the original sample (#tech_all)*/ 
drop table if exists #cluster_ut_sample
select distinct cluster_id1, a.ut
into #cluster_ut_sample
from wos_2013_classification..clustering as a
join #tech_all as b on b.ut=a.ut

/* 3.2.1 Calculate the number of clusters */
DROP TABLE IF EXISTS #cluster_sample_counts
SELECT cluster_id1, counts = count(cluster_id1)
INTO #cluster_sample_counts
FROM #cluster_ut_sample
GROUP BY cluster_id1 
ORDER BY counts DESC


/* 3.2.1 Calculate the number of clustered ut */
SELECT SUM (counts) FROM #cluster_sample_counts

/* 3.2.2 Calculate the share of each ut per cluster (replace the divider of counts from 3.2.1) */
DROP TABLE IF EXISTS #cluster_sample_weight
SELECT cluster_id1, counts, perc_cluster = (counts /17602.00) * 100.0
INTO #cluster_sample_weight
FROM #cluster_sample_counts ORDER BY perc_cluster DESC

SELECT*
FROM #cluster_sample_weight
ORDER BY perc_cluster DESC

/* 3.2.3 Select clusters with more than 1 ut*/
DROP TABLE IF EXISTS #cluster_sample_selected
SELECT cluster_id1, counts, perc_cluster
INTO #cluster_sample_selected
FROM #cluster_sample_weight
WHERE counts > 1


/* 3.3 Join ut's from step 1.2.3 to filter ut's that belong to selected clusters in 3.2.3 t*/
drop table if exists #cluster_pubs_tech
select a.cluster_id1, weight=count(distinct a.ut)
into #cluster_pubs_tech
from #cluster_ut_tech as a
JOIN #cluster_sample_selected as b ON a.cluster_id1 = b.cluster_id1
group by a.cluster_id1



/* 3.3.1 Calculate the number of ut of the sample */ 
SELECT SUM (weight) FROM #cluster_pubs_tech

/* 3.3.2 Create table of ut's of the final sample */ 
DROP TABLE IF EXISTS #sample
SELECT a.ut
INTO #sample
FROM #cluster_ut_tech as a
JOIN #cluster_pubs_tech as b ON a.cluster_id1=b.cluster_id1





/* Assign a cluster id to each ut (2013 classification, microlevel) */
drop table if exists #newcluster_ut_tech
select distinct cluster_id1, a.ut
into #newcluster_ut_tech
from wos_2013_classification..clustering as a
join #sample as b on b.ut=a.ut

SELECT*
FROM #newcluster_ut_tech

/* Assign a subject category id to each cluster id */
drop table if exists #cluster_subject
SELECT DISTINCT a.cluster_id1, a.ut, b.subject_category_id
INTO #cluster_subject
FROM #newcluster_ut_tech AS a
JOIN wos_2013_classification.dbo.cluster_subject_category1 AS b ON a.cluster_id1 =b.cluster_id1

SELECT*
FROM #cluster_subject

/* Assign a main field to each cluster id */
DROP TABLE IF EXISTS #cluster_field
SELECT  a.cluster_id1, a.ut, a.subject_category_id, b.LR_main_field_id
INTO #cluster_field
FROM #cluster_subject AS a
JOIN wos_2013_classification.dbo.subject_category_LR_main_field AS b on a.subject_category_id = b.subject_category_id
 
 SELECT*
 FROM #cluster_field
 
/* Select clusters from fields 3 (Physical sciences and engineering), 4 (Life and earth sciences) or 5 (Mathematics and computer science) */
DROP TABLE IF EXISTS #cluster_filtered
SELECT cluster_id1, ut
INTO #cluster_filtered
FROM #cluster_field
WHERE LR_main_field_id = '3' OR LR_main_field_id = '4' OR LR_main_field_id = '5'

SELECT DISTINCT*
FROM #cluster_field ORDER BY ut DESC


SELECT DISTINCT*
FROM #cluster_filtered ORDER BY ut DESC

/* Select final ut's (new sample) */
DROP TABLE IF EXISTS #newsample
SELECT ut
INTO #newsample
FROM #cluster_filtered

SELECT DISTINCT*
FROM #newsample



/* 3.4 Join clustering and pubs databases (generic data)*/ 
drop table if exists #cluster_pubs
select cluster_id1, pubs=count(distinct a.ut)
into #cluster_pubs
from wos_2013_classification..clustering as a
join wos_2113..pub as b on a.ut=b.ut
where b.pub_year between 1991 and 2018
group by cluster_id1

SELECT*
FROM #cluster_filtered
SELECT*
FROM #cluster_pubs_tech

DROP TABLE IF EXISTS #cluster_filtered_pubs_tech
SELECT DISTINCT a.cluster_id1, b.weight
INTO #cluster_filtered_pubs_tech
FROM #cluster_filtered AS a 
JOIN #cluster_pubs_tech AS b on a.cluster_id1 = b.cluster_id1

SELECT*
FROM #cluster_filtered_pubs_tech

/* 3.5 Assign labels to clusters of the sample*/ 
select distinct a.cluster_id1, cluster_pubs=a.pubs, tech_pubs=isnull(d.weight,0), perc_tech=isnull(cast(d.weight as float),0)/cast(a.pubs as float), 
b.label1, b.label2, b.label3, b.label4, b.label5, c.source1,c.source2, c.source3, c.source4
from #cluster_pubs as a
join [wos_2013_classification].[dbo].[labels1] as b on b.cluster_id1=a.cluster_id1
join [wos_2013_classification].[dbo].[sources1] as c on c.cluster_id1=a.cluster_id1
left join #cluster_filtered_pubs_tech as d on a.cluster_id1=d.cluster_id1
order by isnull(d.weight,0) desc

SELECT*
FROM #sample

SELECT*
FROM #newsample

/* 4. Assign a geographical attribute (NUTS2) to each ut*/ 
DROP TABLE IF EXISTS tech_ut_all_nuts
SELECT a.ut, nuts2=left(h.[nuts_level3_code],4)
INTO tech_ut_all_nuts
FROM #newsample as a
JOIN wos_2113.dbo.pub_detail as b ON a.ut = b.ut
join wos_2113..pub_affiliation as f on a.ut=f.ut
join wos_2113_geolocation..pub_affiliation_city_geolocation as g on f.ut=g.ut and f.affiliation_seq=g.affiliation_seq
join wos_2113_geolocation..city_geolocation as h on g.city_geolocation_id=h.city_geolocation_id
where left(h.[nuts_level3_code],4) != 'NULL'

/* 4.1 Calculate the number of unique regional units (NUTS2) of the sample*/ 
SELECT nuts2, count(*) AS counts 
FROM  tech_ut_all_nuts
GROUP BY nuts2
ORDER BY counts DESC

/* 4.2 Calculate the number of specific regional units (NUTS2) of the sample*/ 
SELECT nuts2, count(*) AS counts
FROM tech_ut_all_nuts
WHERE nuts2 = 'ES43' OR nuts2 = 'UKM6' OR nuts2 = 'FI19'
GROUP BY nuts2


/* 5 Join clusters of the saple with vos viewer database to obtain the mapfile attributes */ 
DROP TABLE IF EXISTS mapfile
SELECT b.id, b.label, b.description, b.x, b.y, b.cluster, a.weight
INTO mapfile
FROM
#cluster_filtered_pubs_tech AS a
JOIN wos_2013_classification.vosviewer.map_micro_level_fields AS b on b.id = a.cluster_id1 

SELECT*
FROM #cluster_filtered_pubs_tech
ORDER BY cluster_id1 DESC

/* 5.1 Display the mapfile */ 
SELECT*
FROM mapfile
ORDER BY weight DESC


/* 6. Join clusters of the saple with vos viewer database to obtain the network attributes */ 
DROP TABLE IF EXISTS network
SELECT b.cluster_id1, a.cited_cluster_id, a.n_cits
INTO network
FROM wos_2013_classification.vosviewer.network_micro_level_fields AS a
JOIN #cluster_pubs_tech AS b ON a.citing_cluster_id = b.cluster_id1
ORDER BY n_cits DESC

/* 7. Check individuals ut's */ 

SELECT*
FROM wos_2113.dbo.pub_detail
WHERE ut = 'A1996UR15300043'







