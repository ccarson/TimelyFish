 create proc OU_NextShipperStep
	@NextFunctionID		varchar(8),
	@NextClassID		varchar(4),
	@CpnyID			varchar(10),
	@ShipperID		varchar(15)
as
	select	*
	from	SOShipHeader
	where 	NextFunctionID = @NextFunctionID
	and	NextFunctionClass = @NextClassID
	and	CpnyID like @CpnyID
	and	ShipperID like @ShipperID
	order by CpnyID, ShipperID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[OU_NextShipperStep] TO [MSDSL]
    AS [dbo];

