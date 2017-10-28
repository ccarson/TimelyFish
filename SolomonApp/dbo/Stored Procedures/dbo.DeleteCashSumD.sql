 /****** Object:  Stored Procedure dbo.DeleteCashSumD    Script Date: 4/7/98 12:49:20 PM ******/
Create Procedure DeleteCashSumD @parm1 varchar ( 6) As
Delete cashsumd from CashSumD Where
Pernbr <= @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DeleteCashSumD] TO [MSDSL]
    AS [dbo];

