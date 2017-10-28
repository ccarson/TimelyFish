 CREATE PROC ProjectInventory_Issue
	@InvtID		varchar(30),
	@SiteID		varchar(10)
 AS

  SELECT InvtID, SiteID, SrcType, SUM(QtyAllocated) QtyAllocated 
    FROM InPrjAllocation WITH(NOLOCK)
   WHERE InvtID = @InvtID
     AND SiteID = @SiteID
     AND SrcType IN ('IS')
   GROUP BY InvtID, SiteID, SrcType

