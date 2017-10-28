 create proc ADG_TermsDate_TermsInfo
	@TermsID	varchar(2)
as
	select	DiscIntrv,
		DiscPct,
		DiscType,
		DueIntrv,
		DueType
	from	Terms
	where	TermsID = @TermsID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_TermsDate_TermsInfo] TO [MSDSL]
    AS [dbo];

