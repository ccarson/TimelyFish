 
CREATE VIEW VP_ProjIN_InPrjAllocation AS 

SELECT InvtID, SiteID, ProjectID, TaskID, Sum(QtyAllocated) QtyAllocated
  FROM InPrjAllocation
 WHERE SrcType IN ('SH', 'IS', 'RN')   
 GROUP BY InvtID, SiteID, ProjectID, TaskID

