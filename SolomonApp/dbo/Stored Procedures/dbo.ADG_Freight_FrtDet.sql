 create proc ADG_Freight_FrtDet
	@FrtTermsID	varchar(10),
	@OrderVal	float
as
	select	FreightPct,
		HandlingChg,
		HandlingChgLine,
		InvcAmtPct

	from	FrtTermDet
	where	FrtTermsID = @FrtTermsID
	  and	MinOrderVal <= @OrderVal

	order by
		MinOrderVal desc

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


