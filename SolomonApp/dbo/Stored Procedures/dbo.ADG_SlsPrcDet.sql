 create procedure ADG_SlsPrcDet

	@SlsPrcID varchar(15),
	@DetRef varchar(5)
as
	select	*
	from	SlsPrcDet
	where	SlsPrcID = @SlsPrcID
	and	DetRef like @DetRef

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SlsPrcDet] TO [MSDSL]
    AS [dbo];

