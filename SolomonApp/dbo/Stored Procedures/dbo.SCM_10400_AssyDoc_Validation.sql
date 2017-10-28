 Create Procedure SCM_10400_AssyDoc_Validation
	@BatNbr		VarChar(10),
	@CpnyID		VarChar(10),
	@KitID		VarChar(30),
	@RefNbr		VarChar(15),
	@ValMthd	Char(1),
	@ProcessName	Varchar(8),
	@UserName	Varchar(10),
	@UserAddress	Varchar(21)
As
	Set NoCount On
	/*
	This procedure will audit the Assemby Document records for a given batch to determine
	if all the necessary fields have values in each of the transaction records.
	*/

/*
	Solomon Error # 16088 - Required field values missing in '%s' record for Batch '%s'.  The batch will not be released.
*/
	Insert 	Into IN10400_RETURN
		(BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt, Parm00, Parm01)
	Select	@BatNbr, @UserAddress, 'SCM_10400_AssyDoc_Validation', 16088, 2, 'AssyDoc', @BatNbr
		From	AssyDoc (NoLock)
		Join 	Inventory on AssyDoc.KitId = Inventory.InvtID
		Where	BatNbr = @BatNbr
			And (Len(RTrim(CpnyID)) = 0
			Or Len(RTrim(KitID)) = 0
			Or Len(RTrim(RefNbr)) = 0
			Or Len(RTrim(PerPost)) = 0
			Or Len(RTrim(SiteID)) = 0
			Or Len(RTrim(WhseLoc)) = 0
			Or (Len(RTrim(AssyDoc.SpecificCostID)) = 0 And Inventory.ValMthd = 'S'))

/*
	Solomon Error # 16145 - %s Record (%s) is missing required data in the following field(s):  %s
	This will generate a listing in the event log of every field by record in the batch that has missing fields.
*/
	Insert 	Into IN10400_RETURN
		(BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt, Parm00, Parm01, Parm02)
	Select Distinct
		@BatNbr, @UserAddress, 'SCM_10400_AssyDoc_Validation', 16145, 3, 'AssyDoc', 'BatNbr: ' + BatNbr, 'CpnyID'
	        From	AssyDoc (NoLock)
	        Where   Len(RTrim(CpnyID)) = 0
			And BatNbr = @BatNbr
		Insert 	Into IN10400_RETURN
		(BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt, Parm00, Parm01, Parm02)
	Select Distinct
		@BatNbr, @UserAddress, 'SCM_10400_AssyDoc_Validation', 16145, 3, 'AssyDoc', 'BatNbr: ' + BatNbr, 'KitID'
	        From	AssyDoc (NoLock)
	        Where   Len(RTrim(KitID)) = 0
			And BatNbr = @BatNbr

	Insert 	Into IN10400_RETURN
		(BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt, Parm00, Parm01, Parm02)
	Select Distinct
		@BatNbr, @UserAddress, 'SCM_10400_AssyDoc_Validation', 16145, 3, 'AssyDoc', 'BatNbr: ' + BatNbr, 'RefNbr'
	        From	AssyDoc (NoLock)
	        Where   Len(RTrim(RefNbr)) = 0
			And BatNbr = @BatNbr

	Insert 	Into IN10400_RETURN
		(BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt, Parm00, Parm01, Parm02)
	Select Distinct
		@BatNbr, @UserAddress, 'SCM_10400_AssyDoc_Validation', 16145, 3, 'AssyDoc', 'BatNbr: ' + BatNbr, 'PerPost'
	        From	AssyDoc (NoLock)
	        Where   KitID = @KitID
			And RefNbr = @RefNbr
			And BatNbr = @BatNbr
			And CpnyID = @CpnyID
			And Len(RTrim(PerPost)) = 0

	Insert 	Into IN10400_RETURN
		(BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt, Parm00, Parm01, Parm02)
	Select Distinct
		@BatNbr, @UserAddress, 'SCM_10400_AssyDoc_Validation', 16145, 3, 'AssyDoc', 'BatNbr: ' + BatNbr, 'SiteID'
	        From	AssyDoc (NoLock)
	        Where   KitID = @KitID
			And RefNbr = @RefNbr
			And BatNbr = @BatNbr
			And CpnyID = @CpnyID
			And Len(RTrim(SiteID)) = 0

	Insert 	Into IN10400_RETURN
		(BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt, Parm00, Parm01, Parm02)
	Select Distinct
		@BatNbr, @UserAddress, 'SCM_10400_AssyDoc_Validation', 16145, 3, 'AssyDoc', 'BatNbr: ' + BatNbr, 'WhseLoc'
	        From	AssyDoc (NoLock)
	        Where   KitID = @KitID
			And RefNbr = @RefNbr
			And BatNbr = @BatNbr
			And CpnyID = @CpnyID
			And Len(RTrim(WhseLoc)) = 0

	Insert 	Into IN10400_RETURN
		(BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt, Parm00, Parm01, Parm02)
	Select Distinct
		@BatNbr, @UserAddress, 'SCM_10400_AssyDoc_Validation', 16145, 3, 'AssyDoc', 'BatNbr: ' + BatNbr, 'SpecificCostID'
	        From	AssyDoc (NoLock)
	        Where   KitID = @KitID
			And RefNbr = @RefNbr
			And BatNbr = @BatNbr
			And CpnyID = @CpnyID
			And @ValMthd = 'S'
			And Len(RTrim(SpecificCostID)) = 0



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_10400_AssyDoc_Validation] TO [MSDSL]
    AS [dbo];

