
	/* Analysis sample*/
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

		DROP TABLE IF EXISTS #sample
		SELECT*
		INTO #sample
		FROM #ut_type
		WHERE doc_type = 'Article'
	
		DROP TABLE IF EXISTS #sample_cluster
	    select distinct cluster_id1, a.ut
		into #sample_cluster
		from wos_2013_classification..clustering as a
		join #sample as b on b.ut=a.ut


		/* Assign a subject category id to each cluster id */
		drop table if exists #cluster_subject
		SELECT DISTINCT a.cluster_id1, a.ut, b.subject_category_id
		INTO #cluster_subject
		FROM #sample_cluster AS a
		JOIN wos_2013_classification.dbo.cluster_subject_category1 AS b ON a.cluster_id1 =b.cluster_id1


		/* Assign a main field to each cluster id */
		DROP TABLE IF EXISTS #cluster_field
		SELECT  a.cluster_id1, a.ut, a.subject_category_id, b.LR_main_field_id
		INTO #cluster_field
		FROM #cluster_subject AS a
		JOIN wos_2013_classification.dbo.subject_category_LR_main_field AS b on a.subject_category_id = b.subject_category_id

		
		DROP TABLE IF EXISTS #field_counts
		SELECT DISTINCT LR_main_field_id, counts = count(LR_main_field_id)
		INTO #field_counts
		FROM #cluster_field
		GROUP BY LR_main_field_id
		ORDER BY LR_main_field_id

		SELECT SUM (counts) FROM #field_counts

		DROP TABLE IF EXISTS #field_share
		SELECT LR_main_field_id, counts, perc_cluster = (counts /1311.00) * 100.0
		INTO #field_share
		FROM #field_counts ORDER BY perc_cluster DESC

		SELECT*
		FROM  #field_share ORDER BY perc_cluster DESC

		SELECT*
		FROM #cluster_field
		WHERE LR_main_field_id = 2
		ORDER BY ut DESC

		
		SELECT*
		FROM wos_2113.dbo.pub_detail
		WHERE ut = '000302126800006'

 