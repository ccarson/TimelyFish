 /****** Object:  Stored Procedure dbo.DeleteCashAvgD    Script Date: 4/7/98 12:49:20 PM ******/
Create Procedure DeleteCashAvgD @parm1 varchar ( 6) As
Delete cashavgd from CashAvgD Where
Pernbr <= @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DeleteCashAvgD] TO [MSDSL]
    AS [dbo];

