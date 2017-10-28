 CREATE Procedure ARTran_BatNbr_Type_Ref_LineNbr @parm1 varchar ( 10), @parm2 varchar ( 2), @parm3 varchar ( 10), @parm4beg smallint, @parm4end smallint as
             Select * from ARTran where BatNbr = @parm1
             and TranType = @parm2
             and ((TranType IN ('CM', 'PA', 'DA', 'SB', 'RF', 'RA') AND DrCr = 'D')
                 OR (TranType IN ('DM', 'IN', 'FI','SC', 'CS', 'AD') AND DrCr = 'C')
                 OR DrCr = ''
                 OR TranClass = 'D'
	    OR TranType IN('SB','SC') AND DrCr='U')
             and RefNbr = @parm3
             and LineNbr between @parm4beg and @parm4end
             order by CustId, TranType, RefNbr, LineNbr


