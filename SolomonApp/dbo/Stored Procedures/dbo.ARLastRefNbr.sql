 /****** Object:  Stored Procedure dbo.ARLastRefNbr    Script Date: 4/7/98 12:30:33 PM ******/
Create Proc ARLastRefNbr as
    Select LastRefNbr from ARSetup order by SetupId


