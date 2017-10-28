 create procedure DMG_10990_Upd_INTran_LotSerCntr
	@InvtIDParm VARCHAR (30)
AS

   	Declare	@INTranInvtID	varchar (30),
		@INTranBatNbr	varchar (10),
		@InvInvtID	Varchar (30)

   	Declare INTran_Cursor Cursor Local for
		Select DISTINCT INTran.InvtID, INTran.BatNbr, Inventory.InvtID from INTran, Inventory
		Where 	INTran.LotSerCntr = 0
			And INTran.S4Future05 = 0
			And INTran.InvtID = Inventory.InvtID
			AND INTran.InvtID LIKE @InvtIDParm
			And Inventory.LotSerTrack <> 'NN'
			And (Select Count(*) from LotSerT
				Where 	INTran.BatNbr = LotSerT.BatNbr
					And INTran.InvtID = LotSerT.InvtID) > 0

	Open INTran_Cursor
	Fetch Next From INTran_Cursor Into
		@INTranInvtID,
		@INTranBatNbr,
		@InvInvtID

	While (@@fetch_status = 0)
	Begin

		Update INTran
			Set LotSerCntr = (Select Count(*) from LotSerT
						Where 	LotSerT.BatNbr = @INTranBatNbr
							And LotSerT.InvtID = @INTranInvtID)
			Where 	INTran.BatNbr = @INTranBatNbr
				And INTran.InvtID = @INTranInvtID
			Fetch Next From	INTran_Cursor Into
			@INTranInvtID,
			@INTranBatNbr,
			@InvInvtID

	End

	close INTran_Cursor
	deallocate INTran_Cursor


