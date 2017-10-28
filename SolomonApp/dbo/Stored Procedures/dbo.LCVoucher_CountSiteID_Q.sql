 CREATE PROC LCVoucher_CountSiteID_Q
	@parm1 VARCHAR(10),
	@parm2 VARCHAR(30),
	@parm3 VARCHAR(10)
AS
	SELECT count(*),  max(potran.invtid), max(potran.siteid), max(potran.specificcostid)
	FROM potran, inventory, site
	WHERE potran.rcptnbr = @parm1 -- bLCVoucher.rcptnbr
	and potran.invtid = @parm2 -- bLCVoucher.invtid
	and POTran.cpnyid = @parm3 -- bLCVoucher.cpnyid
	and potran.invtid = inventory.invtid
	and site.siteid = potran.siteid
	and potran.qty > 0



GO
GRANT CONTROL
    ON OBJECT::[dbo].[LCVoucher_CountSiteID_Q] TO [MSDSL]
    AS [dbo];

