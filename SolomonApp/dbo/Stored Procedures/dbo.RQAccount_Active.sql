 /****** Object:  Stored Procedure dbo.RQAccount_Active    Script Date: 12/17/97 10:48:21 AM ******/
Create Procedure RQAccount_Active @Parm1 Varchar(10) as
Select * From Account Where Acct like @parm1 and
Active = 1
Order by Acct


