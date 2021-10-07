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
where b.cpc_class_symbol LIKE 'Y02E  10/30'

SELECT*
FROM #tech_all


/* Clustering the ut's (combining ut and cluster id) */
drop table if exists #cluster_counts
select cluster_id1, a.ut
into #cluster_counts
from wos_2013_classification..clustering as a
join #tech_all as b on b.ut=a.ut


DROP TABLE IF EXISTS #cluster_counts_weight
SELECT cluster_id1, weight = count(ut)
INTO #cluster_counts_weight
FROM #cluster_counts
GROUP BY cluster_id1 
ORDER BY weight DESC

SELECT*
FROM #cluster_counts_weight ORDER BY weight DESC

SELECT SUM (weight) FROM #cluster_counts_weight

/*CLUSTER SELECTION */ 
DROP TABLE IF EXISTS #cluster_perc
SELECT cluster_id1, weight, perc_cluster = (weight /449.00) * 100.0
INTO #cluster_perc
FROM #cluster_counts_weight ORDER BY perc_cluster DESC

SELECT*
FROM #cluster_perc ORDER BY perc_cluster DESC

DROP TABLE IF EXISTS #cluster_selected_weight
SELECT cluster_id1, weight, perc_cluster
INTO #cluster_selected_weight
FROM #cluster_perc
WHERE perc_cluster > 0.1

DROP TABLE IF EXISTS #cluster_selected_weight
SELECT cluster_id1, weight, perc_cluster
INTO #cluster_selected_weight
FROM #cluster_perc
WHERE weight > 1



SELECT SUM (perc_cluster) FROM #cluster_selected_weight
SELECT SUM (weight) FROM #cluster_selected_weight



DROP TABLE IF EXISTS #sample
SELECT ut
INTO #sample
FROM #cluster_selected_weight AS a
JOIN #cluster_counts AS b ON a.cluster_id1 = b.cluster_id1

SELECT*
FROM #cluster_counts

SELECT*
FROM #cluster_selected_weight
ORDER BY perc_cluster DESC

/*1.1 Calculate the frequency of ut's* (unique ut's)*/
DROP TABLE IF EXISTS #sample_counts
SELECT ut, freq = count(ut)
INTO #sample_counts
FROM #sample
GROUP BY ut 
ORDER BY freq DESC

SELECT*
FROM #sample_counts ORDER BY freq DESC

SELECT SUM (freq) FROM #sample_counts