 /****** Object:  Stored Procedure dbo.Update_ARTran    Script Date: 4/7/98 12:30:33 PM ******/
Create Procedure Update_ARTran @parm1 smalldatetime, @parm2 varchar ( 15), @parm3 varchar ( 2), @parm4 varchar ( 10) as
    UPDATE ARTran
    SET Trandate = @parm1
    WHERE Custid = @parm2 and
    TranType = @Parm3 And
    Refnbr = @parm4



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Update_ARTran] TO [MSDSL]
    AS [dbo];

