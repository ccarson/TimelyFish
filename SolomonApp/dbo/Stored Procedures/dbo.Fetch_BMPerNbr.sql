
Create Proc  Fetch_BMPerNbr as
Select PerNbr from BMSetup (NOLOCK)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Fetch_BMPerNbr] TO [MSDSL]
    AS [dbo];

