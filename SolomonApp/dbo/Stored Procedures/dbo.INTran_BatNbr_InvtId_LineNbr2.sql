 /****** Object:  Stored Procedure dbo.INTran_BatNbr_InvtId_LineNbr2    Script Date: 4/17/98 10:58:17 AM ******/
/****** Object:  Stored Procedure dbo.INTran_BatNbr_InvtId_LineNbr2    Script Date: 4/16/98 7:41:51 PM ******/
Create Proc INTran_BatNbr_InvtId_LineNbr2 @parm1 varchar ( 10), @parm2 varchar( 30), @parm3 varchar ( 15), @parm4 smallint, @parm5 smallint AS
		  Select *  from INTran where
		  Batnbr = @parm1
		  and INTran.InvtID <> @parm2
                  and INTran.RefNbr = @parm3
                  and LineNbr between @parm4 and @parm5
                  and INTran.trantype = 'AS'
                  order by BatNbr, RefNbr, LineNbr


