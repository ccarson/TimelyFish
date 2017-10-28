 CREATE PROCEDURE ADG_UpdateSOSchedPriority
	@CpnyID 	varchar(10),
	@OrdNbr 	varchar(15),
	@LineRef 	varchar(5),
	@SchedRef 	varchar(5),
 	@PrioritySeq 	int,
	@LUpd_Prog 	varchar(8),
	@LUpd_User 	varchar(10)
	AS

	update	SOSched
	set	PrioritySeq = @PrioritySeq,
		LUpd_DateTime = GETDATE(),
		LUpd_Prog = @LUpd_Prog,
		LUpd_User = @LUpd_User
	where	CpnyID = @CpnyID
	  and	OrdNbr = @OrdNbr
	  and 	LineRef = @LineRef
	  and	SchedRef = @SchedRef

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


