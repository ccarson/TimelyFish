 /****** Object:  Stored Procedure dbo.DeleteCashFlow    Script Date: 4/7/98 12:49:20 PM ******/
Create Procedure DeleteCashFlow @parm1 smalldatetime As
Delete cashflow from CashFlow Where
RcptDisbDate  <= @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DeleteCashFlow] TO [MSDSL]
    AS [dbo];

