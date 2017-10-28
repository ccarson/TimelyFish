 
CREATE VIEW VP_PI_QtyRemaining AS 

SELECT i.InvtID, i.SiteID, i.ProjectID, i.TaskID, (i.QtyRemainToIssue - ISNULL(q.QtyAllocated,0)) ProjInvAvail
  FROM VP_ProjIN_InvProjAlloc i LEFT JOIN VP_ProjIN_InPrjAllocation q
              ON i.InvtID = q.InvtID
             AND i.SiteID = q.SiteID
             AND i.ProjectID = q.ProjectID
             AND i.TaskID = q.TaskID  


