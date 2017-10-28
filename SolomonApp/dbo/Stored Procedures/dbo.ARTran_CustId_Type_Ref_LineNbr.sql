 /****** Object:  Stored Procedure dbo.ARTran_CustId_Type_Ref_LineNbr    Script Date: 4/7/98 12:30:33 PM ******/
Create Procedure ARTran_CustId_Type_Ref_LineNbr @parm1 varchar ( 10), @parm2 varchar ( 15), @parm3 varchar ( 2), @parm4 varchar ( 10), @parm5beg smallint, @parm5end smallint as

             Select * from ARTran where BatNbr = @parm1
             and CustId = @parm2
             and TranType = @parm3
             and ((TranType IN ('CM', 'PA', 'DA','SB','RF','PP','RP','NS', 'RA') AND DrCr = 'D')
                 OR (TranType IN ('DM', 'IN', 'FC','SC','NC','CS', 'AD') AND DrCr = 'C')
                 OR DrCr = ''
                 OR TranClass = 'D')
             and RefNbr = @parm4
             and LineNbr between @parm5beg and @parm5end
             order by CustId, TranType, RefNbr, LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARTran_CustId_Type_Ref_LineNbr] TO [MSDSL]
    AS [dbo];

