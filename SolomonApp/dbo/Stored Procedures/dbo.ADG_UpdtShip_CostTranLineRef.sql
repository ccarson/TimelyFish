 create proc ADG_UpdtShip_CostTranLineRef
	@BatNbr		varchar(10),
	@RefNbr		varchar(15),
	@ARLineRef	varchar(5)
as
	select	LineRef
	from	INTran
	where	BatNbr = @BatNbr
	  and	RefNbr = @RefNbr
	  and	ARLineRef = @ARLineRef
	  and	TranType = 'CG'
	  and	Rlsed = 1


-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


