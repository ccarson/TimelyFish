 
CREATE VIEW VP_ProjIN_InvProjAlloc AS 

SELECT CpnyID, InvtID, SiteID, ProjectID, TaskID, Sum(QtyRemainToIssue) QtyRemainToIssue 
  FROM INVProjAlloc
 GROUP BY CpnyID,InvtID, SiteID, ProjectID, TaskID

