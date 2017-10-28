
CREATE Proc ProjInv_DELETE_ShipperAllocationsLot
      @ShipperID VarChar(15),
      @LineRef VarChar(5),
      @WhseLoc VarChar(10),
      @LotSerNbr VarChar(25),
      @LotSerRef VarChar(5)
AS

    UPDATE l 
        SET l.QtyAllocProjIN = CASE WHEN CONVERT(DEC(28,9),l.QtyAllocProjIN) - CONVERT(DEC(28,9),i.QtyAllocated) < 0 
                                  THEN 0 
                                  ELSE CONVERT(DEC(28,9),l.QtyAllocProjIN) - CONVERT(DEC(28,9),i.QtyAllocated) END,
            l.PrjINQtyShipNotInv = CASE WHEN CONVERT(DEC(28,9),l.PrjINQtyShipNotInv) - CONVERT(DEC(28,9),i.QtyAllocated) < 0 
                                        THEN 0 
                                        ELSE CONVERT(DEC(28,9),l.PrjINQtyShipNotInv) - CONVERT(DEC(28,9),i.QtyAllocated) END
      FROM INPrjAllocationLot i JOIN LotSerMst l
                               ON i.InvtID = l.InvtID
                              AND i.SiteID = l.SiteID
                              AND i.WhseLoc = l.WhseLoc
                              AND i.LotSerNbr = l.LotSerNbr
     WHERE i.SrcNbr = @ShipperID
       AND i.SrcLineRef = @LineRef
       AND i.SrcType = 'SH'
       AND i.WhseLoc = @WhseLoc
       AND i.LotSerNbr = @LotSerNbr
       AND i.LotSerRef = @LotSerRef


    DELETE 
      FROM INPrjAllocationLot
     WHERE SrcNbr = @ShipperID
       AND SrcLineRef = @LineRef
       AND SrcType = 'SH'
      AND WhseLoc = @WhseLoc
      AND LotSerNbr = @LotSerNbr
      AND LotSerRef = @LotSerRef


GO
GRANT CONTROL
    ON OBJECT::[dbo].[ProjInv_DELETE_ShipperAllocationsLot] TO [MSDSL]
    AS [dbo];

