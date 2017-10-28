
CREATE Proc ProjInv_DELETE_ShipperAllocations
      @ShipperID VarChar(15),
      @LineRef VarChar(5),
      @WhseLoc VarChar(10)
AS

    UPDATE s 
        SET s.QtyAllocProjIN = CASE WHEN CONVERT(DEC(28,9),s.QtyAllocProjIN) - CONVERT(DEC(28,9),i.QtyAllocated) < 0 
                                  THEN 0 
                                  ELSE CONVERT(DEC(28,9),s.QtyAllocProjIN) - CONVERT(DEC(28,9),i.QtyAllocated) END,
            s.PrjINQtyShipNotInv = CASE WHEN CONVERT(DEC(28,9),s.PrjINQtyShipNotInv) - CONVERT(DEC(28,9),i.QtyAllocated) < 0 
                                        THEN 0 
                                        ELSE CONVERT(DEC(28,9),s.PrjINQtyShipNotInv) - CONVERT(DEC(28,9),i.QtyAllocated) END
      FROM INPrjAllocation i JOIN ItemSite s
                               ON i.InvtID = s.InvtID
                              AND i.SiteID = s.SiteID
     WHERE i.SrcNbr = @ShipperID
       AND i.SrcLineRef = @LineRef
       AND i.SrcType = 'SH'
       AND i.WhseLoc = @WhseLoc

    UPDATE l 
        SET l.QtyAllocProjIN = CASE WHEN CONVERT(DEC(28,9),l.QtyAllocProjIN) - CONVERT(DEC(28,9),i.QtyAllocated) < 0 
                                  THEN 0 
                                  ELSE CONVERT(DEC(28,9),l.QtyAllocProjIN) - CONVERT(DEC(28,9),i.QtyAllocated) END,
            l.PrjINQtyShipNotInv = CASE WHEN CONVERT(DEC(28,9),l.PrjINQtyShipNotInv) - CONVERT(DEC(28,9),i.QtyAllocated) < 0 
                                        THEN 0 
                                        ELSE CONVERT(DEC(28,9),l.PrjINQtyShipNotInv) - CONVERT(DEC(28,9),i.QtyAllocated) END
      FROM INPrjAllocation i JOIN Location l
                               ON i.InvtID = l.InvtID
                              AND i.SiteID = l.SiteID
                              AND i.WhseLoc = l.WhseLoc
     WHERE i.SrcNbr = @ShipperID
       AND i.SrcLineRef = @LineRef
       AND i.SrcType = 'SH'
       AND i.WhseLoc = @WhseLoc


    DELETE 
      FROM INPrjAllocation
     WHERE SrcNbr = @ShipperID
       AND SrcLineRef = @LineRef
       AND SrcType = 'SH'
      AND WhseLoc = @WhseLoc


GO
GRANT CONTROL
    ON OBJECT::[dbo].[ProjInv_DELETE_ShipperAllocations] TO [MSDSL]
    AS [dbo];

