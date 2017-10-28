 CREATE PROC LCVoucher_InvtID_Q
	@parm1 VARCHAR(10),
	@parm2 VARCHAR(10),
	@parm3 VARCHAR(30)
AS
	SELECT DISTINCT  potran.invtid, potran.siteid
	FROM potran, inventory
	WHERE rcptnbr = @parm1
	and POTran.cpnyid = @parm2
	and potran.invtid like @parm3
	and potran.invtid = inventory.invtid
	and potran.qty > 0
	ORDER BY potran.invtid

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[LCVoucher_InvtID_Q] TO [MSDSL]
    AS [dbo];

