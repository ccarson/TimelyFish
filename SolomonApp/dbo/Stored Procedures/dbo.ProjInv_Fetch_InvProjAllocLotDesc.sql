
CREATE Proc ProjInv_Fetch_InvProjAllocLotDesc
       @InvtID Varchar(30),
       @SiteID Varchar(10),
       @WhseLoc	Varchar(10),
       @ProjectID VarChar(16),
       @TaskID VarChar(32),
       @LotSerNbr VarChar(25)

AS

   SELECT i.*
     FROM InvProjAllocLot i
    WHERE i.InvtID = @InvtID
      AND i.SiteID = @SiteID
      AND i.WhseLoc = @Whseloc
      AND i.ProjectID = @ProjectID
      AND i.TaskID = @TaskID
      AND i.LotSerNbr = @LotSerNbr
      AND i.QtyRemainToIssue > 0
    ORDER BY i.SrcDate Desc, LotSerRef


GO
GRANT CONTROL
    ON OBJECT::[dbo].[ProjInv_Fetch_InvProjAllocLotDesc] TO [MSDSL]
    AS [dbo];

