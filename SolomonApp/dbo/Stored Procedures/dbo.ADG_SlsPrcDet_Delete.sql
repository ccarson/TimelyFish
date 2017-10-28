 create procedure ADG_SlsPrcDet_Delete

	@SlsPrcID varchar(15),
	@DetRef varchar(5)
as
	delete
	from	SlsPrcDet
	where	SlsPrcID = @SlsPrcID
	and	DetRef like @DetRef

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SlsPrcDet_Delete] TO [MSDSL]
    AS [dbo];

