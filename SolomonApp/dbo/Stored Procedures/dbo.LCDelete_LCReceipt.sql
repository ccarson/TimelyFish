 Create Proc LCDelete_LCReceipt
	@Rcptnbr varchar(15)
as
Update LCReceipt
	set TranStatus = 'U',
	ApRefNbr = '',
	s4Future12 = '',
	INBatNbr = ''
WHERE
	Rcptnbr = @RcptNbr

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[LCDelete_LCReceipt] TO [MSDSL]
    AS [dbo];

