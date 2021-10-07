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
where b.cpc_class_symbol LIKE 'Y02E  10/5%'

SELECT*
FROM #tech_all

/*1.1 Calculate the frequency of ut's* (unique ut's)*/
DROP TABLE IF EXISTS #tech_counts
SELECT ut, freq = count(ut)
INTO #tech_counts
FROM #tech_all
GROUP BY ut 
ORDER BY freq DESC

SELECT*
FROM #tech_counts ORDER BY freq DESC
 

/* Clustering the ut's (combining ut and cluster id) */
drop table if exists #cluster_counts
select distinct cluster_id1, a.ut, b.freq
into #cluster_counts
from wos_2013_classification..clustering as a
join #tech_counts as b on b.ut=a.ut

SELECT*
FROM #cluster_counts ORDER BY freq DESC

SELECT SUM (freq) FROM #cluster_counts



DROP TABLE IF EXISTS #cluster_counts_weight
SELECT cluster_id1, weight = count(ut)
INTO #cluster_counts_weight
FROM #cluster_counts
GROUP BY cluster_id1 
ORDER BY weight DESC

SELECT*
FROM #cluster_counts_weight ORDER BY weight DESC

SELECT SUM (weight) FROM #cluster_counts_weight


/* Join clusters of the saple with vos viewer database to obtain the mapfile attributes */ 
DROP TABLE IF EXISTS mapfile
SELECT b.id, b.label, b.description, b.x, b.y, b.cluster, a.weight
INTO mapfile
FROM #cluster_counts_weight AS a
JOIN wos_2013_classification.vosviewer.map_micro_level_fields AS b on b.id = a.cluster_id1 

/* Display the mapfile */ 
SELECT*
FROM mapfile
ORDER BY weight DESC



/*PUBLICATIONS SELECTION */ 



/*1.1 Select ut's with more than 1 ut*/
DROP TABLE IF EXISTS #tech_freq
SELECT*  
INTO #tech_freq
FROM #tech_counts
WHERE freq  != '1'

SELECT*
FROM #tech_freq

SELECT SUM (freq) FROM #tech_freq

/*Cluster*/
/* Cluster selection */
/* wos clusters (combining ut and cluster id) */
drop table if exists #cluster_freq
select distinct cluster_id1, a.ut, b.freq
into #cluster_freq
from wos_2013_classification..clustering as a
join #tech_freq as b on b.ut=a.ut

SELECT*
FROM #cluster_freq ORDER BY freq DESC

SELECT SUM (freq) FROM #cluster_freq

DROP TABLE IF EXISTS #cluster_freq_weight
SELECT cluster_id1, weight = count(cluster_id1)
INTO #cluster_freq_weight
FROM #cluster_freq
GROUP BY cluster_id1 
ORDER BY weight DESC


SELECT*
FROM #cluster_freq_weight
ORDER BY weight DESC

SELECT SUM (weight) FROM #cluster_freq_weight


/* 5 Join clusters of the saple with vos viewer database to obtain the mapfile attributes */ 
DROP TABLE IF EXISTS mapfile
SELECT b.id, b.label, b.description, b.x, b.y, b.cluster, a.weight
INTO mapfile
FROM #cluster_freq_weight AS a
JOIN wos_2013_classification.vosviewer.map_micro_level_fields AS b on b.id = a.cluster_id1 

/* 5.1 Display the mapfile */ 
SELECT*
FROM mapfile
ORDER BY weight DESC







/*CLUSTER SELECTION */ 

/* % Clusters (relative weight) - replace divider after weight*/ 
SELECT SUM (weight) FROM #cluster_freq_weight

DROP TABLE IF EXISTS cluster_freq_perc
SELECT cluster_id1, weight, perc_cluster = (weight /9772.00) * 100.0
INTO cluster_freq_perc
FROM #cluster_freq_weight ORDER BY perc_cluster DESC

SELECT*
FROM cluster_freq_perc
ORDER BY perc_cluster DESC

DROP TABLE IF EXISTS #cluster_selected_weight
SELECT cluster_id1, weight, perc_cluster
INTO #cluster_selected_weight
FROM cluster_freq_perc
WHERE weight > 1

SELECT*
FROM #cluster_selected_weight
ORDER BY weight DESC

SELECT SUM (weight) FROM #cluster_selected_weight

/*Combine selected clusters with ut's from sample*/ 

DROP TABLE IF EXISTS #cluster_selected_ut 
SELECT a.cluster_id1, b.ut, b.freq
INTO #cluster_selected_ut 
FROM #cluster_selected_weight AS a
JOIN #cluster_freq AS b ON a.cluster_id1 = b.cluster_id1

SELECT*
FROM #cluster_selected_ut

SELECT SUM (freq) FROM #cluster_selected_ut


/* 5 Join clusters of the saple with vos viewer database to obtain the mapfile attributes */ 
DROP TABLE IF EXISTS mapfile
SELECT b.id, b.label, b.description, b.x, b.y, b.cluster, a.weight
INTO mapfile
FROM #cluster_selected_weight AS a
JOIN wos_2013_classification.vosviewer.map_micro_level_fields AS b on b.id = a.cluster_id1 

/* 5.1 Display the mapfile */ 
SELECT*
FROM mapfile
ORDER BY weight DESC




/*FIELD SELECTION */ 

/* Assign a subject category id to each cluster id */
drop table if exists #cluster_subject
SELECT DISTINCT a.cluster_id1, a.weight, a.perc_cluster, b.subject_category_id
INTO #cluster_subject
FROM #cluster_selected_weight AS a
JOIN wos_2013_classification.dbo.cluster_subject_category1 AS b ON a.cluster_id1 =b.cluster_id1

SELECT DISTINCT cluster_id1 FROM #cluster_subject

SELECT*
FROM #cluster_selected_weight

SELECT*
FROM #cluster_subject

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
SELECT DISTINCT cluster_id1, weight
INTO #cluster_fields_selected
FROM #cluster_field
WHERE LR_main_field_id = '3' OR LR_main_field_id = '4' OR LR_main_field_id = '5'

SELECT DISTINCT cluster_id1
FROM #cluster_fields_selected 


SELECT*
FROM #cluster_fields_selected ORDER BY weight DESC

/* Final sample*/
SELECT DISTINCT cluster_id1
FROM #cluster_fields_selected 

DROP TABLE IF EXISTS #sample
SELECT DISTINCT a.cluster_id1, b.ut, b.freq
INTO #sample
FROM #cluster_fields_selected AS a
JOIN #cluster_selected_ut AS b on a.cluster_id1 =b.cluster_id1


SELECT*
FROM #cluster_selected_ut
SELECT DISTINCT ut
FROM #sample

SELECT*
FROM #sample ORDER BY freq DESC

SELECT SUM (freq) FROM #sample

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




/* INCREASING SAMPLE */ 

SELECT*
FROM #sample

/*1.2 Increase the sample with their references and publications that cited the sample*/
/* 1.2.1 References of the sample*/
DROP TABLE IF EXISTS #tech_citing
SELECT cited_ut
INTO #tech_citing
FROM #sample as a
JOIN wos_2113.dbo.citation as b ON a.ut = b.citing_ut

SELECT*
FROM #tech_citing

DROP TABLE IF EXISTS #tech_citing_counts
SELECT cited_ut, freq = count(cited_ut)
INTO #tech_citing_counts
FROM #tech_citing
GROUP BY cited_ut 
ORDER BY freq DESC

SELECT*
FROM #tech_citing

SELECT SUM (freq) FROM #tech_citing_counts


/* 1.2.2 Publications that cited the sample*/
DROP TABLE IF EXISTS #tech_cited
SELECT citing_ut
INTO #tech_cited
FROM #sample as a
JOIN wos_2113.dbo.citation as b ON a.ut = b.cited_ut

DROP TABLE IF EXISTS #tech_cited_counts
SELECT citing_ut, freq = count(citing_ut)
INTO #tech_cited_counts
FROM #tech_cited
GROUP BY citing_ut 
ORDER BY freq DESC


SELECT citing_ut, freq = count(citing_ut)
FROM #tech_cited
GROUP BY citing_ut 
ORDER BY freq DESC

SELECT SUM (freq) FROM #tech_cited_counts

/* 1.2.3 Join all datasets */
DROP TABLE IF EXISTS #sample_expanded
SELECT ut
INTO #sample_expanded
FROM #sample
UNION ALL
SELECT  cited_ut
FROM tech_citing
UNION ALL
SELECT  citing_ut
FROM #tech_cited


/*Calculate the frequency of ut's* (unique ut's)*/
DROP TABLE IF EXISTS #sample_expanded_counts
SELECT ut, freq = count(ut)
INTO #sample_expanded_counts
FROM #sample_expanded
GROUP BY ut 
ORDER BY freq DESC

SELECT*
FROM #sample_expanded_counts ORDER BY freq DESC


/* 2. Narrow to geographical and temporal scope (European regions, 1991-2018)*/
DROP TABLE IF EXISTS #sample_expanded_eu
SELECT b.ut
INTO #sample_expanded_eu
FROM #sample_expanded as b
JOIN wos_2113.dbo.pub_detail AS a ON a.ut = b.ut
JOIN wos_2113..pub_affiliation AS c ON c.ut=a.ut
JOIN wos_2113_geolocation..pub_affiliation_city_geolocation AS d ON a.ut=d.ut and c.affiliation_seq = d.affiliation_seq
JOIN wos_2113_geolocation..city_geolocation AS e ON d.city_geolocation_id=e.city_geolocation_id
WHERE a.pub_year between 2000 and 2018 and left(e.[nuts_level3_code],4) != 'NULL'


/*Calculate the frequency of ut's* (unique ut's)*/
DROP TABLE IF EXISTS #sample_expanded_eu_counts
SELECT ut, freq = count(ut)
INTO #sample_expanded_eu_counts
FROM #sample_expanded_eu
GROUP BY ut 
ORDER BY freq DESC

SELECT*
FROM #sample_expanded_eu_counts ORDER BY freq DESC

SELECT SUM (freq) FROM #sample_expanded_eu_counts


/* Clustering publications (using clusters of the sample)*/
/* Assign a cluster id to each ut (2013 classification, microlevel) */
drop table if exists #cluster_sample_expanded_eu
select distinct cluster_id1, a.ut, b.freq
into #cluster_sample_expanded_eu
from wos_2013_classification..clustering as a
join #sample_expanded_eu_counts as b on b.ut=a.ut

SELECT*
FROM #cluster_sample_expanded_eu

SELECT SUM (freq) FROM #cluster_sample_expanded_eu

DROP TABLE IF EXISTS #cluster_sample_expanded_eu_weight
SELECT cluster_id1, weight = count(cluster_id1)
INTO #cluster_sample_expanded_eu_weight
FROM #cluster_sample_expanded_eu
GROUP BY cluster_id1 
ORDER BY weight DESC

SELECT*
FROM #cluster_sample_expanded_eu_weight
ORDER BY weight DESC

SELECT SUM (weight) FROM #cluster_sample_expanded_eu_weight

/* Selecting clusters of the original sample (before expansion) */
DROP TABLE IF EXISTS #cluster_selected_final
SELECT a.cluster_id1, a.weight
INTO #cluster_selected_final
FROM #cluster_sample_expanded_eu_weight AS a
JOIN #cluster_fields_selected AS b ON a.cluster_id1 = b.cluster_id1


/* Joining clustered uts from the original sample and the expanded sample */

SELECT*
FROM 
#cluster_sample_expanded_eu

/* Selecting clusters of the original sample (before expansion) */
DROP TABLE IF EXISTS #cluster_selected_final
SELECT a.cluster_id1, SUM (a.weight + b.weight) AS weight  
INTO #cluster_selected_final
FROM #cluster_sample_expanded_eu_weight AS a
JOIN #cluster_fields_selected AS b ON a.cluster_id1 = b.cluster_id1
GROUP BY a.weight


 

SELECT*
FROM #cluster_sample_expanded_eu_weight
ORDER BY weight DESC
SELECT*
FROM #cluster_fields_selected
ORDER BY weight DESC

/* Combining clusters from sample and expanded sample */
DROP TABLE IF EXISTS #cluster_selected_final
SELECT cluster_id1, SUM (weight) weight
INTO #cluster_selected_final
FROM (
	SELECT cluster_id1, weight
	FROM #cluster_fields_selected
	UNION ALL
	SELECT cluster_id1, weight
	FROM #cluster_sample_expanded_eu_weight
)t
GROUP BY cluster_id1


/* Selecting clusters from original sample (before its expanded) */
DROP TABLE IF EXISTS #cluster_final
SELECT a.cluster_id1, a.weight
INTO #cluster_final
FROM #cluster_selected_final AS a
JOIN #cluster_fields_selected AS b on a.cluster_id1 = b.cluster_id1




SELECT*
FROM #cluster_final
ORDER BY weight DESC

SELECT SUM (weight) FROM  #cluster_final




/* 5 Join clusters of the saple with vos viewer database to obtain the mapfile attributes */ 
DROP TABLE IF EXISTS mapfile
SELECT b.id, b.label, b.description, b.x, b.y, b.cluster, a.weight
INTO mapfile
FROM #cluster_final AS a
JOIN wos_2013_classification.vosviewer.map_micro_level_fields AS b on b.id = a.cluster_id1 

/* 5.1 Display the mapfile */ 
SELECT*
FROM mapfile
ORDER BY weight DESC



