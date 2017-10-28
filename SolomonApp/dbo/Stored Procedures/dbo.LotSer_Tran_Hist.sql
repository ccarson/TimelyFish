 Create Proc LotSer_Tran_Hist
	@BatNbr		char(10),
	@INTranLineRef	char(5)
as
	Select	*
	from	LotSerT
	Where	BatNbr = @BatNbr
	  and	INTranLineRef = @INTranLineRef
	Order by
		LotSerNbr,
		RecordID


