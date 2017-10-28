 Create	Procedure SCM_41440_Upd_IRPlanOrd
	@PlanOrdNbr	VarChar(15),
	@SolDocID	VarChar(15),
	@Status		VarChar(2),
	@LUpd_Prog	VarChar(8),
	@LUpd_User	VarChar(10)
As
	Update	IRPlanOrd
		Set	SolDocID = @SolDocID,
			Status = @Status,
			LUpd_Prog = @LUpd_Prog,
			LUpd_User = @LUpd_User,
			LUpd_DateTime = GetDate()
		Where	PlanOrdNbr = @PlanOrdNbr


