 /****** Object:  Stored Procedure dbo.AllModule_PerNbrs    Script Date: 4/17/98 12:50:25 PM ******/
/****** Object:  Stored Procedure dbo.AllModule_PerNbrs    Script Date: 4/7/98 12:56:04 PM ******/
Create Proc  AllModule_PerNbrs as
EXEC Fetch_GLPerNbr
EXEC Fetch_PRPerNbr
EXEC Fetch_APPerNbr
EXEC Fetch_PCPerNbr
EXEC Fetch_ARPerNbr
EXEC Fetch_INPerNbr
EXEC Fetch_CAPerNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[AllModule_PerNbrs] TO [MSDSL]
    AS [dbo];

