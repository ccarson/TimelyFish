 create proc ADG_INTran_SetLstTrnsfrDocNbr
	@LastDocNbr	varchar(10),
	@LUpd_Prog	varchar(8),
	@LUpd_User	varchar(10)
as
	update		INSetup
	set		LstTrnsfrDocNbr = @LastDocNbr,
			LUpd_DateTime = GetDate(),
			LUpd_Prog = @LUpd_Prog,
			LUpd_User = @LUpd_User

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_INTran_SetLstTrnsfrDocNbr] TO [MSDSL]
    AS [dbo];

