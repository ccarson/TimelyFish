 
CREATE VIEW VP_ProjIN_InPrjAllocation_byWhse AS 

SELECT InvtID, SiteID, WhseLoc, ProjectID, TaskID, Sum(QtyAllocated) QtyAllocated
  FROM InPrjAllocation
 WHERE SrcType IN ('SH', 'IS', 'RN')   
 GROUP BY InvtID, SiteID, ProjectID, TaskID, WhseLoc

