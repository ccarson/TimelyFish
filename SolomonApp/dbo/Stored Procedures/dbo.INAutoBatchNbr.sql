 /****** Object:  Stored Procedure dbo.INAutoBatchNbr    Script Date: 4/17/98 10:58:17 AM ******/
/****** Object:  Stored Procedure dbo.INAutoBatchNbr    Script Date: 4/16/98 7:41:51 PM ******/
Create Proc INAutoBatchNbr as
    Select LastBatNbr from INSetup order by SetupId


