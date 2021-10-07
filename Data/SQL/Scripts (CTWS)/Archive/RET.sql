/* PATSTAT NPL WOS links */
  /* Y02E  10/20 case (Hydropower) */ 
 /* NUTS codes */
 /* Assigned NUTS codes (0) // For period 1991-1999 (2) */

SELECT distinct a.appln_id, b.cpc_class_symbol, d.cited_npl_publn_id, e.ut, nuts2=left(h.[nuts_level3_code],4)
  FROM patstat_2020autumn..tls201_appln as a 
  join patstat_2020autumn..tls224_appln_cpc as b on a.appln_id=b.appln_id
  join patstat_2020autumn..tls211_pat_publn as c on a.appln_id=c.appln_id
  join patstat_2020autumn..tls212_citation as d on c.pat_publn_id=d.pat_publn_id
  join cwtsdb_patstat..Patstat2020Autumn_WoS as e on d.cited_npl_publn_id=e.npl_publn_id
  join wos_2052..pub_affiliation as f on e.ut=f.ut
  join wos_2052_geolocation..pub_affiliation_city_geolocation as g on f.ut=g.ut and f.affiliation_seq=g.affiliation_seq
  join wos_2052_geolocation..city_geolocation as h on g.city_geolocation_id=h.city_geolocation_id
  join wos_2052.dbo.pub_detail as i on i.ut = e.ut
  where b.cpc_class_symbol = 'Y02E  10/20' and i.pub_year between 1991 and 1999 and left(h.[nuts_level3_code],4) != 'NULL'

 /* Assigned NUTS codes (0) // For period 2000-2008 (49) */

SELECT distinct a.appln_id, b.cpc_class_symbol, d.cited_npl_publn_id, e.ut, nuts2=left(h.[nuts_level3_code],4)
  FROM patstat_2020autumn..tls201_appln as a 
  join patstat_2020autumn..tls224_appln_cpc as b on a.appln_id=b.appln_id
  join patstat_2020autumn..tls211_pat_publn as c on a.appln_id=c.appln_id
  join patstat_2020autumn..tls212_citation as d on c.pat_publn_id=d.pat_publn_id
  join cwtsdb_patstat..Patstat2020Autumn_WoS as e on d.cited_npl_publn_id=e.npl_publn_id
  join wos_2052..pub_affiliation as f on e.ut=f.ut
  join wos_2052_geolocation..pub_affiliation_city_geolocation as g on f.ut=g.ut and f.affiliation_seq=g.affiliation_seq
  join wos_2052_geolocation..city_geolocation as h on g.city_geolocation_id=h.city_geolocation_id
  join wos_2052.dbo.pub_detail as i on i.ut = e.ut
  where b.cpc_class_symbol = 'Y02E  10/20' and i.pub_year between 2000 and 2008 and left(h.[nuts_level3_code],4) != 'NULL'

  /* Assigned NUTS codes (0) // For period 2009-2018 (182) */

SELECT distinct a.appln_id, b.cpc_class_symbol, d.cited_npl_publn_id, e.ut, nuts2=left(h.[nuts_level3_code],4)
  FROM patstat_2020autumn..tls201_appln as a 
  join patstat_2020autumn..tls224_appln_cpc as b on a.appln_id=b.appln_id
  join patstat_2020autumn..tls211_pat_publn as c on a.appln_id=c.appln_id
  join patstat_2020autumn..tls212_citation as d on c.pat_publn_id=d.pat_publn_id
  join cwtsdb_patstat..Patstat2020Autumn_WoS as e on d.cited_npl_publn_id=e.npl_publn_id
  join wos_2052..pub_affiliation as f on e.ut=f.ut
  join wos_2052_geolocation..pub_affiliation_city_geolocation as g on f.ut=g.ut and f.affiliation_seq=g.affiliation_seq
  join wos_2052_geolocation..city_geolocation as h on g.city_geolocation_id=h.city_geolocation_id
  join wos_2052.dbo.pub_detail as i on i.ut = e.ut
  where b.cpc_class_symbol = 'Y02E  10/20' and i.pub_year between 2009 and 2018 and left(h.[nuts_level3_code],4) != 'NULL'

  /* Y02E  10/10 case (Geothermal) */ 
 /* NUTS codes */
 /* Assigned NUTS codes (0) // For period 1991-1999 (0) */

SELECT distinct a.appln_id, b.cpc_class_symbol, d.cited_npl_publn_id, e.ut, nuts2=left(h.[nuts_level3_code],4)
  FROM patstat_2020autumn..tls201_appln as a 
  join patstat_2020autumn..tls224_appln_cpc as b on a.appln_id=b.appln_id
  join patstat_2020autumn..tls211_pat_publn as c on a.appln_id=c.appln_id
  join patstat_2020autumn..tls212_citation as d on c.pat_publn_id=d.pat_publn_id
  join cwtsdb_patstat..Patstat2020Autumn_WoS as e on d.cited_npl_publn_id=e.npl_publn_id
  join wos_2052..pub_affiliation as f on e.ut=f.ut
  join wos_2052_geolocation..pub_affiliation_city_geolocation as g on f.ut=g.ut and f.affiliation_seq=g.affiliation_seq
  join wos_2052_geolocation..city_geolocation as h on g.city_geolocation_id=h.city_geolocation_id
  join wos_2052.dbo.pub_detail as i on i.ut = e.ut
  where b.cpc_class_symbol = 'Y02E  10/10' and i.pub_year between 1991 and 1999 and left(h.[nuts_level3_code],4) != 'NULL'

 /* Assigned NUTS codes (0) // For period 2000-2008 (69) */

SELECT distinct a.appln_id, b.cpc_class_symbol, d.cited_npl_publn_id, e.ut, nuts2=left(h.[nuts_level3_code],4)
  FROM patstat_2020autumn..tls201_appln as a 
  join patstat_2020autumn..tls224_appln_cpc as b on a.appln_id=b.appln_id
  join patstat_2020autumn..tls211_pat_publn as c on a.appln_id=c.appln_id
  join patstat_2020autumn..tls212_citation as d on c.pat_publn_id=d.pat_publn_id
  join cwtsdb_patstat..Patstat2020Autumn_WoS as e on d.cited_npl_publn_id=e.npl_publn_id
  join wos_2052..pub_affiliation as f on e.ut=f.ut
  join wos_2052_geolocation..pub_affiliation_city_geolocation as g on f.ut=g.ut and f.affiliation_seq=g.affiliation_seq
  join wos_2052_geolocation..city_geolocation as h on g.city_geolocation_id=h.city_geolocation_id
  join wos_2052.dbo.pub_detail as i on i.ut = e.ut
  where b.cpc_class_symbol = 'Y02E  10/10' and i.pub_year between 2000 and 2008 and left(h.[nuts_level3_code],4) != 'NULL'

  /* Assigned NUTS codes (0) // For period 2009-2018 (100) */

SELECT distinct a.appln_id, b.cpc_class_symbol, d.cited_npl_publn_id, e.ut, nuts2=left(h.[nuts_level3_code],4)
  FROM patstat_2020autumn..tls201_appln as a 
  join patstat_2020autumn..tls224_appln_cpc as b on a.appln_id=b.appln_id
  join patstat_2020autumn..tls211_pat_publn as c on a.appln_id=c.appln_id
  join patstat_2020autumn..tls212_citation as d on c.pat_publn_id=d.pat_publn_id
  join cwtsdb_patstat..Patstat2020Autumn_WoS as e on d.cited_npl_publn_id=e.npl_publn_id
  join wos_2052..pub_affiliation as f on e.ut=f.ut
  join wos_2052_geolocation..pub_affiliation_city_geolocation as g on f.ut=g.ut and f.affiliation_seq=g.affiliation_seq
  join wos_2052_geolocation..city_geolocation as h on g.city_geolocation_id=h.city_geolocation_id
  join wos_2052.dbo.pub_detail as i on i.ut = e.ut
  where b.cpc_class_symbol = 'Y02E  10/10' and i.pub_year between 2008 and 2018 and left(h.[nuts_level3_code],4) != 'NULL'


  
/* Y02E  10/50 case (Solar PV) */ 
 /* NUTS codes */
 /* Assigned NUTS codes (0) // For period 1991-1999 (7) */

SELECT distinct a.appln_id, b.cpc_class_symbol, d.cited_npl_publn_id, e.ut, nuts2=left(h.[nuts_level3_code],4)
  FROM patstat_2020autumn..tls201_appln as a 
  join patstat_2020autumn..tls224_appln_cpc as b on a.appln_id=b.appln_id
  join patstat_2020autumn..tls211_pat_publn as c on a.appln_id=c.appln_id
  join patstat_2020autumn..tls212_citation as d on c.pat_publn_id=d.pat_publn_id
  join cwtsdb_patstat..Patstat2020Autumn_WoS as e on d.cited_npl_publn_id=e.npl_publn_id
  join wos_2052..pub_affiliation as f on e.ut=f.ut
  join wos_2052_geolocation..pub_affiliation_city_geolocation as g on f.ut=g.ut and f.affiliation_seq=g.affiliation_seq
  join wos_2052_geolocation..city_geolocation as h on g.city_geolocation_id=h.city_geolocation_id
  join wos_2052.dbo.pub_detail as i on i.ut = e.ut
  where b.cpc_class_symbol = 'Y02E  10/50' and i.pub_year between 1991 and 1999 and left(h.[nuts_level3_code],4) != 'NULL'

 /* Assigned NUTS codes (0) // For period 2000-2008 (534) */

SELECT distinct a.appln_id, b.cpc_class_symbol, d.cited_npl_publn_id, e.ut, nuts2=left(h.[nuts_level3_code],4)
  FROM patstat_2020autumn..tls201_appln as a 
  join patstat_2020autumn..tls224_appln_cpc as b on a.appln_id=b.appln_id
  join patstat_2020autumn..tls211_pat_publn as c on a.appln_id=c.appln_id
  join patstat_2020autumn..tls212_citation as d on c.pat_publn_id=d.pat_publn_id
  join cwtsdb_patstat..Patstat2020Autumn_WoS as e on d.cited_npl_publn_id=e.npl_publn_id
  join wos_2052..pub_affiliation as f on e.ut=f.ut
  join wos_2052_geolocation..pub_affiliation_city_geolocation as g on f.ut=g.ut and f.affiliation_seq=g.affiliation_seq
  join wos_2052_geolocation..city_geolocation as h on g.city_geolocation_id=h.city_geolocation_id
  join wos_2052.dbo.pub_detail as i on i.ut = e.ut
  where b.cpc_class_symbol = 'Y02E  10/50' and i.pub_year between 2000 and 2008 and left(h.[nuts_level3_code],4) != 'NULL'

  /* Assigned NUTS codes (0) // For period 2009-2018 (63) */

SELECT distinct a.appln_id, b.cpc_class_symbol, d.cited_npl_publn_id, e.ut, nuts2=left(h.[nuts_level3_code],4)
  FROM patstat_2020autumn..tls201_appln as a 
  join patstat_2020autumn..tls224_appln_cpc as b on a.appln_id=b.appln_id
  join patstat_2020autumn..tls211_pat_publn as c on a.appln_id=c.appln_id
  join patstat_2020autumn..tls212_citation as d on c.pat_publn_id=d.pat_publn_id
  join cwtsdb_patstat..Patstat2020Autumn_WoS as e on d.cited_npl_publn_id=e.npl_publn_id
  join wos_2052..pub_affiliation as f on e.ut=f.ut
  join wos_2052_geolocation..pub_affiliation_city_geolocation as g on f.ut=g.ut and f.affiliation_seq=g.affiliation_seq
  join wos_2052_geolocation..city_geolocation as h on g.city_geolocation_id=h.city_geolocation_id
  join wos_2052.dbo.pub_detail as i on i.ut = e.ut
  where b.cpc_class_symbol = 'Y02E  10/50' and i.pub_year between 1999 and 2018 and left(h.[nuts_level3_code],4) != 'NULL'



  

/* Y02E  10/70 case (Wind power) */ 
 /* NUTS codes */
 /* Assigned NUTS codes (0) // For period 1991-1999 (0) */

SELECT distinct a.appln_id, b.cpc_class_symbol, d.cited_npl_publn_id, e.ut, nuts2=left(h.[nuts_level3_code],4)
  FROM patstat_2020autumn..tls201_appln as a 
  join patstat_2020autumn..tls224_appln_cpc as b on a.appln_id=b.appln_id
  join patstat_2020autumn..tls211_pat_publn as c on a.appln_id=c.appln_id
  join patstat_2020autumn..tls212_citation as d on c.pat_publn_id=d.pat_publn_id
  join cwtsdb_patstat..Patstat2020Autumn_WoS as e on d.cited_npl_publn_id=e.npl_publn_id
  join wos_2052..pub_affiliation as f on e.ut=f.ut
  join wos_2052_geolocation..pub_affiliation_city_geolocation as g on f.ut=g.ut and f.affiliation_seq=g.affiliation_seq
 join wos_2052_geolocation..city_geolocation as h on g.city_geolocation_id=h.city_geolocation_id
  join wos_2052.dbo.pub_detail as i on i.ut = e.ut
  where b.cpc_class_symbol = 'Y02E  10/70' and i.pub_year between 1991 and 1999 and left(h.[nuts_level3_code],4) != 'NULL'

 /* Assigned NUTS codes (0) // For period 2000-2008 (16) */

SELECT distinct a.appln_id, b.cpc_class_symbol, d.cited_npl_publn_id, e.ut, nuts2=left(h.[nuts_level3_code],4)
  FROM patstat_2020autumn..tls201_appln as a 
  join patstat_2020autumn..tls224_appln_cpc as b on a.appln_id=b.appln_id
  join patstat_2020autumn..tls211_pat_publn as c on a.appln_id=c.appln_id
  join patstat_2020autumn..tls212_citation as d on c.pat_publn_id=d.pat_publn_id
  join cwtsdb_patstat..Patstat2020Autumn_WoS as e on d.cited_npl_publn_id=e.npl_publn_id
  join wos_2052..pub_affiliation as f on e.ut=f.ut
  join wos_2052_geolocation..pub_affiliation_city_geolocation as g on f.ut=g.ut and f.affiliation_seq=g.affiliation_seq
  join wos_2052_geolocation..city_geolocation as h on g.city_geolocation_id=h.city_geolocation_id
  join wos_2052.dbo.pub_detail as i on i.ut = e.ut
  where b.cpc_class_symbol = 'Y02E  10/70' and i.pub_year between 2000 and 2008 and left(h.[nuts_level3_code],4) != 'NULL'

  /* Assigned NUTS codes (0) // For period 2009-2018 (41) */

SELECT distinct a.appln_id, b.cpc_class_symbol, d.cited_npl_publn_id, e.ut, nuts2=left(h.[nuts_level3_code],4)
  FROM patstat_2020autumn..tls201_appln as a 
  join patstat_2020autumn..tls224_appln_cpc as b on a.appln_id=b.appln_id
  join patstat_2020autumn..tls211_pat_publn as c on a.appln_id=c.appln_id
  join patstat_2020autumn..tls212_citation as d on c.pat_publn_id=d.pat_publn_id
  join cwtsdb_patstat..Patstat2020Autumn_WoS as e on d.cited_npl_publn_id=e.npl_publn_id
  join wos_2052..pub_affiliation as f on e.ut=f.ut
  join wos_2052_geolocation..pub_affiliation_city_geolocation as g on f.ut=g.ut and f.affiliation_seq=g.affiliation_seq
  join wos_2052_geolocation..city_geolocation as h on g.city_geolocation_id=h.city_geolocation_id
  join wos_2052.dbo.pub_detail as i on i.ut = e.ut
  where b.cpc_class_symbol = 'Y02E  10/70' and i.pub_year between 2009 and 2018 and left(h.[nuts_level3_code],4) != 'NULL'



  

/* Y02E  10/40 case (Solar thermal) */ 
 /* NUTS codes */
 /* Assigned NUTS codes (0) // For period 1991-1999 (15) */

SELECT distinct a.appln_id, b.cpc_class_symbol, d.cited_npl_publn_id, e.ut, nuts2=left(h.[nuts_level3_code],4)
  FROM patstat_2020autumn..tls201_appln as a 
  join patstat_2020autumn..tls224_appln_cpc as b on a.appln_id=b.appln_id
  join patstat_2020autumn..tls211_pat_publn as c on a.appln_id=c.appln_id
  join patstat_2020autumn..tls212_citation as d on c.pat_publn_id=d.pat_publn_id
  join cwtsdb_patstat..Patstat2020Autumn_WoS as e on d.cited_npl_publn_id=e.npl_publn_id
  join wos_2052..pub_affiliation as f on e.ut=f.ut
  join wos_2052_geolocation..pub_affiliation_city_geolocation as g on f.ut=g.ut and f.affiliation_seq=g.affiliation_seq
 join wos_2052_geolocation..city_geolocation as h on g.city_geolocation_id=h.city_geolocation_id
  join wos_2052.dbo.pub_detail as i on i.ut = e.ut
  where b.cpc_class_symbol = 'Y02E  10/40' and i.pub_year between 1991 and 1999 and left(h.[nuts_level3_code],4) != 'NULL'

 /* Assigned NUTS codes (0) // For period 2000-2008 (86) */

SELECT distinct a.appln_id, b.cpc_class_symbol, d.cited_npl_publn_id, e.ut, nuts2=left(h.[nuts_level3_code],4)
  FROM patstat_2020autumn..tls201_appln as a 
  join patstat_2020autumn..tls224_appln_cpc as b on a.appln_id=b.appln_id
  join patstat_2020autumn..tls211_pat_publn as c on a.appln_id=c.appln_id
  join patstat_2020autumn..tls212_citation as d on c.pat_publn_id=d.pat_publn_id
  join cwtsdb_patstat..Patstat2020Autumn_WoS as e on d.cited_npl_publn_id=e.npl_publn_id
  join wos_2052..pub_affiliation as f on e.ut=f.ut
  join wos_2052_geolocation..pub_affiliation_city_geolocation as g on f.ut=g.ut and f.affiliation_seq=g.affiliation_seq
  join wos_2052_geolocation..city_geolocation as h on g.city_geolocation_id=h.city_geolocation_id
  join wos_2052.dbo.pub_detail as i on i.ut = e.ut
  where b.cpc_class_symbol = 'Y02E  10/40' and i.pub_year between 2000 and 2008 and left(h.[nuts_level3_code],4) != 'NULL'


  /* Assigned NUTS codes (0) // For period 2009-2018 (564) */

SELECT distinct a.appln_id, b.cpc_class_symbol, d.cited_npl_publn_id, e.ut, nuts2=left(h.[nuts_level3_code],4)
  FROM patstat_2020autumn..tls201_appln as a 
  join patstat_2020autumn..tls224_appln_cpc as b on a.appln_id=b.appln_id
  join patstat_2020autumn..tls211_pat_publn as c on a.appln_id=c.appln_id
  join patstat_2020autumn..tls212_citation as d on c.pat_publn_id=d.pat_publn_id
  join cwtsdb_patstat..Patstat2020Autumn_WoS as e on d.cited_npl_publn_id=e.npl_publn_id
  join wos_2052..pub_affiliation as f on e.ut=f.ut
  join wos_2052_geolocation..pub_affiliation_city_geolocation as g on f.ut=g.ut and f.affiliation_seq=g.affiliation_seq
 join wos_2052_geolocation..city_geolocation as h on g.city_geolocation_id=h.city_geolocation_id
  join wos_2052.dbo.pub_detail as i on i.ut = e.ut
  where b.cpc_class_symbol = 'Y02E  10/40' and i.pub_year between 2009 and 2018 and left(h.[nuts_level3_code],4) != 'NULL'








/* Y02E  10/30 case (Energy from the sea (wave/salinity)) */ 
 /* NUTS codes */
 /* Assigned NUTS codes (0) // For period 1991-1999 (0) */

SELECT distinct a.appln_id, b.cpc_class_symbol, d.cited_npl_publn_id, e.ut, nuts2=left(h.[nuts_level3_code],4)
  FROM patstat_2020autumn..tls201_appln as a 
  join patstat_2020autumn..tls224_appln_cpc as b on a.appln_id=b.appln_id
  join patstat_2020autumn..tls211_pat_publn as c on a.appln_id=c.appln_id
  join patstat_2020autumn..tls212_citation as d on c.pat_publn_id=d.pat_publn_id
  join cwtsdb_patstat..Patstat2020Autumn_WoS as e on d.cited_npl_publn_id=e.npl_publn_id
  join wos_2052..pub_affiliation as f on e.ut=f.ut
  join wos_2052_geolocation..pub_affiliation_city_geolocation as g on f.ut=g.ut and f.affiliation_seq=g.affiliation_seq
  join wos_2052_geolocation..city_geolocation as h on g.city_geolocation_id=h.city_geolocation_id
  join wos_2052.dbo.pub_detail as i on i.ut = e.ut
  where b.cpc_class_symbol = 'Y02E  10/30' and i.pub_year between 1991 and 1999 and left(h.[nuts_level3_code],4) != 'NULL'


 /* Assigned NUTS codes (0) // For period 2000-2008 (63) */

SELECT distinct a.appln_id, b.cpc_class_symbol, d.cited_npl_publn_id, e.ut, nuts2=left(h.[nuts_level3_code],4)
  FROM patstat_2020autumn..tls201_appln as a 
  join patstat_2020autumn..tls224_appln_cpc as b on a.appln_id=b.appln_id
  join patstat_2020autumn..tls211_pat_publn as c on a.appln_id=c.appln_id
  join patstat_2020autumn..tls212_citation as d on c.pat_publn_id=d.pat_publn_id
  join cwtsdb_patstat..Patstat2020Autumn_WoS as e on d.cited_npl_publn_id=e.npl_publn_id
  join wos_2052..pub_affiliation as f on e.ut=f.ut
  join wos_2052_geolocation..pub_affiliation_city_geolocation as g on f.ut=g.ut and f.affiliation_seq=g.affiliation_seq
  join wos_2052_geolocation..city_geolocation as h on g.city_geolocation_id=h.city_geolocation_id
  join wos_2052.dbo.pub_detail as i on i.ut = e.ut
  where b.cpc_class_symbol = 'Y02E  10/30' and i.pub_year between 2000 and 2008 and left(h.[nuts_level3_code],4) != 'NULL'

  /* Assigned NUTS codes (0) // For period 2009-2018 (63) */

SELECT distinct a.appln_id, b.cpc_class_symbol, d.cited_npl_publn_id, e.ut, nuts2=left(h.[nuts_level3_code],4)
  FROM patstat_2020autumn..tls201_appln as a 
  join patstat_2020autumn..tls224_appln_cpc as b on a.appln_id=b.appln_id
  join patstat_2020autumn..tls211_pat_publn as c on a.appln_id=c.appln_id
  join patstat_2020autumn..tls212_citation as d on c.pat_publn_id=d.pat_publn_id
  join cwtsdb_patstat..Patstat2020Autumn_WoS as e on d.cited_npl_publn_id=e.npl_publn_id
  join wos_2052..pub_affiliation as f on e.ut=f.ut
  join wos_2052_geolocation..pub_affiliation_city_geolocation as g on f.ut=g.ut and f.affiliation_seq=g.affiliation_seq
  join wos_2052_geolocation..city_geolocation as h on g.city_geolocation_id=h.city_geolocation_id
  join wos_2052.dbo.pub_detail as i on i.ut = e.ut
  where b.cpc_class_symbol = 'Y02E  10/30' and i.pub_year between 1991 and 2018 and left(h.[nuts_level3_code],4) != 'NULL'


