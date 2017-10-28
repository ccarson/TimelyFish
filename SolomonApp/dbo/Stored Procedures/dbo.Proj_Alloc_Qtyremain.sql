Create PROC Proj_Alloc_Qtyremain
    @InvtID	varchar(30),
    @SiteID	varchar(10),
    @WhseLoc    varchar(10),
    @ProjectID  varchar(16),
    @TaskID     varchar(32)
 AS

   --Get All Project Allocated Inventory for this SiteId, 
   SELECT Sum(ISNULL(QtyRemaintoIssue,0))  
     FROM InvProjAlloc WITH(NOLOCK)
    WHERE InvtID = @InvtID
      AND SiteID = @SiteID
      AND WhseLoc = @WhseLoc
      AND ProjectID = @ProjectID
      AND TaskID = @TaskID
      
