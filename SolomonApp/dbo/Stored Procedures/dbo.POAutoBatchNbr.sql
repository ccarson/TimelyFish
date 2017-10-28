 /****** Object:  Stored Procedure dbo.POAutoBatchNbr    Script Date: 4/16/98 7:50:25 PM ******/
Create Proc POAutoBatchNbr as
    Select LastBatNbr from POSetup order by SetupId


