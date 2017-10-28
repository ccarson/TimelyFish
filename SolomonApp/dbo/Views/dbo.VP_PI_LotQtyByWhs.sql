 
CREATE VIEW VP_PI_LotQtyByWhs AS 

SELECT i.InvtID, i.SiteID, i.WhseLoc, i.ProjectID, i.TaskID, i.LotSerNbr, (i.QtyRemainToIssue - ISNULL(q.QtyAllocated,0)) ProjInvAvail
  FROM VP_ProjIN_InProjAllocLot_byWhse i LEFT JOIN VP_ProjIN_InPrjAllocationLot_byWhse q
              ON i.InvtID = q.InvtID
             AND i.SiteID = q.SiteID
             AND i.WhseLoc = q.WhseLoc
             AND i.ProjectID = q.ProjectID
             AND i.TaskID = q.TaskID
             AND i.LotSerNbr = q.LotSerNbr


