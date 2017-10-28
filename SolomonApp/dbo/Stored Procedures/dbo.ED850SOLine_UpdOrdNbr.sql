 Create Proc ED850SOLine_UpdOrdNbr @CpnyId varchar(10), @OldOrdNbr varchar(15), @NewOrdNbr varchar(15)
As
	Update ED850SOLine
	Set OrdNbr = @NewOrdNbr
	Where 	CpnyId = @CpnyId And
		OrdNbr = @OldOrdNbr


