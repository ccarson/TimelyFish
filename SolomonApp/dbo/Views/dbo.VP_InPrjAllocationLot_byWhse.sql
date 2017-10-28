 
CREATE VIEW VP_InPrjAllocationLot_byWhse AS 

--Fixed Demand (Sales Order with Lot Serial Numbers Entered)
SELECT InvtID, SiteID, WhseLoc, ProjectID, TaskID, Sum(QtyAllocated) QtyAllocated
  FROM InPrjAllocationLot
 WHERE SrcType = 'SO'   
 GROUP BY InvtID, SiteID, ProjectID, TaskID, WhseLoc

