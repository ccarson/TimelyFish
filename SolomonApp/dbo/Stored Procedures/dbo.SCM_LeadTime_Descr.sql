 Create	Procedure SCM_LeadTime_Descr
	@LeadTimeID	VarChar(10)
As
	Select	Descr
		From	IRLTHeader (NoLock)
		Where	LeadTimeID = @LeadTimeID


