 /****** Object:  Stored Procedure dbo.Fetch_PRPerNbr    Script Date: 02/14/01 12:15:04 PM ******/
Create Proc  Fetch_PRPerNbr as
Select PerNbr from PRSetup (NOLOCK)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Fetch_PRPerNbr] TO [MSDSL]
    AS [dbo];

