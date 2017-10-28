 /****** Object:  Stored Procedure dbo.SIBuyer_All    Script Date: 12/17/97 10:49:00 AM ******/
Create Procedure SIBuyer_All @Parm1 Varchar(47) as
Select * from SIBuyer WHERE Buyer LIKE @Parm1 Order by Buyer



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SIBuyer_All] TO [MSDSL]
    AS [dbo];

