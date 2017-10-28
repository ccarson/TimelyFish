 /****** Object:  Stored Procedure dbo.GLAutoBatchNbr    Script Date: 4/7/98 12:38:58 PM ******/
Create Proc GLAutoBatchNbr as
    Select LastBatNbr from GLSetup order by SetupId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[GLAutoBatchNbr] TO [MSDSL]
    AS [dbo];

