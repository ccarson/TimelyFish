 create procedure ADG_SlsPrcDet_SlsPrc_SlsPrcID

	@SlsPrcID	varchar(15)
as
	select	SlsPrcDet.*,
		SlsPrc.*
	from	SlsPrcDet
	join	SlsPrc on SlsPrc.SlsPrcID = SlsPrcDet.SlsPrcID
	where	SlsPrc.SlsPrcID = @SlsPrcID
	order by SlsPrc.DiscPrcTyp, SlsPrcDet.QtyBreak

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SlsPrcDet_SlsPrc_SlsPrcID] TO [MSDSL]
    AS [dbo];

