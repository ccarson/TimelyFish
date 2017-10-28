
CREATE Proc ProjInv_Fetch_InvProjAllocLotRtn
       @InvtID Varchar(30),
       @SiteID Varchar(10),
       @WhseLoc	Varchar(10),
       @ProjectID VarChar(16),
       @TaskID VarChar(32),
       @LotSerNbr VarChar(25),
       @Srcnbr VarChar(15),
       @SrcLineRef VarChar(5)
AS

   SELECT i.*
     FROM InvProjAllocLot i With(NOLOCK)
       JOIN POTran p With (NOLOCK)
         ON p.RcptNbrOrig = '000008' --@Srcnbr
        AND p.RcptLineRefOrig = '00007'--@SrcLineRef
        AND p.TranType = 'X' -- Return
        AND p.PurchaseType IN ('PI', 'PS') -- Goods for Project Inventory, and Goods for Project Sales Order
    WHERE i.InvtID = @InvtID
      AND i.SiteID = @SiteID
      AND i.WhseLoc = @Whseloc
      AND i.ProjectID = @ProjectID
      AND i.TaskID = @TaskID
      AND i.LotSerNbr = @LotSerNbr
      AND i.SrcNbr = @Srcnbr
   AND i.SrcType = CASE WHEN p.PurchaseType = 'PS' THEN 'GSO'
                        ELSE 'POR'
                   END
      AND i.SrcLineRef = @SrcLineRef
      AND i.QtyRemainToIssue > 0
    ORDER BY i.SrcDate


GO
GRANT CONTROL
    ON OBJECT::[dbo].[ProjInv_Fetch_InvProjAllocLotRtn] TO [MSDSL]
    AS [dbo];

