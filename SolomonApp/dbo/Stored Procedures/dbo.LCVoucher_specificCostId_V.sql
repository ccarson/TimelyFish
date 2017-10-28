 CREATE PROC LCVoucher_specificCostId_V
	@parm1 VARCHAR(10),
	@parm2 VARCHAR(30),
	@parm3 VARCHAR(10),
	@parm4 VARCHAR(10),
	@parm5 VARCHAR(25)
AS
	SELECT DISTINCT specificcostid
	FROM potran
	WHERE rcptnbr = @parm1
	and invtid = @parm2
	and siteid = @parm3
	and POTran.Cpnyid = @parm4
	and specificcostid like @parm5
	and potran.S4Future05 > 0
	ORDER BY specificcostid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[LCVoucher_specificCostId_V] TO [MSDSL]
    AS [dbo];

