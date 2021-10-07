/* PATSTAT NPL WOS links */

/* Y02E  10/30 case (Energy from the sea (wave/salinity)) */
/* PATSTAT NPL (2911) */
SELECT distinct a.appln_id, b.cpc_class_symbol, d.cited_npl_publn_id
  FROM patstat_2020autumn..tls201_appln as a 
  join patstat_2020autumn..tls224_appln_cpc as b on a.appln_id=b.appln_id
  join patstat_2020autumn..tls211_pat_publn as c on a.appln_id=c.appln_id
  join patstat_2020autumn..tls212_citation as d on c.pat_publn_id=d.pat_publn_id
  where b.cpc_class_symbol = 'Y02E  10/30' and a.appln_filing_year between 2015 and 2019 and d.cited_npl_publn_id != 0

/* PATSTAT NPL WOS (171) */
drop table if exists #ocean
SELECT distinct a.appln_id, b.cpc_class_symbol, d.cited_npl_publn_id, e.ut
  into #ocean
  FROM patstat_2020autumn..tls201_appln as a 
  join patstat_2020autumn..tls224_appln_cpc as b on a.appln_id=b.appln_id
  join patstat_2020autumn..tls211_pat_publn as c on a.appln_id=c.appln_id
  join patstat_2020autumn..tls212_citation as d on c.pat_publn_id=d.pat_publn_id
  join cwtsdb_patstat..Patstat2020Autumn_WoS as e on d.cited_npl_publn_id=e.npl_publn_id
  where b.cpc_class_symbol = 'Y02E  10/30' and a.appln_filing_year between 2015 and 2018

  
 /* NUTS codes */
 /* Assigned NUTS codes (118) // For period 2010-2014 (124) */

SELECT distinct a.appln_id, b.cpc_class_symbol, d.cited_npl_publn_id, e.ut, nuts2=left(h.[nuts_level3_code],4)
  FROM patstat_2020autumn..tls201_appln as a 
  join patstat_2020autumn..tls224_appln_cpc as b on a.appln_id=b.appln_id
  join patstat_2020autumn..tls211_pat_publn as c on a.appln_id=c.appln_id
  join patstat_2020autumn..tls212_citation as d on c.pat_publn_id=d.pat_publn_id
  join cwtsdb_patstat..Patstat2020Autumn_WoS as e on d.cited_npl_publn_id=e.npl_publn_id
  join wos_2052..pub_affiliation as f on e.ut=f.ut
  join wos_2052_geolocation..pub_affiliation_city_geolocation as g on f.ut=g.ut and f.affiliation_seq=g.affiliation_seq
  join wos_2052_geolocation..city_geolocation as h on g.city_geolocation_id=h.city_geolocation_id
  where b.cpc_class_symbol = 'Y02E  10/30' and a.appln_filing_year between 2015 and 2019 and left(h.[nuts_level3_code],4) != 'NULL'
  

  select distinct a.cluster_id1, a.ut
from #cluster_ut as a
join #ocean as b on a.ut=b.ut