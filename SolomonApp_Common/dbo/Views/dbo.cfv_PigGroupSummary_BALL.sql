
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
/****** Sue Matter:  Used on CF663 Active Site Report    Script Date: 11/19/2004 2:10:22 PM ******/
CREATE       VIEW cfv_PigGroupSummary_BALL
AS
SELECT    pj.pe_id05 As Company, ph.PhaseDesc, sd.FacilityType, pst.Description, pg.PigGroupID As GroupID, pj.pjt_entity_desc As GroupDesc, pg.PigGenderTypeID As Gender, CONVERT(CHAR(10),st.StartDate,101)As StartDate, DATEDIFF(day, fp.FirstOrder,st.StartDate) AS PrePig, DateDiff(day,st.StartDate, getdate()) as DaysIn, 
	  CONVERT(NUMERIC(6,2),st.TWgt/st.Qty) As StartWgt, st.Qty As StartQty, iv.CurrentInv,
	  dd.Qty As Mortality, DATEDIFF(day, fp.FirstOrder,getdate()) AS FeedDays, CONVERT(NUMERIC(12,2),fp.TotalFeed) As FeedIn, CONVERT(CHAR(10),fp.LastOrder,101)As LastFeed, fp.LastRation,
	  sl.Qty As NoSold, CONVERT(NUMERIC(10,2),sl.TWgt/sl.Qty) As AvgSaleWgt, pg.SiteContactID, sv.ContactName
FROM      cftPigGroup pg
JOIN PJPENT pj ON pg.TaskID=pj.pjt_entity
JOIN cftPigProdPhase ph on pg.PigProdPhaseID=ph.PigProdPhaseID
LEFT JOIN cfvCurrentInv iv ON pg.ProjectID=iv.Project AND pg.TaskID=iv.TaskID
LEFT JOIN cfv_GroupFeed fp ON pg.ProjectID=fp.ProjectID and pg.TaskID=fp.TaskID
LEFT JOIN cfv_GroupStart st ON pg.ProjectID=st.ProjectID and pg.TaskID=st.TaskID AND st.Qty>0
LEFT JOIN cfv_GroupDead dd ON pg.ProjectID=dd.ProjectID and pg.TaskID=dd.TaskID
LEFT JOIN cfv_GroupSales sl ON pg.ProjectID=sl.ProjectID and pg.TaskID=sl.TaskID
LEFT JOIN cfvCrtSvcMgrName sv ON pg.SiteContactID=sv.sitecontactid
LEFT JOIN cftPGStatus pst ON pg.PGStatusID=pst.PGStatusID
LEFT JOIN cfvSiteDetail sd ON pg.PigGroupID=sd.PigGroupID





 