 /****** Object:  Stored Procedure dbo.ARAutoRefNbr    Script Date: 4/7/98 12:30:32 PM ******/
Create Proc ARAutoRefNbr as
    Select LastRefNbr from ARSetup order by SetupId


