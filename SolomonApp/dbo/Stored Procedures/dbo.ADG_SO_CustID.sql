 create procedure ADG_SO_CustID

	@CpnyID		varchar(10),
	@OrdNbr 	varchar(15),
	@ShipperID 	varchar(15)
as

	declare @CustID varchar(15)

	if rtrim(@ShipperID) <> ''
	begin
		select	@CustID = CustID
		from	SOShipHeader
		where	CpnyID = @CpnyID
		  and	ShipperID = @ShipperID
	end
	else
	begin
		select	@CustID = CustID
		from	SOHeader
		where	CpnyID = @CpnyID
		  and	OrdNbr = @OrdNbr
	end

	select @CustID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SO_CustID] TO [MSDSL]
    AS [dbo];

