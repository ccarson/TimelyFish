 /****** Object:  Stored Procedure dbo.ARAutoBatchNbr    Script Date: 4/7/98 12:30:32 PM ******/
Create Proc ARAutoBatchNbr as
    Select LastBatNbr from ARSetup order by SetupId


