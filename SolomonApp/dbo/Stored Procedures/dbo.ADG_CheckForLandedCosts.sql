 CREATE PROCEDURE ADG_CheckForLandedCosts
	@RcptNbr 	varchar (10)
	AS
	select 	Count(*)
	from 	INTran
	where 	RcptNbr = @RcptNbr
	and	TranType = 'AJ'
	and	JrnlType = 'LC'

-- Copyright 2002 by Advanced Distribution Group, Ltd. All rights reserved.


