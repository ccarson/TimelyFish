 create proc ADG_UpdtShip_ReleaseBatch
	@Module	varchar(2),
	@BatNbr	varchar(10)
as
	update	Batch

	set	Status = 'B',
		LUpd_DateTime = GetDate(),
		LUpd_Prog = 'UPDSH',
		LUpd_User = 'UPDSH'

	where	Module = @Module
	  and	BatNbr = @BatNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


