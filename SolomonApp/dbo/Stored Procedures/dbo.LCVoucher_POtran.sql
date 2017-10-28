 CREATE PROC LCVoucher_POtran
	@parm1 VARCHAR(10),
	@parm2 VARCHAR(30),
	@parm3 VARCHAR(25),
	@parm4 VARCHAR(10)
AS
	SELECT 	extcost= sum(round(extcost,2)), extweight = sum(extweight), extvolume = sum(s4future05),
	rcptqty= sum(round(rcptqty,6)), bmiextcost = sum(round(bmiextcost,2)), bmitranamt=sum(round(bmitranamt,2)),
	unitdescr=max(unitdescr), bmicuryid=max(bmicuryid), bmieffdate=max(bmieffdate),
	bmimultdiv=max(bmimultdiv), bmirate=max(bmirate), bmirttp=max(bmirttp),
	bmiunitcost=max(bmiunitcost), bmiunitprice=max(bmiunitprice)
	FROM potran
	WHERE rcptnbr = @parm1
	and invtid = @parm2
	and specificcostid like @parm3
	and siteid = @parm4



GO
GRANT CONTROL
    ON OBJECT::[dbo].[LCVoucher_POtran] TO [MSDSL]
    AS [dbo];

