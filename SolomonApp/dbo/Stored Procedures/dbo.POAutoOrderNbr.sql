 /****** Object:  Stored Procedure dbo.POAutoOrderNbr    Script Date: 4/16/98 7:50:25 PM ******/
Create Proc POAutoOrderNbr as
    Select LastPONbr from POSetup order by SetupId


