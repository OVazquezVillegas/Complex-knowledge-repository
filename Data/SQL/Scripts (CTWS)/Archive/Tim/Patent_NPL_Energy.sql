/* PATSTAT NPL WOS links */

/* Y02E  10/30 case (Energy from the sea (wave/salinity)) */

/* PATSTAT NPL WOS */
drop table if exists #tech
SELECT distinct a.appln_id, b.cpc_class_symbol, d.cited_npl_publn_id, e.ut
  into #tech
  FROM patstat_2020autumn..tls201_appln as a 
  join patstat_2020autumn..tls224_appln_cpc as b on a.appln_id=b.appln_id
  join patstat_2020autumn..tls211_pat_publn as c on a.appln_id=c.appln_id
  join patstat_2020autumn..tls212_citation as d on c.pat_publn_id=d.pat_publn_id
  join cwtsdb_patstat..Patstat2020Autumn_WoS as e on d.cited_npl_publn_id=e.npl_publn_id
  where b.cpc_class_symbol = 'Y02E  10/50' and a.appln_filing_year between 2015 and 2019

  /* Cluster selection */
   /* wos clusters */
drop table if exists #cluster_ut_tech
select distinct cluster_id1, a.ut
into #cluster_ut_tech
from wos_2013_classification..clustering as a
join #tech as b on b.ut=a.ut

 /* Energy tech clusters */
 /* MH pubs */
 drop table if exists #cluster_pubs
select cluster_id1, pubs=count(distinct a.ut)
into #cluster_pubs
from wos_2013_classification..clustering as a
join wos_2052..pub as b on a.ut=b.ut
where b.pub_year between 2015 and 2019
group by cluster_id1

drop table if exists #cluster_pubs_tech
select cluster_id1, pubs=count(distinct a.ut)
into #cluster_pubs_tech
from #cluster_ut_tech as a
group by cluster_id1

select distinct a.cluster_id1, cluster_pubs=a.pubs, tech_pubs=isnull(d.pubs,0), perc_tech=isnull(cast(d.pubs as float),0)/cast(a.pubs as float), 
b.label1, b.label2, b.label3, b.label4, b.label5, c.source1,c.source2, c.source3, c.source4
from #cluster_pubs as a
join [wos_2013_classification].[dbo].[labels1] as b on b.cluster_id1=a.cluster_id1
join [wos_2013_classification].[dbo].[sources1] as c on c.cluster_id1=a.cluster_id1
left join #cluster_pubs_tech as d on a.cluster_id1=d.cluster_id1
order by isnull(d.pubs,0) desc
 

 /*
 Y02E10/00
Energy generation through renewable energy sources
 	Y02E10/10		•	
Geothermal energy
 	Y02E10/20		•	
Hydro energy
 	Y02E10/30		•	
Energy from the sea, e.g. using wave energy or salinity gradient
 	Y02E10/40		•	
Solar thermal energy, e.g. solar towers
 	Y02E10/44		•	•	
Heat exchange systems
 	Y02E10/46		•	•	
Conversion of thermal power into mechanical power, e.g. Rankine, Stirling or solar thermal engines
 	Y02E10/47		•	•	
Mountings or tracking
 	Y02E10/50		•	
Photovoltaic [PV] energy
 	Y02E10/52		•	•	
PV systems with concentrators
 	Y02E10/541		•	•	
CuInSe2 material PV cells
 	Y02E10/542		•	•	
Dye sensitized solar cells
 	Y02E10/543		•	•	
Solar cells from Group II-VI materials
 	Y02E10/544		•	•	
Solar cells from Group III-V materials
 	Y02E10/545		•	•	
Microcrystalline silicon PV cells
 	Y02E10/546		•	•	
Polycrystalline silicon PV cells
 	Y02E10/547		•	•	
Monocrystalline silicon PV cells
 	Y02E10/548		•	•	
Amorphous silicon PV cells
 	Y02E10/549		•	•	
Organic PV cells
 	Y02E10/56		•	•	
Power conversion systems, e.g. maximum power point trackers
 	Y02E10/60		•	
Thermal-PV hybrids
 	Y02E10/70		•	
Wind energy
 	Y02E10/72		•	•	
Wind turbines with rotation axis in wind direction
 	Y02E10/727		•	•	
Offshore wind turbines
 	Y02E10/728		•	•	
Onshore wind turbines
 	Y02E10/74		•	•	
Wind turbines with rotation axis perpendicular to the wind direction
 	Y02E10/76		•	•	
Power conversion electric or electronic aspects
*/