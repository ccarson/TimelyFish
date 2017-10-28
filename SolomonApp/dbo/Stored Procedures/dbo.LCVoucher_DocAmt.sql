 create proc LCVoucher_DocAmt
	@parmBatNbr varchar(10),
	@parmRefNbr varchar(10)
as
	select
		sum(curytranamt)
	from aptran
	where
		LCCode <> ''
		and
		BatNbr = @parmBatNbr
		and
		RefNbr = @parmRefNbr

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[LCVoucher_DocAmt] TO [MSDSL]
    AS [dbo];

