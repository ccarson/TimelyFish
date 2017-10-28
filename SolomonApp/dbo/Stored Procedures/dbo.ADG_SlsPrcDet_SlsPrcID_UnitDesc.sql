 create procedure ADG_SlsPrcDet_SlsPrcID_UnitDesc

	@SlsPrcID	varchar(15),
	@SlsUnit	varchar(6)
as
	select	SlsPrcDet.*
	from	SlsPrcDet
	join	SlsPrc on SlsPrc.SlsPrcID = SlsPrcDet.SlsPrcID
	where	SlsPrc.SlsPrcID = @SlsPrcID
	and	SlsPrcDet.SlsUnit like @SlsUnit
	order by SlsPrcDet.QtyBreak

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SlsPrcDet_SlsPrcID_UnitDesc] TO [MSDSL]
    AS [dbo];

