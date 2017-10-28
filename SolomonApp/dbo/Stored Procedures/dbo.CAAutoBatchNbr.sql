 /****** Object:  Stored Procedure dbo.CAAutoBatchNbr    Script Date: 4/7/98 12:49:20 PM ******/
Create Procedure CAAutoBatchNbr as
Select LastBatNbr from CASetup order by SetupId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[CAAutoBatchNbr] TO [MSDSL]
    AS [dbo];

