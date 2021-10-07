/* PATSTAT NPL WOS links */
 
 /* 1. Assign time period and cpc_class_symbol code of the technology */
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

/*Cluster*/
/* Cluster selection */
/* wos clusters (combining ut and cluster id) */
drop table if exists #cluster_tech_ut
select distinct cluster_id1, a.ut
into #cluster_tech_ut
from wos_2013_classification..clustering as a
join #tech_ut as b on b.ut=a.ut

SELECT*
FROM #cluster_tech_ut

DROP TABLE IF EXISTS cluster_weight
SELECT cluster_id1, weight = count(cluster_id1)
INTO #cluster_weight
FROM #cluster_tech_ut
GROUP BY cluster_id1 
ORDER BY weight DESC

SELECT*
FROM #cluster_weight
ORDER BY weight DESC

/* % Clusters (relative weight) - replace divider after weight*/ 
SELECT SUM (weight) FROM #cluster_weight

DROP TABLE IF EXISTS cluster_weight
SELECT cluster_id1, weight, perc_cluster = (weight /453.00) * 100.0
INTO cluster_weight
FROM #cluster_weight ORDER BY perc_cluster DESC

SELECT*
FROM cluster_weight
ORDER BY perc_cluster DESC

DROP TABLE IF EXISTS #cluster_selected_weight
SELECT cluster_id1, weight, perc_cluster
INTO #cluster_selected_weight
FROM cluster_weight
WHERE weight > 2

SELECT*
FROM #cluster_selected_weight
ORDER BY weight DESC

DROP TABLE IF EXISTS #cluster_selected_tech_ut 
SELECT a.cluster_id1, b.ut
INTO #cluster_selected_tech_ut 
FROM #cluster_selected_weight AS a
JOIN #cluster_tech_ut AS b ON a.cluster_id1 = b.cluster_id1

SELECT DISTINCT ut
FROM #cluster_selected_tech_ut

SELECT DISTINCT cluster_id1
FROM #cluster_selected_tech_ut

/* Assign a subject category id to each cluster id */
drop table if exists #cluster_subject
SELECT DISTINCT a.cluster_id1, a.weight, a.perc_cluster, b.subject_category_id
INTO #cluster_subject
FROM #cluster_selected_weight AS a
JOIN wos_2013_classification.dbo.cluster_subject_category1 AS b ON a.cluster_id1 =b.cluster_id1

SELECT DISTINCT cluster_id1 FROM #cluster_subject


/* Assign a main field to each cluster id */
DROP TABLE IF EXISTS #cluster_field
SELECT  a.cluster_id1,a.weight, a.perc_cluster, b.LR_main_field_id
INTO #cluster_field
FROM #cluster_subject AS a
JOIN wos_2013_classification.dbo.subject_category_LR_main_field AS b on a.subject_category_id = b.subject_category_id
 
 SELECT DISTINCT cluster_id1
 FROM #cluster_field

 SELECT*
 FROM #cluster_field
 WHERE LR_main_field_id = '1' OR  LR_main_field_id = '2'

 

/* Select clusters from fields 3 (Physical sciences and engineering), 4 (Life and earth sciences) or 5 (Mathematics and computer science) */
DROP TABLE IF EXISTS #cluster_fields_selected
SELECT DISTINCT*
INTO #cluster_fields_selected
FROM #cluster_field
WHERE LR_main_field_id = '3' OR LR_main_field_id = '4' OR LR_main_field_id = '5'

SELECT DISTINCT cluster_id1
FROM #cluster_fields_selected 


SELECT*
FROM #cluster_fields_selected ORDER BY cluster_id1 DESC

/* Clusters only from fields 3 (Physical sciences and engineering), 4 (Life and earth sciences) or 5 (Mathematics and computer science) */
SELECT DISTINCT cluster_id1
FROM #cluster_fields_selected 

DROP TABLE IF EXISTS #sample
SELECT DISTINCT a.cluster_id1, b.ut
INTO #sample
FROM #cluster_fields_selected AS a
JOIN #cluster_selected_tech_ut AS b on a.cluster_id1 =b.cluster_id1

SELECT DISTINCT ut
FROM #sample

SELECT*
FROM #sample ORDER BY ut DESC

SELECT*
FROM #cluster_fields_selected

SELECT SUM (weight) FROM #cluster_fields_selected



/* 5 Join clusters of the saple with vos viewer database to obtain the mapfile attributes */ 
DROP TABLE IF EXISTS mapfile
SELECT b.id, b.label, b.description, b.x, b.y, b.cluster, a.weight
INTO mapfile
FROM #cluster_fields_selected AS a
JOIN wos_2013_classification.vosviewer.map_micro_level_fields AS b on b.id = a.cluster_id1 

/* 5.1 Display the mapfile */ 
SELECT*
FROM mapfile
ORDER BY weight DESC