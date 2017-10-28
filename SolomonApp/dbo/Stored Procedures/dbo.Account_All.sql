 /****** Object:  Stored Procedure dbo.Account_All    Script Date: 4/7/98 12:38:58 PM ******/
Create Proc Account_All @parm1 varchar ( 10) as
    Select * from Account where Acct like @parm1 order by Acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Account_All] TO [MSDSL]
    AS [dbo];

