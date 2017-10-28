 Create	Procedure SCM_41440_PopulateDocID
	@SolDocID	VarChar(15),
	@UnAssignedID	varchar(15)
As
	Update	IRPlanOrd
		Set	SolDocID = @SolDocID,
			LUpd_DateTime = GetDate()
		Where	SolDocID = @UnAssignedID
			AND Status = 'CO'


