 Create Procedure DMG_10400_AssyDoc_Validation
	/*Begin Parameters*/
	@BatNbr			Varchar(10),
	@ProcessName		Varchar(8),
	@UserName		Varchar(10),
	@UserAddress		Varchar(21)
	/*End Parameters*/
As
	Set NoCount On
	/*
	This procedure will audit the Assemby Document records for a given batch to determine
	if all the necessary fields have values in each of the transaction records.

	Returns:	@True = 1	The procedure executed properly.
			@False = 0	An error occurred.
	*/

-- Error Trapping
DECLARE
	@SQLErrorNbr		SmallInt

Declare	@True		Bit,
	@False		Bit
Select	@True 		= 1,
	@False 		= 0

If Exists(Select *
		From 	AssyDoc
	   	Where 	BatNbr = @BatNbr
	 		And (DataLength(RTrim(CpnyID)) = 0
			Or DataLength(RTrim(KitID)) = 0
			Or DataLength(RTrim(RefNbr)) = 0
			Or DataLength(RTrim(PerPost)) = 0
			Or DataLength(RTrim(SiteID)) = 0)
			Or DataLength(RTrim(WhseLoc)) = 0)
	Or Exists(Select *
			From 	AssyDoc Join Inventory
				On AssyDoc.KitID = Inventory.InvtID
			Where	(DataLength(RTrim(AssyDoc.SpecificCostID)) = 0
				AND AssyDoc.BatNbr = @BatNbr
				And Inventory.ValMthd = 'S'))

Begin
/*
	Solomon Error # 16088 - Required field values missing in '%s' record for Batch '%s'.  The batch will not be released.
*/
	Insert 	Into IN10400_RETURN
		(BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt,
		Parm00, Parm01)
	Values
		(@BatNbr, @UserAddress, 'DMG_10400_AssyDoc_Validation', 16088, 2,
		 'AssyDoc', @BatNbr)
/*
	Solomon Error # 16145 - %s Record (%s) is missing required data in the following field(s):  %s
	This will generate a listing in the event log of every field by record in the batch that has missing fields.
*/
	Insert 	Into IN10400_RETURN
		(BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt,
		Parm00, Parm01, Parm02)
	Select	@BatNbr, @UserAddress, 'DMG_10400_AssyDoc_Validation', 16145, 3,
		'AssyDoc', 'BatNbr: ' + BatNbr, Field
		From	vp_10400_AssyDoc_Validation
		Where	BatNbr = @BatNbr
		Order By BatNbr, Field

	Goto Abort
End

Goto Finish

Abort:
	Return @False

Finish:
	Return @True



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_10400_AssyDoc_Validation] TO [MSDSL]
    AS [dbo];

