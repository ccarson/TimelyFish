 /****** Object:  Stored Procedure dbo.Delete_DummyARTran    Script Date: 4/7/98 12:30:33 PM ******/
Create Procedure Delete_DummyARTran @parm1 varchar ( 10), @parm2 varchar ( 15), @parm3 varchar ( 2), @parm4 varchar ( 10) as
    Delete artran from ARTran where
    BatNbr = @parm1
    and DrCr = 'U'
    and CustId = @parm2
    and (TranType = @parm3
    or TranType = "SB")
    and RefNbr = @parm4




GO
GRANT CONTROL
    ON OBJECT::[dbo].[Delete_DummyARTran] TO [MSDSL]
    AS [dbo];

