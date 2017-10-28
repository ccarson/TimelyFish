 create procedure DMG_PurchOrd_CpnyID_All
	@CpnyID varchar(10),
	@PONbr varchar(10)
AS
	select	*
	from	PurchOrd
	where	CpnyID = @CpnyID
	and	PONbr LIKE @PONbr
	order by PONbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


