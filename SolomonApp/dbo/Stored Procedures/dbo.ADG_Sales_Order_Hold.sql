 create proc ADG_Sales_Order_Hold
	@CpnyID	varchar(10),
	@OrdNbr	varchar(15)
as
	update	SOHeader
	set	AdminHold = 1
	where	CpnyID like @CpnyID
	  and	OrdNbr	like @OrdNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


