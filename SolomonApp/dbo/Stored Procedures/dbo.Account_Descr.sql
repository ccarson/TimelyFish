 /****** Object:  Stored Procedure dbo.Account_Descr    Script Date: 4/7/98 12:38:58 PM ******/
Create Proc Account_Descr @parm1 varchar ( 10) as
    Select Descr from Account where Acct = @parm1 order by Acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Account_Descr] TO [MSDSL]
    AS [dbo];

