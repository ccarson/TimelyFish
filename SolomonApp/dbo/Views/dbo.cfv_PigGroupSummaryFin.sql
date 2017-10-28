


CREATE        VIEW cfv_PigGroupSummaryFin
AS
SELECT    pj.pe_id05 As Company, ph.PhaseDesc, pst.Description, pg.PigGroupID, pj.pjt_entity_desc As GroupDesc, pgen.Description As GroupGender, CONVERT(CHAR(10),st.StartDate,101)As StartDate, DATEDIFF(day, fp.FirstOrder,st.StartDate) AS PrePig, DateDiff(


day,st.StartDate, getdate()) as DaysIn, 
	  CONVERT(NUMERIC(6,2),st.TWgt/st.Qty) As StartWgt, st.Qty As StartQty, iv.CurrentInv,
	  dd.Qty As Mortality, DATEDIFF(day, fp.FirstOrder,getdate()) AS FeedDays, gs.Source, CONVERT(NUMERIC(12,2),fp.TotalFeed) As FeedIn, 
	  sl.Qty As NoSold, CONVERT(NUMERIC(10,2),sl.TWgt/sl.Qty) As AvgSaleWgt, pg.SiteContactID, sv.ContactName
FROM      cftPigGroup pg
JOIN PJPENT pj ON pg.TaskID=pj.pjt_entity
JOIN cftPigProdPhase ph on pg.PigProdPhaseID=ph.PigProdPhaseID
LEFT JOIN cfvCurrentInv iv ON pg.ProjectID=iv.Project AND pg.TaskID=iv.TaskID
LEFT JOIN cfv_GroupFeed fp ON pg.ProjectID=fp.ProjectID and pg.TaskID=fp.TaskID
LEFT JOIN cfv_GroupStart st ON pg.ProjectID=st.ProjectID and pg.TaskID=st.TaskID
LEFT JOIN cfv_GroupDead dd ON pg.ProjectID=dd.ProjectID and pg.TaskID=dd.TaskID
LEFT JOIN cfv_GroupSales sl ON pg.ProjectID=sl.ProjectID and pg.TaskID=sl.TaskID
LEFT JOIN cfvCrtSvcMgrName sv ON pg.SiteContactID=sv.sitecontactid
LEFT JOIN cftPGStatus pst ON pg.PGStatusID=pst.PGStatusID
LEFT JOIN cftPigGenderType pgen ON pg.PigGenderTypeID=pgen.PigGenderTypeID
LEFT JOIN cfv_GroupSource gs ON pg.PigGroupID=gs.PigGroupID
WHERE pg.PGStatusID IN ('A','F') AND pg.PigSystemID<>'01'




 