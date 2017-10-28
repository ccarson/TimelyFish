 create proc ADG_Batch_SetARLastBatNbr
	@LastBatNbr	varchar(10),
	@LUpd_Prog	varchar(8),
	@LUpd_User	varchar(10)
as
	update		ARSetup
	set		LastBatNbr = @LastBatNbr,
			LUpd_DateTime = GetDate(),
			LUpd_Prog = @LUpd_Prog,
			LUpd_User = @LUpd_User

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


