 Create	Procedure SCM_Demand_Descr
	@DemandID	VarChar(10)
As
	Select	Descr
		From	IRDemHeader (NoLock)
		Where	DemandID = @DemandID


