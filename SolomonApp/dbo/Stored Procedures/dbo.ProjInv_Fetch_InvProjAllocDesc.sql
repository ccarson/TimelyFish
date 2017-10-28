
CREATE Proc ProjInv_Fetch_InvProjAllocDesc
       @InvtID Varchar(30),
       @SiteID Varchar(10),
       @WhseLoc	Varchar(10),
       @ProjectID VarChar(16),
       @TaskID VarChar(32)


AS

   SELECT i.*
     FROM InvProjAlloc i
    WHERE i.InvtID = @InvtID
      AND i.SiteID = @SiteID
      AND i.WhseLoc = @Whseloc
      AND i.ProjectID = @ProjectID
      AND i.TaskID = @TaskID
      AND i.QtyRemainToIssue > 0
    ORDER BY i.SrcDate Desc


GO
GRANT CONTROL
    ON OBJECT::[dbo].[ProjInv_Fetch_InvProjAllocDesc] TO [MSDSL]
    AS [dbo];

