
CREATE Proc ProjInv_Fetch_ShipperAllocations
       @Batnbr VarChar(10),
       @LineRef VarChar(5),
       @RecordID Integer


AS

   SELECT a.InvtID, a.SiteID, a.WhseLoc, a.ProjectID, a.TaskID, a.SrcNbr, a.SrcLineRef, a.QtyAllocated, i.Unitcost, i.PerEnt
     FROM INTran i JOIN INPrjAllocation a
                     ON i.ShipperID = a.SrcNbr
                    AND i.ShipperLineRef = a.SrcLineRef
                    AND a.SrcType = 'SH'
    WHERE i.Batnbr = @Batnbr
      AND i.LineRef = @LineREf
      AND i.RecordID = @RecordID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[ProjInv_Fetch_ShipperAllocations] TO [MSDSL]
    AS [dbo];

