 Create Proc Control_Totals_IC @parm1 Varchar ( 10), @parm2 Varchar ( 2) as
        select Sum (CuryDrAmt), Sum (CuryCrAmt), Sum (DrAmt), Sum (CrAmt) from GLTran where Batnbr = @parm1 and Module = @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Control_Totals_IC] TO [MSDSL]
    AS [dbo];

