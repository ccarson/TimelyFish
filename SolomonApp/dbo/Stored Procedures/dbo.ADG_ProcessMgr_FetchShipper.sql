 create procedure ADG_ProcessMgr_FetchShipper
	@CpnyID		varchar(10),
	@ShipperID	varchar(15)
as
	select		CustID,
			OrdNbr
	from		SOShipHeader
	where		CpnyID = @CpnyID
	and		ShipperID = @ShipperID


