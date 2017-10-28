 create Procedure ADG_SlsPrc_Revisions

	@PriceCat	varchar(2),
	@CuryID		varchar(4),
	@StartDate	smalldatetime
as

	update	SlsPrcDet
	set	DiscPrice = RvsdDiscPrice,
		RvsdDiscPrice = 0,
		DiscPct = RvsdDiscPct,
		RvsdDiscPct = 0,
		SlsPrcDet.S4Future01 = SlsPrcDet.S4Future02,
		SlsPrcDet.S4Future02 = ''
	from	SlsPrcDet
	join	SlsPrc on Slsprc.SlsPrcID = SlsPrcDet.SlsPrcID
	where	SlsPrc.PriceCat like @PriceCat
	and	SlsPrc.CuryID like @CuryID
	and	SlsPrcDet.StartDate <= @StartDate
	and	((SlsPrc.DiscPrcMthd Like '[FK]' and RvsdDiscPrice <> 0) or (Slsprc.DiscPrcMthd Like '[MPR]' and RvsdDiscPct <>0))

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SlsPrc_Revisions] TO [MSDSL]
    AS [dbo];

