 /****** Object:  Stored Procedure dbo.APAutoRefNbr    Script Date: 4/7/98 12:19:54 PM ******/
Create Procedure APAutoRefNbr as
Select LastRefNbr from APSetup



GO
GRANT CONTROL
    ON OBJECT::[dbo].[APAutoRefNbr] TO [MSDSL]
    AS [dbo];

