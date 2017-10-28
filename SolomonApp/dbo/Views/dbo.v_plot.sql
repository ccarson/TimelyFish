
CREATE VIEW v_plot AS   
  
SELECT InvtID, SiteID, WhseLoc ,ProjectID, TaskID, LotSerNbr, Sum(QtyRemainToIssue) Qty 
  FROM INVProjAllocLot  
 GROUP BY InvtID, SiteID, ProjectID, TaskID, WhseLoc, LotSerNbr  


