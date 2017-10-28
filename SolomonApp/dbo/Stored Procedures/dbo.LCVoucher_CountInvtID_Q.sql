 CREATE PROC LCVoucher_CountInvtID_Q
	@parm1 VARCHAR(10),
	@parm2 VARCHAR(30),
	@parm3 VARCHAR(10),
	@parm4 VARCHAR(10),
	@parm5 VARCHAR(25)
AS
	SELECT count(*),  max(potran.invtid), max(potran.siteid), max(potran.specificcostid)
	FROM potran, inventory, site
	WHERE POTran.cpnyid = @parm3 -- bLCVoucher.cpnyid
	and potran.rcptnbr = @parm1 -- bLCVoucher.rcptnbr
	and potran.invtid LIKE @parm2 -- bLCVoucher.invtid
	and potran.siteid LIKE @parm4 --bLCVoucher.siteid
	and potran.SpecificCostID LIKE @parm5 --bLCVoucher.SpecificCostID
	and potran.invtid = inventory.invtid
	and site.siteid = potran.siteid
	and potran.qty > 0



GO
GRANT CONTROL
    ON OBJECT::[dbo].[LCVoucher_CountInvtID_Q] TO [MSDSL]
    AS [dbo];

