 Create Procedure IRPlanOrd_DelUnFirmed AS
	Delete from IRPlanOrd where status in ('UF')


