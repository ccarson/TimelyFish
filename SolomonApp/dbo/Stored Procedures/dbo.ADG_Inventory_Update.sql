 create procedure ADG_Inventory_Update
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15),
	@ShipperID	varchar(15)

as
	declare @temp varchar(10)

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_Inventory_Update] TO [MSDSL]
    AS [dbo];

