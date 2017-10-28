 /****** Object:  Stored Procedure dbo.Fetch_PCPerNbr    Script Date: 02/14/01 12:15:04 PM ******/
Create Proc  Fetch_PCPerNbr as
Select PerNbr from PCSetup (NOLOCK)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Fetch_PCPerNbr] TO [MSDSL]
    AS [dbo];

