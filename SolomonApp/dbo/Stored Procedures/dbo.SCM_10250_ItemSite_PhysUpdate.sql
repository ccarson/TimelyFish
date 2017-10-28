 Create Procedure SCM_10250_ItemSite_PhysUpdate
	@ABCCode VarChar(2),
	@CycleID VarChar (10),
	@Invtid VarChar(30),
	@Lupd_Prog VarChar(8),
	@Lupd_User VarChar(10),
	@MoveClass VarChar(10)
	AS
	Update	ItemSite
		Set
			MoveClass = @MoveClass,
			CycleID = @CycleID,
			ABCCode = @ABCCode,
			LUpd_DateTime = GetDate(),
			Lupd_Prog = @Lupd_Prog,
			Lupd_User = @Lupd_User
		Where
			InvtID = @InvtId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_10250_ItemSite_PhysUpdate] TO [MSDSL]
    AS [dbo];

