 /****** Object:  Stored Procedure dbo.Update_ARTran_ARAdjust0    Script Date: 4/7/98 12:30:33 PM ******/
Create Procedure Update_ARTran_ARAdjust0 @parm1 smalldatetime, @parm2 varchar ( 15), @parm3 varchar ( 2), @parm4 varchar ( 10) as
    UPDATE ARTran
    SET ARTran.TranDate = @parm1
        WHERE ARTran.Custid = @parm2
        AND ARTran.TranType = @Parm3
        AND ARTran.Refnbr = @parm4



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Update_ARTran_ARAdjust0] TO [MSDSL]
    AS [dbo];

