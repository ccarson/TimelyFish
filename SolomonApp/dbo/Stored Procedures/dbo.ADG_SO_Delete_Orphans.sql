 create procedure ADG_SO_Delete_Orphans

	@CpnyID	varchar(10)
as

	-- delete the records from the order and shipper related tables that don't have Header records

	-- delete order related records
	delete	from SOEvent
	where	CpnyID = @CpnyID
	  and	OrdNbr not in (select OrdNbr from SOHeader where CpnyID = @CpnyID)

	delete	from SOHeaderMark
	where	CpnyID = @CpnyID
	  and	OrdNbr not in (select OrdNbr from SOHeader where CpnyID = @CpnyID)

	delete	from SOLine
	where	CpnyID = @CpnyID
	  and	OrdNbr not in (select OrdNbr from SOHeader where CpnyID = @CpnyID)

	delete	from SOMisc
	where	CpnyID = @CpnyID
	  and	OrdNbr not in (select OrdNbr from SOHeader where CpnyID = @CpnyID)

	delete	from SONoShip
	where	CpnyID = @CpnyID
	  and	OrdNbr not in (select OrdNbr from SOHeader where CpnyID = @CpnyID)

	delete	from SOPlan
	where	CpnyID = @CpnyID
	  and	SOOrdNbr not in (select OrdNbr from SOHeader where CpnyID = @CpnyID)

	delete	from SOPrePay
	where	CpnyID = @CpnyID
	  and	OrdNbr not in (select OrdNbr from SOHeader where CpnyID = @CpnyID)

	delete	from SOSched
	where	CpnyID = @CpnyID
	  and	OrdNbr not in (select OrdNbr from SOHeader where CpnyID = @CpnyID)

	delete	from SOSchedMark
	where	CpnyID = @CpnyID
	  and	OrdNbr not in (select OrdNbr from SOHeader where CpnyID = @CpnyID)

	delete	from SOSplitDefaults
	where	CpnyID = @CpnyID
	  and	OrdNbr not in (select OrdNbr from SOHeader where CpnyID = @CpnyID)

	delete	from SOSplitLine
	where	CpnyID = @CpnyID
	  and	OrdNbr not in (select OrdNbr from SOHeader where CpnyID = @CpnyID)

	delete	from SOTax
	where	CpnyID = @CpnyID
	  and	OrdNbr not in (select OrdNbr from SOHeader where CpnyID = @CpnyID)

	-- delete shipper related records
	delete	from SOBuildLot
	where	CpnyID = @CpnyID
	  and	ShipperID not in (select ShipperID from SOShipHeader where CpnyID = @CpnyID)

	delete	from SONoUpdate
	where	CpnyID = @CpnyID
	  and	ShipperID not in (select ShipperID from SOShipHeader where CpnyID = @CpnyID)

	delete	from SOShipLine
	where	CpnyID = @CpnyID
	  and	ShipperID not in (select ShipperID from SOShipHeader where CpnyID = @CpnyID)

	delete	from SOShipLineSplit
	where	CpnyID = @CpnyID
	  and	ShipperID not in (select ShipperID from SOShipHeader where CpnyID = @CpnyID)

	delete	from SOShipLot
	where	CpnyID = @CpnyID
	  and	ShipperID not in (select ShipperID from SOShipHeader where CpnyID = @CpnyID)

	delete	from SOShipMark
	where	CpnyID = @CpnyID
	  and	ShipperID not in (select ShipperID from SOShipHeader where CpnyID = @CpnyID)

	delete	from SOShipMisc
	where	CpnyID = @CpnyID
	  and	ShipperID not in (select ShipperID from SOShipHeader where CpnyID = @CpnyID)

	delete	from SOShipPack
	where	CpnyID = @CpnyID
	  and	ShipperID not in (select ShipperID from SOShipHeader where CpnyID = @CpnyID)

	delete	from SOShipPayments
	where	CpnyID = @CpnyID
	  and	ShipperID not in (select ShipperID from SOShipHeader where CpnyID = @CpnyID)

	delete	from SOShipSched
	where	CpnyID = @CpnyID
	  and	ShipperID not in (select ShipperID from SOShipHeader where CpnyID = @CpnyID)

	delete	from SOShipSplit
	where	CpnyID = @CpnyID
	  and	ShipperID not in (select ShipperID from SOShipHeader where CpnyID = @CpnyID)

	delete	from SOShipTax
	where	CpnyID = @CpnyID
	  and	ShipperID not in (select ShipperID from SOShipHeader where CpnyID = @CpnyID)

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SO_Delete_Orphans] TO [MSDSL]
    AS [dbo];

