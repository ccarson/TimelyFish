 Create	Procedure SCM_10400_Initialize_Batch
	@Module		Char(2),
	@BatNbr		VarChar(10),
	@CpnyID		VarChar(10),
	@LUpd_Prog	VarChar(8),
	@LUpd_User	VarChar(10)
As
	Set	NoCount On

	Update	Batch
		Set	CrTot = 0,
			CtrlTot = 0,
			DrTot = 0,
			CuryCrTot = 0,
			CuryCtrlTot = 0,
			CuryDrTot = 0,
			LUpd_DateTime = Convert(SmallDateTime, GetDate()),
			LUpd_Prog = @LUpd_Prog,
			LUpd_User = @LUpd_User,
			Status = 'S'
		Where	Module = @Module
			And BatNbr = @BatNbr
			And CpnyID = @CpnyID
			And Status In ('B', 'H')


