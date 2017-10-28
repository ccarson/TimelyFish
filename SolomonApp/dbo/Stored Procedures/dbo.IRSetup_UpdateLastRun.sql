 Create Procedure IRSetup_UpdateLastRun @LastProcessDate SmallDateTime, @LastStartDate SmallDateTime, @LastUserID VarChar(10) AS
	Update IRSetup set
		PlanOrdTime = getdate(),
		PlanOrdDate = @LastProcessDate,
		PlanOrdUserID = @LastUserID,
		PlanOrdStartDate = @LastStartDate


