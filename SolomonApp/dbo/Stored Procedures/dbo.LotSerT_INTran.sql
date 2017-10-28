 Create Procedure LotSerT_INTran
	@BatNbr			Varchar(10),
	@CpnyID			Varchar(10),
	@INTranLineRef		Char(5),
	@InvtID			Varchar(21),
	@SiteID			Varchar(10),
	@WhseLoc		Varchar(10)
As
	Select	*
		From	LotSerT
		Where	BatNbr = @BatNbr
			And CpnyID = @CpnyID
			And INTranLineRef = @INTranLineRef
			And InvtID = @InvtID
			And SiteID = @SiteID
			And WhseLoc = @WhseLoc
			And Rlsed = 0
		Order By RecordID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[LotSerT_INTran] TO [MSDSL]
    AS [dbo];

