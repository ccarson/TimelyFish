 Create	Procedure SCM_10400_Upd_INTran_InSuffQty
	@RecordID	Integer,
	@QtyUnCosted	Float,
	@InSuffQty	SmallInt,
	@LUpd_Prog	Varchar(8),
	@LUpd_User	Varchar(10)
As
	Update	INTran
		Set	QtyUnCosted = @QtyUnCosted,
			InSuffQty = @InSuffQty,
			LUpd_Prog = @LUpd_Prog,
			LUpd_User = @LUpd_User
		Where	RecordID = @RecordID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_10400_Upd_INTran_InSuffQty] TO [MSDSL]
    AS [dbo];

