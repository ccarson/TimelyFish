 create procedure ADG_SlsPrc_Max_SlsPrcID

as
	select	max(SlsPrcID)
	from	SlsPrc

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SlsPrc_Max_SlsPrcID] TO [MSDSL]
    AS [dbo];

