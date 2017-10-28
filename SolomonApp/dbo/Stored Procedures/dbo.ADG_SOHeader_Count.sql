 create proc ADG_SOHeader_Count
	@CpnyID	varchar(10),
	@OrdNbr	varchar(15)
as
	select	count(*)
	from	SOHeader
	where	CpnyID = @CpnyID
	  and	OrdNbr = @OrdNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


