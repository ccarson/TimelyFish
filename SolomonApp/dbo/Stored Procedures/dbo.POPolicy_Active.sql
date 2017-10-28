 /****** Object:  Stored Procedure dbo.POPolicy_Active    Script Date: 12/17/97 10:48:35 AM ******/
Create Procedure POPolicy_Active @Parm1 Varchar(10) as
Select * from POPolicy where PolicyID like @Parm1
And Status = 'A'
Order by PolicyID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POPolicy_Active] TO [MSDSL]
    AS [dbo];

