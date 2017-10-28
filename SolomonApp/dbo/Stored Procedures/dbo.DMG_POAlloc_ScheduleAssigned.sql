 CREATE PROCEDURE DMG_POAlloc_ScheduleAssigned
	@CpnyID varchar(10),
	@SOOrdNbr varchar(15),
	@SOLineRef varchar(5),
	@SOSchedRef varchar(5)
AS
		-- Select a PONbr that is NOT Cancelled.
	select	A.PONbr
	from	POAlloc A
	where	CpnyID = @CpnyID
	and	SOOrdNbr = @SOOrdNbr
	and	SOLineRef = @SOLineRef
	and	SOSchedRef = @SOSchedRef

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_POAlloc_ScheduleAssigned] TO [MSDSL]
    AS [dbo];

