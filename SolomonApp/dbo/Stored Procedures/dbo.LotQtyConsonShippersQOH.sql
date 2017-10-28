
CREATE proc LotQtyConsonShippersQOH @InvtId varchar(30), @SiteId varchar (16), @WhseLoc varchar(10), 
                                     @ProjectId varchar (16), @TaskID varchar (32), @ShipperID varchar(15), @LotSerNbr varchar (25) AS

  SELECT SHQtyAllocQOH = ISNULL(sum(i.QtyAllocated),0)
    FROM InPrjAllocationLot i with (nolock) JOIN SOShipHeader s WITH(NOLOCK)
                                              ON i.SrcNbr = s.ShipperID
                                             AND i.CpnyID = s.CpnyID
                                            JOIN SOType t WITH(NOLOCK)
                                              ON s.SOTypeID = t.SOTypeID
                                             AND s.CpnyID = t.CpnyID
   WHERE i.Invtid = @Invtid 
     AND i.SiteID = @SiteId  
     AND i.WhseLoc like @WhseLoc
     AND i.ProjectID = @ProjectID
     AND TaskId = @TaskID
     AND i.SrcType = 'SH'
     AND i.SrcNbr <> @ShipperId
     AND ((s.ShippingConfirmed <> 1 AND t.Behavior = 'SO') OR (s.Status <> 'C' AND t.Behavior = 'INVC'))
     AND LotSerNbr like @LotSerNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[LotQtyConsonShippersQOH] TO [MSDSL]
    AS [dbo];

