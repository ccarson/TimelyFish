
Create Proc  Fetch_BRPerNbr as
Select PerNbr from BRSetup (NOLOCK)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Fetch_BRPerNbr] TO [MSDSL]
    AS [dbo];

