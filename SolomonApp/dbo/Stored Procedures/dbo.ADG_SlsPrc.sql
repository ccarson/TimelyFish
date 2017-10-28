 create procedure ADG_SlsPrc

	@SlsPrcID varchar(15)
as
	select	*
	from	SlsPrc
	where	SlsPrcID = @SlsPrcID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SlsPrc] TO [MSDSL]
    AS [dbo];

