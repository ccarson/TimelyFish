 Create	Procedure SCM_10400_KitComp_Complete
	@BatNbr	VarChar(10),
	@CpnyID	VarChar(10),
	@KitID	VarChar(30),
	@RefNbr	VarChar(15)
As

	If	Exists(	Select	*
				From	INTran (NoLock)
				Where	BatNbr = @BatNbr
					And KitID = @KitID
					And CpnyID = @CpnyID
					And RefNbr = @RefNbr
					And Rlsed = 0)
		Select	Result = Cast(0 As SmallInt)
	Else
		Select	Result = Cast(1 As SmallInt)


