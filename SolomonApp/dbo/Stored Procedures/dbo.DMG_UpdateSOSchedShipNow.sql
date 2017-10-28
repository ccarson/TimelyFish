 CREATE PROCEDURE DMG_UpdateSOSchedShipNow
	@CpnyID 	varchar(10),
	@OrdNbr 	varchar(15),
	@LineRef 	varchar(5),
	@SchedRef 	varchar(5),
	@LUpd_Prog 	varchar(8),
	@LUpd_User 	varchar(10)
	AS

	update	SOSched
	set	S4Future09 = 1,
		LUpd_DateTime = GETDATE(),
		LUpd_Prog = @LUpd_Prog,
		LUpd_User = @LUpd_User
	where	CpnyID = @CpnyID
	  and	OrdNbr = @OrdNbr
	  and 	LineRef = @LineRef
	  and	SchedRef = @SchedRef

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_UpdateSOSchedShipNow] TO [MSDSL]
    AS [dbo];

