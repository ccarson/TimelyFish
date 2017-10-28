 Create Procedure ARDoc_BatNbr_CpnyID_NotRfnbr_NotCustId @parm1 varchar ( 10), @parm2 varchar ( 10), @parm3 varchar ( 10), @parm4 varchar ( 15) as
    Select CuryOrigDocAmt from ARDoc where
        BatNbr = @parm1 and
        CpnyID=@parm2  and
        not (refnbr=@parm3 and custid=@parm4)




GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARDoc_BatNbr_CpnyID_NotRfnbr_NotCustId] TO [MSDSL]
    AS [dbo];

