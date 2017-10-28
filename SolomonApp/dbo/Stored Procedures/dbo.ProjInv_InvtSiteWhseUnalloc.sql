 CREATE PROC ProjInv_InvtSiteWhseUnalloc
	@InvtID		varchar(30),
	@SiteID		varchar(10),
    @WhseLoc    varchar(10)
    
 AS

   --Get All Project Allocated Inventory for this SiteId, 
   SELECT Sum(QtyRemaintoIssue) QtyRemainToIssue 
     FROM InvProjAlloc WITH(NOLOCK)
    WHERE InvtID = @InvtID
      AND SiteID = @SiteID
      AND WhseLoc = @WhseLoc
     GROUP BY InvtID, SiteID, WhseLoc 

