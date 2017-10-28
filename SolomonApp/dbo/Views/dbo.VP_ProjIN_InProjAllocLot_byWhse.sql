 
CREATE VIEW VP_ProjIN_InProjAllocLot_byWhse AS 

SELECT InvtID, SiteID, WhseLoc ,ProjectID, TaskID, LotSerNbr, Sum(QtyRemainToIssue) QtyRemainToIssue 
  FROM INVProjAllocLot
 GROUP BY InvtID, SiteID, ProjectID, TaskID, WhseLoc, LotSerNbr

