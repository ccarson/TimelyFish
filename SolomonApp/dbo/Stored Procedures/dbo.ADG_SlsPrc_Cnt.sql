 create procedure ADG_SlsPrc_Cnt

	@SlsPrcID varchar(15),
	@PriceCat varchar(2),
	@SelectFld1 varchar(30),
	@SelectFld2 varchar(30),
	@CuryID varchar(4),
	@SiteID varchar(10),
	@DiscPrcTyp varchar(1)
as
	select	count(*)
	from	SlsPrc
	where	SlsPrcID <> @SlsPrcID
	and	PriceCat = @PriceCat
	and	SelectFld1 like @SelectFld1
	and	SelectFld2 like @SelectFld2
	and	CuryID = @CuryID
	and	SiteID like @SiteID
	and	DiscPrcTyp = @DiscPrcTyp

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SlsPrc_Cnt] TO [MSDSL]
    AS [dbo];

