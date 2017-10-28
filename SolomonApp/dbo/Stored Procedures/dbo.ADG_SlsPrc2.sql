 create procedure ADG_SlsPrc2

	@CuryID		varchar(4),
	@SlsPrcID	varchar(15)
as
	select	*
	from	SlsPrc
	where	CuryID = @CuryID
	and	SlsPrcID like @SlsPrcID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SlsPrc2] TO [MSDSL]
    AS [dbo];

