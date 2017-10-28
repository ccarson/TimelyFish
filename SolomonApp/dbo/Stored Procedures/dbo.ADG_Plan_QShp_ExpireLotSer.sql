 create proc ADG_Plan_QShp_ExpireLotSer
	@InvtID		varchar(30),
	@SiteID		varchar(10),
	@Alloc		smalldatetime
as
-- -------------------------------------------------------------------
-- Get the quantity on shippers for the specified item and site.
-- This procedure is used for expiring lot/serial items only.
-- The application must handle the unit of measure conversion.
-- -------------------------------------------------------------------
	select	LotSerMst.ExpDate 'ExpireDate',
		LotSerMst.LotSerNbr,
		SOShipLot.QtyShip 'DemandQty',
		SOShipLine.CnvFact 'ConvFactor',
		SOShipLine.UnitMultDiv

	  FROM SOShipLine  (NOLOCK)

 	  JOIN SOShipLot (NOLOCK) -- Use NOLOCK to eliminate a deadlock problem
 	    ON SOShipLot.CpnyID = SOShipLine.CpnyID
 	   AND SOShipLot.ShipperID = SOShipLine.ShipperID
 	   AND SOShipLot.LineRef = SOShipLine.LineRef

 	  JOIN SOShipHeader (NOLOCK)	-- Use NOLOCK to eliminate a deadlock problem
 	    ON SOShipHeader.CpnyID = SOShipLine.CpnyID
 	   AND SOShipHeader.ShipperID = SOShipLine.ShipperID

 	  JOIN	LotSerMst
 	    ON	LotSerMst.InvtID = SOShipLine.InvtID
 	   AND	LotSerMst.LotSerNbr = SOShipLot.LotSerNbr
 	   AND	LotSerMst.SiteID = SOShipLine.SiteID

	where	SOShipLine.InvtID = @InvtID
	and	SOShipLine.SiteID = @SiteID
	and	SOShipLine.Status = 'O'
	and	SOShipLot.QtyShip > 0
	and	SOShipHeader.DropShip = 0
	and	LotSerMst.ExpDate > = @Alloc
	AND EXISTS(SELECT *
	             FROM sotype
	            WHERE sotype.cpnyid = SOShipHeader.CpnyID
	              AND sotype.SOTypeID = SOShipHeader.SoTypeID
	              AND SOType.Behavior in ('CS', 'INVC', 'MO', 'RMA', 'RMSH', 'SERV', 'SO', 'TR', 'WC', 'WO'))

	Group by LotSerMst.ExpDate,
		LotSerMst.LotSerNbr,
		SOShipLot.QtyShip ,
		SOShipLine.CnvFact,
		SOShipLine.UnitMultDiv

union all

	select	LotSerMst.ExpDate 'ExpireDate',
		LotSerMst.LotSerNbr,
		SOLot.QtyShip 'DemandQty',
		SOLine.CnvFact 'ConvFactor',
		SOLine.UnitMultDiv

	  FROM SOLine WITH (NOLOCK)

	      JOIN	SOSched (NOLOCK)
	        ON SOSched.CpnyID = SOLine.CpnyID
	       AND SOSched.OrdNbr = SOLine.OrdNbr
	       AND SOSched.LineRef = SOLine.LineRef

	      JOIN SOLot (NOLOCK) -- Use NOLOCK to eliminate a deadlock problem
	        on SOLot.CpnyID = SOSched.CpnyID
	       AND SOLot.OrdNbr = SOSched.OrdNbr
	       AND SOLot.LineRef = SOSched.LineRef
	       AND SOLot.SchedRef = SOSched.SchedRef

	      JOIN	SOHeader (NOLOCK)	-- Use NOLOCK to eliminate a deadlock problem
	        ON SOHeader.CpnyID = SOLine.CpnyID
	       AND SOHeader.OrdNbr = SOLine.OrdNbr

	      JOIN	LotSerMst
	        on	LotSerMst.InvtID = SOLine.InvtID
	       AND	LotSerMst.LotSerNbr = SOLot.LotSerNbr
	       AND	LotSerMst.SiteID = SOSched.SiteID

	 WHERE SOLot.InvtID = @InvtID and SOLot.QtyShip > 0
	   AND SOLine.Status = 'O'
	   AND SOSched.SiteID = @SiteID
	   AND SOSched.DropShip = 0
	   AND SOSched.LotSerialEntered = 1
	   AND LotSerMst.ExpDate > = @Alloc
	   AND EXISTS(SELECT *
	              FROM sotype
	             WHERE sotype.cpnyid = SOHeader.CpnyID
	               AND sotype.SOTypeID = SOHeader.SoTypeID
	               AND SOType.Behavior in ('SO', 'INVC', 'WC'))

	Group by LotSerMst.ExpDate,
		LotSerMst.LotSerNbr,
		SOLot.QtyShip,
		SOLine.CnvFact,
		SOLine.UnitMultDiv

 	order by
		LotSerMst.ExpDate,
		LotSerMst.LotSerNbr


