 /****** Object:  Stored Procedure dbo.ARTran_RefNbr_TranType    Script Date: 4/7/98 12:30:33 PM ******/
Create Procedure ARTran_RefNbr_TranType @parm1 varchar ( 10), @parm2 varchar ( 2) as
    Select * from ARTran where ARTran.RefNbr = @parm1
        and ARTran.TranType = @parm2
        order by RefNbr, TranType, LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARTran_RefNbr_TranType] TO [MSDSL]
    AS [dbo];

