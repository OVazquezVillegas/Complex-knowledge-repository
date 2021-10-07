/* PATSTAT NPL WOS links */
 
 /* 1. MATCHING NPL WITH UT */

 /* 1.1 Assign time period and cpc_class_symbol code of the technology */
DROP TABLE IF EXISTS #tech_all
SELECT DISTINCT a.appln_id, b.cpc_class_symbol, d.cited_npl_publn_id, e.ut
INTO #tech_all
FROM patstat_2020autumn..tls201_appln as a 
join patstat_2020autumn..tls224_appln_cpc as b on a.appln_id=b.appln_id
join patstat_2020autumn..tls211_pat_publn as c on a.appln_id=c.appln_id
join patstat_2020autumn..tls212_citation as d on c.pat_publn_id=d.pat_publn_id
join cwtsdb_patstat..Patstat2020Autumn_WoS as e on d.cited_npl_publn_id=e.npl_publn_id
where b.cpc_class_symbol LIKE 'Y02E  10/7%'

/* 1.2 Cluster ut's (combining ut and cluster id) */
drop table if exists #cluster_tech
select distinct cluster_id1, a.ut
into #cluster_tech
from wos_2013_classification..clustering as a
join #tech_all as b on b.ut=a.ut

/* 1.2.1 Calculate distinct uts */ 
SELECT DISTINCT ut FROM #cluster_tech

/* 1.3 Compute the weight of clusters (number of cited publications) */
DROP TABLE IF EXISTS #cluster_tech_weight
SELECT cluster_id1, weight = count(ut)
INTO #cluster_tech_weight
FROM #cluster_tech
GROUP BY cluster_id1 
ORDER BY weight DESC

/* 1.4 Obtain the mapfile attributes of the clusters */ 
DROP TABLE IF EXISTS mapfile_1
SELECT distinct b.id, b.label, b.description, b.x, b.y, b.cluster, a.weight
INTO mapfile_1
FROM #cluster_tech_weight AS a
JOIN wos_2013_classification.vosviewer.map_micro_level_fields AS b on b.id = a.cluster_id1 

/* 1.4.1 Display the mapfile 1 */ 
SELECT*
FROM mapfile_1
ORDER BY weight DESC


 /* 2. CLUSTER SELECTION */

/* 2.1 Compute the total weight of clusters  */ 
SELECT SUM (weight) FROM #cluster_tech_weight

/* 2.2 Calculate the share of clusters (CHANGE MANUALLY)*/ 
DROP TABLE IF EXISTS #cluster_perc
SELECT cluster_id1, weight, perc_cluster = (weight /1254.00) * 100.0
INTO #cluster_perc
FROM #cluster_tech_weight ORDER BY perc_cluster DESC

/* 2.3 Select clusters with more than 1 ut*/ 
DROP TABLE IF EXISTS #cluster_selected_weight
SELECT cluster_id1, weight, perc_cluster
INTO #cluster_selected_weight
FROM #cluster_perc
WHERE weight > 1

/* 2.4 Select uts from the selected clusters*/ 
DROP TABLE IF EXISTS #cluster_selected_ut 
SELECT DISTINCT ut, a.cluster_id1
INTO #cluster_selected_ut 
FROM #cluster_selected_weight AS a
JOIN #cluster_tech AS b ON a.cluster_id1 = b.cluster_id1


/*3. FIELD SELECTION */ 

/* 3.1 Assign a subject category id to each cluster id */
drop table if exists #cluster_subject
SELECT DISTINCT a.cluster_id1, a.weight, a.perc_cluster, b.subject_category_id
INTO #cluster_subject
FROM #cluster_selected_weight AS a
JOIN wos_2013_classification.dbo.cluster_subject_category1 AS b ON a.cluster_id1 =b.cluster_id1

/* 3.2 Assign a main field to each cluster id */
DROP TABLE IF EXISTS #cluster_field
SELECT  a.cluster_id1,a.weight, a.perc_cluster, b.LR_main_field_id
INTO #cluster_field
FROM #cluster_subject AS a
JOIN wos_2013_classification.dbo.subject_category_LR_main_field AS b on a.subject_category_id = b.subject_category_id

/* 3.3 Select clusters from fields 3 (Physical sciences and engineering), 4 (Life and earth sciences) or 5 (Mathematics and computer science) */
DROP TABLE IF EXISTS #cluster_selected_field
SELECT DISTINCT cluster_id1, weight, perc_cluster, LR_main_field_id
INTO #cluster_selected_field
FROM #cluster_field
WHERE LR_main_field_id = '3' OR LR_main_field_id = '4' OR LR_main_field_id = '5'

/* 3.4 Compute the total weight of clusters (same result as in 2.1) */ 
SELECT SUM (weight) FROM #cluster_tech_weight

/* 3.5 Calculate the share of clusters (CHANGE MANUALLY)*/ 
DROP TABLE IF EXISTS #cluster_field_perc
SELECT DISTINCT a.cluster_id1, a.weight, perc_cluster = (a.weight /1254.00) * 100.0
INTO #cluster_field_perc 
FROM #cluster_tech_weight AS a 
JOIN #cluster_selected_field AS b ON a.cluster_id1 = b.cluster_id1

/* 3.6 Calculate share of final selection of clusters */
SELECT SUM (perc_cluster) FROM #cluster_field_perc

/* 3.7 Select uts from the selected clusters*/ 
DROP TABLE IF EXISTS #sample
SELECT  ut, a.cluster_id1
INTO #sample
FROM #cluster_selected_field AS a
JOIN #cluster_tech AS b on a.cluster_id1 =b.cluster_id1

/* 3.7.1 Calculate distinct uts */ 
SELECT DISTINCT ut FROM #sample

/* 3.8 Obtain the mapfile attributes of the clusters */ 
DROP TABLE IF EXISTS mapfile_2
SELECT distinct b.id, b.label, b.description, b.x, b.y, b.cluster, a.weight
INTO mapfile_2
FROM #cluster_selected_field AS a
JOIN wos_2013_classification.vosviewer.map_micro_level_fields AS b on b.id = a.cluster_id1 

/* 3.8.1 Display the mapfile 2 */ 
SELECT*
FROM mapfile_2
ORDER BY weight DESC


/* 4. EXPANDING THE SAMPLE */ 
/* 4.1 References of the sample*/
DROP TABLE IF EXISTS #tech_citing
SELECT distinct cited_ut
INTO #tech_citing
FROM #sample as a
JOIN wos_2113.dbo.citation as b ON a.ut = b.citing_ut

/* 4.1.1 Calculate distinct uts */ 
SELECT DISTINCT cited_ut FROM #tech_citing

/* 4.2 Publications that cited the sample*/
DROP TABLE IF EXISTS #tech_cited
SELECT distinct citing_ut
INTO #tech_cited
FROM #sample as a
JOIN wos_2113.dbo.citation as b ON a.ut = b.cited_ut

/* 4.2.1 Calculate distinct uts */ 
SELECT DISTINCT citing_ut FROM #tech_cited

/* 4.3 Join all datasets */
DROP TABLE IF EXISTS #sample_expanded
SELECT distinct ut
INTO #sample_expanded
FROM #sample
UNION ALL
SELECT distinct cited_ut
FROM #tech_citing
UNION ALL
SELECT distinct citing_ut
FROM #tech_cited

/* 4.3.1 Calculate distinct uts */ 
SELECT DISTINCT ut FROM #sample_expanded


/* 5. SELECTION OF GEOGRAPHICAL AND TEMPORAL SCOPE */
/* 5.1 Select publication years and geographical scope (European regions, 2010-2019) */ 
DROP TABLE IF EXISTS #sample_expanded_eu
SELECT distinct b.ut
INTO #sample_expanded_eu
FROM #sample_expanded as b
JOIN wos_2113.dbo.pub_detail AS a ON a.ut = b.ut
JOIN wos_2113..pub_affiliation AS c ON c.ut=a.ut
JOIN wos_2113_geolocation..pub_affiliation_city_geolocation AS d ON a.ut=d.ut and c.affiliation_seq = d.affiliation_seq
JOIN wos_2113_geolocation..city_geolocation AS e ON d.city_geolocation_id=e.city_geolocation_id
WHERE a.pub_year between 2010 and 2019 and left(e.[nuts_level3_code],4) != 'NULL'

/* 5.1.1 Calculate distinct uts */ 
SELECT DISTINCT ut FROM #sample_expanded_eu

/* 5.2 Cluster ut's (combining ut and cluster id) */
drop table if exists #cluster_sample_expanded_eu
select cluster_id1, b.ut
into #cluster_sample_expanded_eu
from wos_2013_classification..clustering as a
join #sample_expanded_eu as b on b.ut=a.ut

/* 5.2.1 Calculate distinct uts */ 
SELECT DISTINCT ut FROM #cluster_sample_expanded_eu

/* 5.3 Compute the weight of clusters (number of cited publications) */
DROP TABLE IF EXISTS #cluster_sample_expanded_eu_weight
SELECT cluster_id1, weight = count(cluster_id1)
INTO #cluster_sample_expanded_eu_weight
FROM #cluster_sample_expanded_eu
GROUP BY cluster_id1 
ORDER BY weight DESC

/* 5.4 Filter clusters based on previous selection (in 3.5)*/ 
DROP TABLE IF EXISTS #cluster_filtered
SELECT a.cluster_id1, a.weight
INTO #cluster_filtered
FROM #cluster_sample_expanded_eu_weight AS a
JOIN #cluster_field_perc AS b ON a.cluster_id1 = b.cluster_id1

/* 5.5 Select uts from the selected clusters*/ 
DROP TABLE IF EXISTS #tech_cluster_filtered
SELECT distinct ut, a.cluster_id1
INTO #tech_cluster_filtered
FROM #cluster_sample_expanded_eu AS a
JOIN #cluster_filtered AS b ON a.cluster_id1 = b.cluster_id1

/* 5.5.1 Calculate distinct uts */ 
SELECT DISTINCT ut FROM #tech_cluster_filtered

/* 5.6 Join selected clusters (in 3.1 and 3.5) */
DROP TABLE IF EXISTS #cluster_selected_final
SELECT cluster_id1, SUM (weight) weight
INTO #cluster_selected_final
FROM (
SELECT cluster_id1, weight
FROM #cluster_filtered
UNION ALL
SELECT cluster_id1, weight
FROM #cluster_field_perc
)t
GROUP BY cluster_id1

/* 5.7 Select uts from all clusters selected*/ 
DROP TABLE IF EXISTS #final_sample
SELECT distinct ut, cluster_id1
INTO #final_sample
FROM #tech_cluster_filtered
UNION ALL
SELECT  distinct ut, cluster_id1
FROM #sample

/* 5.8 Obtain the mapfile attributes of the clusters */ 
DROP TABLE IF EXISTS mapfile_3
SELECT b.id, b.label, b.description, b.x, b.y, b.cluster, a.weight
INTO mapfile_3
FROM #cluster_selected_final AS a
JOIN wos_2013_classification.vosviewer.map_micro_level_fields AS b on b.id = a.cluster_id1 

/* 5.8.1 Display the mapfile 3 */ 
SELECT*
FROM mapfile_3
ORDER BY weight DESC


/* 6 SELECTION OF OBSERVATIONS */ 

/*6.1 Assign geographical attributes (NUTS2 and country) to each ut*/ 
DROP TABLE IF EXISTS #tech_ut_all_nuts
SELECT distinct nuts2=left(h.[nuts_level3_code],4), a.ut, a.cluster_id1, i.country_iso_alpha3_code
INTO #tech_ut_all_nuts
FROM #final_sample as a
JOIN wos_2113.dbo.pub_detail as b ON a.ut = b.ut
join wos_2113..pub_affiliation as f on a.ut=f.ut
join wos_2113_geolocation..pub_affiliation_city_geolocation as g on f.ut=g.ut and f.affiliation_seq=g.affiliation_seq
join wos_2113_geolocation..city_geolocation as h on g.city_geolocation_id=h.city_geolocation_id
join wos_2113.dbo.country AS i ON f.country_id = i.country_id
where left(h.[nuts_level3_code],4) != 'NULL'

/* 6.1.1 Calculate the number of unique regional units (NUTS2) of the sample*/ 
SELECT nuts2, count(*) AS counts, country_iso_alpha3_code
FROM  #tech_ut_all_nuts
GROUP BY nuts2, country_iso_alpha3_code
ORDER BY counts DESC

/* 6.2 Calculate the number of unique regional units (NUTS2) in each cluster-id1 (subtopic)*/ 
DROP TABLE IF EXISTS #nuts_cluster_counts
SELECT nuts2,  country_iso_alpha3_code, cluster_id1, counts = count (cluster_id1)
INTO #nuts_cluster_counts
FROM #tech_ut_all_nuts
GROUP BY nuts2, cluster_id1, country_iso_alpha3_code

SELECT*
FROM #nuts_cluster_counts
ORDER BY counts DESC

/* 6.3 Calculate the total number of unique regional units*/ 
DROP TABLE IF EXISTS #wind1
SELECT DISTINCT nuts2
INTO #wind1
FROM #nuts_cluster_counts

SELECT*
FROM #wind1

/* 7.1 Select distinct UTs*/ 
DROP TABLE IF EXISTS #unique_ut
SELECT DISTINCT ut, nuts2
INTO #unique_ut
FROM #tech_ut_all_nuts

SELECT*
FROM #unique_ut