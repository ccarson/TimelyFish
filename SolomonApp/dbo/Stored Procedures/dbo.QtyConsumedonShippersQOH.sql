
CREATE proc QtyConsumedonShippersQOH @InvtId varchar(30), @SiteId varchar (16), @WhseLoc varchar(10), @ProjectId varchar (16), @TaskID varchar (32), @ShipperID varchar(15) AS

  SELECT SHQtyAllocQOH = ISNULL(sum(i.QtyAllocated),0)
    FROM InPrjAllocation i with (nolock) JOIN SOShipHeader s WITH(NOLOCK)
                                           ON i.SrcNbr = s.ShipperID
                                          AND i.CpnyID = s.CpnyID
                                         JOIN SOType t WITH(NOLOCK)
                                           ON s.SOTypeID = t.SOTypeID
                                          AND s.CpnyID = t.CpnyID
   WHERE i.Invtid = @Invtid 
     AND i.SiteID = @SiteId  
     AND i.WhseLoc like @WhseLoc
     AND i.ProjectID = @ProjectID  
     AND i.TaskId = @TaskID 
     AND i.SrcType = 'SH'
     AND i.SrcNbr <> @ShipperId
     AND ((s.ShippingConfirmed = 1 AND t.Behavior = 'SO') OR (s.Status = 'C' AND t.Behavior = 'INVC'))


GO
GRANT CONTROL
    ON OBJECT::[dbo].[QtyConsumedonShippersQOH] TO [MSDSL]
    AS [dbo];

