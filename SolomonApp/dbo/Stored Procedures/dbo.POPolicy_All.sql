 /****** Object:  Stored Procedure dbo.POPolicy_All    Script Date: 12/17/97 10:48:41 AM ******/
Create Procedure POPolicy_All @Parm1 Varchar(10) as
Select * from POPolicy Where PolicyID like @Parm1
Order by PolicyId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POPolicy_All] TO [MSDSL]
    AS [dbo];

