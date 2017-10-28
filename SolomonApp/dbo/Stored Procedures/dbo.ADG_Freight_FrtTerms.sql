 create proc ADG_Freight_FrtTerms
	@FrtTermsID	varchar(10)
as
	select	Collect
	from	FrtTerms
	where	FrtTermsID = @FrtTermsID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


