 
CREATE VIEW VP_ProjIN_InPrjAllocationLot_byWhse AS 

SELECT InvtID, SiteID, WhseLoc, ProjectID, TaskID, LotSerNbr, Sum(QtyAllocated) QtyAllocated
  FROM InPrjAllocationLot
 WHERE SrcType IN ('SH', 'IS','SO', 'RN')   
 GROUP BY InvtID, SiteID, ProjectID, TaskID, WhseLoc, LotSerNbr

