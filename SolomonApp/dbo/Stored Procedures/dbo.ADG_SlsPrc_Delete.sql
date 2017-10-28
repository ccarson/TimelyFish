 create procedure ADG_SlsPrc_Delete

	@SlsPrcID varchar(15)
as
	delete
	from	SlsPrc
	where	SlsPrcID = @SlsPrcID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SlsPrc_Delete] TO [MSDSL]
    AS [dbo];

