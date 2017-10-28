 /****** Object:  Stored Procedure dbo.ARTran_B_C_T_R_LineMax    Script Date: 4/7/98 12:30:33 PM ******/
Create Procedure ARTran_B_C_T_R_LineMax @parm1 varchar ( 10), @parm2 varchar ( 15), @parm3 varchar ( 2), @parm4 varchar ( 10) as
    select MAX(LineNbr) from ARTran where
    BatNbr = @parm1
    and CustId = @parm2
    and TranType = @parm3
    and RefNbr = @parm4
    and DrCr <> 'U'


GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARTran_B_C_T_R_LineMax] TO [MSDSL]
    AS [dbo];

