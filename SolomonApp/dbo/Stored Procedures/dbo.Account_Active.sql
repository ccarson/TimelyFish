 /****** Object:  Stored Procedure dbo.Account_Active    Script Date: 4/7/98 12:38:58 PM ******/
Create Proc Account_Active @parm1 varchar ( 10) as
    Select * from Account where Acct like @parm1 and Active <> 0 Order by Acct


