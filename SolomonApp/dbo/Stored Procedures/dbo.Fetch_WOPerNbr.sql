
Create Proc  Fetch_WOPerNbr as
Select PerNbr from WOSetup (NOLOCK)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Fetch_WOPerNbr] TO [MSDSL]
    AS [dbo];

