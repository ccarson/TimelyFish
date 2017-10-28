 create proc ADG_SOType_ShipperNbr
	@CpnyID		varchar(10),
	@SOTypeID	varchar(4)
as
	select	LastShipperNbr,
		ShipperPrefix,
		ShipperType
	from	SOType
	where	CpnyID = @CpnyID
	  and	SOTypeID = @SOTypeID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SOType_ShipperNbr] TO [MSDSL]
    AS [dbo];

