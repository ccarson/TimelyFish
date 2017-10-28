
CREATE Proc ProjInv_Fetch_InvProjAlloc_ForLots
       @InvtID Varchar(30),
       @SiteID Varchar(10),
       @WhseLoc	Varchar(10),
       @ProjectID VarChar(16),
       @TaskID VarChar(32),
       @LotSerNbr VarChar(25)

AS

   SELECT DISTINCT a.SrcNbr, a.SrcLineRef, a.SrcType, a.SrcDate, a.QtyRemainToIssue  
     FROM InvProjAlloc a WITH(NOLOCK) JOIN InPrjAllocLotHist i WITH(NOLOCK) 
                           ON a.SrcNbr = i.SrcNbr
                          AND a.SrcLineRef = i.SrcLineRef
                          AND a.SrcType = i.SrcType
                          AND a.InvtID = i.InvtID
                          AND a.SiteID	= i.SiteID 
                          AND a.WhseLoc = i.WhseLoc                     
    WHERE i.InvtID = @InvtID  
      AND i.SiteID = @SiteID  
      AND i.WhseLoc = @Whseloc  
      AND i.LotSerNbr = @LotSerNbr  
      AND a.ProjectID = @ProjectID  
      AND a.TaskID = @TaskID  
      AND a.QtyRemainToIssue > 0  



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ProjInv_Fetch_InvProjAlloc_ForLots] TO [MSDSL]
    AS [dbo];

