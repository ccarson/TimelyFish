 Create Procedure DMG_SOSched_OrdNbr_LineRef
	@CpnyID varchar(10),
	@OrdNbr varchar(15),
	@LineRef varchar(5),
	@SchedRef varchar(5)
as

	select 	*
	from 	vp_SOSchedPO
		where	CpnyID = @CpnyID
	And		OrdNbr = @OrdNbr
	And		LineRef = @LineRef
	And		SchedRef like @SchedRef
	Order by CpnyID, OrdNbr, LineRef, SchedRef

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOSched_OrdNbr_LineRef] TO [MSDSL]
    AS [dbo];

