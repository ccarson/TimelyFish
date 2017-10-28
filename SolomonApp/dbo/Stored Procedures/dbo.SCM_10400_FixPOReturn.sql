 Create	Procedure SCM_10400_FixPOReturn
	@BatNbr		VarChar(10),
	@LUpd_Prog	VarChar(8),
	@LUpd_User	VarChar(10)
As
	Update	LotSerT
		Set	TranType = 'II',
			LUpd_DateTime = Cast(GetDate() As SmallDateTime),
			LUpd_Prog = @LUpd_Prog,
			LUpd_User = @LUpd_User
		Where	BatNbr = @BatNbr
			And TranType = 'RC'
			And TranSrc = 'PO'
			And (InvtMult * Qty) < 0



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_10400_FixPOReturn] TO [MSDSL]
    AS [dbo];

