
CREATE Proc ProjInv_Fetch_ShipperAllocationsLot
       @Batnbr VarChar(10),
       @LineRef VarChar(5),
       @RecordID Integer


AS

   SELECT a.InvtID, a.SiteID, a.WhseLoc, a.ProjectID, a.TaskID, a.LotSerNbr, a.LotSerRef, a.SrcNbr, a.SrcLineRef, a.QtyAllocated
     FROM INTran i JOIN INPrjAllocationLot a
                     ON i.ShipperID = a.SrcNbr
                    AND i.ShipperLineRef = a.SrcLineRef
                    AND a.SrcType = 'SH'
                   JOIN LotSerT t WITH(NOLOCK) 
                             ON i.BatNbr = t.BatNbr
                            AND i.CpnyID = t.CpnyID
                            AND i.LineRef = t.INTranLineRef
                            AND i.RefNbr = t.RefNbr
                            AND i.InvtID = t.InvtID       
                            AND a.LotSerNbr = t.LotSerNbr 
    WHERE i.Batnbr = @Batnbr
      AND i.LineRef = @LineRef
      AND i.RecordID = @RecordID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[ProjInv_Fetch_ShipperAllocationsLot] TO [MSDSL]
    AS [dbo];

