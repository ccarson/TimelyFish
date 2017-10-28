 
CREATE VIEW VP_PI_QtyLeftByWhs AS 

SELECT i.InvtID, i.SiteID, i.WhseLoc, i.ProjectID, i.TaskID, (i.QtyRemainToIssue - ISNULL(q.QtyAllocated,0)) ProjInvAvail
  FROM VP_ProjIN_InvProjAlloc_byWhse i LEFT JOIN VP_ProjIN_InPrjAllocation_byWhse q
              ON i.InvtID = q.InvtID
             AND i.SiteID = q.SiteID
             AND i.WhseLoc = q.WhseLoc
             AND i.ProjectID = q.ProjectID
             AND i.TaskID = q.TaskID


