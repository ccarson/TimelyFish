
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 

/****** Object:  View dbo.cfv_PigGroupSummaryClose    Script Date: 2/28/2005 5:03:18 PM ******/
CREATE VIEW cfv_PigGroupSummaryClose
AS
SELECT    pg.ProjectID AS Project, pg.TaskID AS Task, pg.PigGroupID As GroupID, pj.pjt_entity_desc As GroupDesc, pg.PigGenderTypeID As Gender, 
          CONVERT(CHAR(10),st.StartDate,101)As PigStartDate, 
	  CASE
	  WHEN pg.PGStatusID='I' THEN CONVERT(CHAR(10), pg.ActCloseDate,101)
  	  WHEN pg.PGStatusID='T' THEN CONVERT(CHAR(10), pg.EstCloseDate,101) 
	  END AS PigEndDate,
	  CASE
	  WHEN pg.PGStatusID='I' THEN DateDiff(day,st.StartDate, pg.ActCloseDate) 
  	  WHEN pg.PGStatusID='T' THEN DateDiff(day,st.StartDate, pg.EstCloseDate) 
	  ELSE DateDiff(day,st.StartDate, getdate())
	  END As DaysIN,
	  st.TWgt As TotalStartWgt, st.Qty As StartQty, 
          ISNULL(sl.TWgt,'0') As SaleWgt, ISNULL(sl.Qty,'0') As SaleQty,
	  dd.Qty As Mort, CONVERT(NUMERIC(12,2),fp.TotalFeed) As FeedIn, 
	  CONVERT(NUMERIC(12,2),fp.FeedCost) As FeedDollars, 
          ISNULL(te.TWgt,'0') AS TE_Wt, ISNULL(te.Qty,'0') AS TE_Qty, 
	  pg.SiteContactID, sv.ContactName,
          dbo.PGGetPigDays(pg.PigGroupID, pg.EstCloseDate, st.StartDate) As PigDays,
          ISNULL(nr.Qty,'0') As NurQty, ISNULL(nr.TWgt,'0') As NurWgt, ISNULL(op.Qty,'0') As outqty, ISNULL(op.TWgt,'0') As outwgt, ISNULL(op2.Qty,'0') As Inqty, ISNULL(op2.TWgt,'0') As Inwgt
FROM      cftPigGroup pg
JOIN PJPENT pj ON pg.TaskID=pj.pjt_entity
JOIN cftPigProdPhase ph on pg.PigProdPhaseID=ph.PigProdPhaseID
LEFT JOIN cfvCurrentInv iv ON pg.ProjectID=iv.Project AND pg.TaskID=iv.TaskID
LEFT JOIN cfv_GroupFeedChg fp ON pg.ProjectID=fp.Project and pg.TaskID=fp.TaskID
LEFT JOIN cfv_GroupStart st ON pg.ProjectID=st.ProjectID and pg.TaskID=st.TaskID
LEFT JOIN cfv_GroupDead dd ON pg.ProjectID=dd.ProjectID and pg.TaskID=dd.TaskID AND dd.Qty>0
LEFT JOIN cfv_GroupSales sl ON pg.ProjectID=sl.ProjectID and pg.TaskID=sl.TaskID
LEFT JOIN cfvCrtSvcMgrName sv ON pg.SiteContactID=sv.sitecontactid
LEFT JOIN cftPGStatus pst ON pg.PGStatusID=pst.PGStatusID
LEFT JOIN cfvSiteDetail sd ON pg.PigGroupID=sd.PigGroupID
LEFT JOIN cfv_GroupTE te ON pg.TaskID=te.TaskID AND te.Qty>0
LEFT JOIN cfv_GroupCloseNur nr ON pg.TaskID=nr.TaskID
LEFT JOIN cfv_GroupOutput op ON pg.TaskID=op.TaskID AND op.Qty>0
LEFT JOIN cfv_GroupInput op2 ON pg.TaskID=op2.TaskID AND op2.Qty>0
WHERE pg.PGStatusID<>'X' 




 