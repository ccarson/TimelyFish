 /****** Object:  Stored Procedure dbo.POAutoRcptNbr    Script Date: 4/16/98 7:50:25 PM ******/
Create Proc POAutoRcptNbr as
    Select LastRcptNbr from POSetup order by SetupId


