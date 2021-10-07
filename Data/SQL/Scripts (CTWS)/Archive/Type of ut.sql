/* Type of ut*/

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

DROP TABLE IF EXISTS #ut_type
SELECT DISTINCT a.ut, a.doc_type
INTO #ut_type
FROM wos_2113.dbo.pub_detail AS a
JOIN #tech_freq as b on a.ut = b.ut

SELECT*
FROM #ut_type

DROP TABLE IF EXISTS #ut_type_counts
SELECT doc_type, counts = count(doc_type)
INTO #ut_type_counts
FROM #ut_type
GROUP BY doc_type 
ORDER BY counts DESC

SELECT SUM (counts) FROM #ut_type_counts

SELECT doc_type, counts, perc_type = (counts /1681.00) * 100.0
FROM #ut_type_counts ORDER BY perc_type DESC