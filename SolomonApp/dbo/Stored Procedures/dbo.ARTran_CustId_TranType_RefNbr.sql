 /****** Object:  Stored Procedure dbo.ARTran_CustId_TranType_RefNbr    Script Date: 4/7/98 12:30:33 PM ******/
Create Procedure ARTran_CustId_TranType_RefNbr @parm1 varchar ( 10), @parm2 varchar ( 15), @parm3 varchar ( 8), @parm4 varchar ( 10), @parm5 varchar ( 2), @parm6 varchar ( 10) as
    Select * from ARTran With (index = artran9) where
            ARTran.BatNbr = @parm1
            and ARTran.CustId = @parm2
            and ARTran.CostType = @parm3
            and ARTran.SiteId = @parm4
            and ARTran.TranType like @parm5
            and ARTran.RefNbr like @parm6
            and ARTran.DrCr = 'U'
            order by Batnbr, CustId, TranType, RefNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARTran_CustId_TranType_RefNbr] TO [MSDSL]
    AS [dbo];

