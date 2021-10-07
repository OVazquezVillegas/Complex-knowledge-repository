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
DROP TABLE IF EXISTS #tech_counts
SELECT ut, freq = count(ut)
INTO #tech_counts
FROM #tech_all
GROUP BY ut 
ORDER BY freq DESC

SELECT*
FROM #tech_counts

/*PUBLICATIONS SELECTION */ 

/*1.1 Select ut's with more than 1 ut*/
DROP TABLE IF EXISTS #tech_freq
SELECT*  
INTO #tech_freq
FROM #tech_counts
WHERE freq  != '1'

/*CHANGE*/
SELECT SUM (freq) FROM #tech_counts

DROP TABLE IF EXISTS #tech_freq_perc
SELECT ut, freq, perc_ut = (freq/3356.00) * 100.0
INTO #tech_freq_perc
FROM #tech_counts 

SELECT SUM (perc_ut) FROM #tech_freq_perc

DROP TABLE IF EXISTS #tech_freq_sel
SELECT b.ut, b.freq, perc_ut
INTO #tech_freq_sel
FROM #tech_freq_perc AS a
JOIN #tech_freq AS b on a.ut = b.ut

SELECT COUNT(*) FROM #tech_all
SELECT COUNT(*) FROM #tech_counts
SELECT COUNT(*) FROM #tech_freq_sel
SELECT SUM (perc_ut) FROM #tech_freq_sel

SELECT*
FROM #tech_freq ORDER BY ut DESC


/*Cluster*/
/* Cluster selection */
/* wos clusters (combining ut and cluster id) */
drop table if exists #cluster_freq
select distinct cluster_id1, b.ut
into #cluster_freq
from wos_2013_classification..clustering as a
join #tech_freq_sel as b on b.ut=a.ut



DROP TABLE IF EXISTS #cluster_freq_weight
SELECT cluster_id1, weight = count(cluster_id1)
INTO #cluster_freq_weight
FROM #cluster_freq
GROUP BY cluster_id1 
ORDER BY weight DESC



/*CLUSTER SELECTION */ 

/* % Clusters (relative weight) - replace divider after weight (CHANGE)*/ 
SELECT SUM (weight) FROM #cluster_freq_weight

DROP TABLE IF EXISTS cluster_freq_perc
SELECT cluster_id1, weight, perc_cluster = (weight /655.00) * 100.0
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


SELECT SUM (perc_cluster) FROM #cluster_selected_weight
SELECT SUM (weight) FROM #cluster_selected_weight



DROP TABLE IF EXISTS #sample
SELECT ut
INTO #sample
FROM #cluster_freq AS a
JOIN #cluster_selected_weight AS b ON a.cluster_id1 = b.cluster_id1

SELECT*
FROM #sample