 create proc ADG_SOHeader_CountType
	@CpnyID		varchar(10),
	@SOTypeID	varchar(4),
	@Status		varchar(1)
as
	select	'Records' = convert(int, count(*))
	from	SOHeader
	where	CpnyID = @CpnyID
	  and	SOTypeID = @SOTypeID
	  and	Status = @Status

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


