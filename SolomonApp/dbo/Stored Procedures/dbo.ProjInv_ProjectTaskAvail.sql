 CREATE PROC ProjInv_ProjectTaskAvail
	@InvtID		varchar(30),
	@SiteID		varchar(10),
    @ProjectID  varchar(16),
    @TaskID     varchar(32)
 AS

   --Get All Project Allocated Inventory for this SiteId, 
   SELECT InvtID, SiteID, ProjectID, TaskID, Sum(QtyRemaintoIssue) QtyRemainToIssue 
     FROM InvProjAlloc WITH(NOLOCK)
    WHERE InvtID = @InvtID
      AND SiteID = @SiteID
      AND ProjectID = @ProjectID
      AND TaskID = @TaskID
    GROUP BY InvtID, SiteID, ProjectID, TaskID 

