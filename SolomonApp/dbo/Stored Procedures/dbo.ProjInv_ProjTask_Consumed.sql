 CREATE PROC ProjInv_ProjTask_Consumed
	@InvtID		varchar(30),
	@SiteID		varchar(10),
    @ProjectID  varchar(16),
    @TaskID     varchar(32)
 AS

-- Get All Project Allocated Inventory that all is consumed on Shippers and Issues.
SELECT InvtID, SiteID, ProjectID, TaskID, SUM(QtyAllocated) QtyAllocated
  FROM InPrjAllocation WITH(NOLOCK)
 WHERE InvtID = @InvtID
   AND SiteID = @SiteID
   AND ProjectID = @ProjectID
   AND TaskID = @TaskID
   AND SrcType IN ('IS','SH', 'RN')
 GROUP BY InvtID, SiteID, ProjectID, TaskID

