 
CREATE VIEW VP_ProjIN_InvProjAlloc_byWhse AS 

SELECT InvtID, SiteID, WhseLoc ,ProjectID, TaskID, Sum(QtyRemainToIssue) QtyRemainToIssue 
  FROM INVProjAlloc
 GROUP BY InvtID, SiteID, ProjectID, TaskID, WhseLoc

