 create proc ADG_GLWildcard_MI
	@MiscChrgID	varchar(10)
as
	select		MiscAcct,
			MiscSub
	from		MiscCharge (nolock)
	where		MiscChrgID = @MiscChrgID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


