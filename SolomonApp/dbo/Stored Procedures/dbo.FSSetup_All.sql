 /****** Object:  Stored Procedure dbo.FSSetup_All    Script Date: 4/7/98 12:45:04 PM ******/
Create Proc FSSetup_All as
     Select * from FSSetup



GO
GRANT CONTROL
    ON OBJECT::[dbo].[FSSetup_All] TO [MSDSL]
    AS [dbo];

