 /****** Object:  Stored Procedure dbo.DeleteBankRec    Script Date: 4/7/98 12:49:20 PM ******/
Create Procedure DeleteBankRec @parm1 varchar ( 6) As
Delete bankrec from BankRec Where
GLPeriod <= @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DeleteBankRec] TO [MSDSL]
    AS [dbo];

