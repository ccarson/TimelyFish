 Create Procedure IRSetup_UpdUsgCaptParms @LastCalcDate SmallDateTime, @LastUserID VarChar(10) AS
	Update IRSetup set
		DemTranTime = getdate(),
		DemTranDate = @LastCalcDate,
		DemTranUserID = @LastUserID


