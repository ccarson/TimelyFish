 /****** Object:  Stored Procedure dbo.APAutoBatchNbr    Script Date: 4/7/98 12:19:54 PM ******/
Create Procedure APAutoBatchNbr as
Select LastBatNbr from APSetup



GO
GRANT CONTROL
    ON OBJECT::[dbo].[APAutoBatchNbr] TO [MSDSL]
    AS [dbo];

