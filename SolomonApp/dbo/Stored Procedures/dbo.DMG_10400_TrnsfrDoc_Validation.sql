 Create Procedure DMG_10400_TrnsfrDoc_Validation
	/*Begin Parameters*/
	@BatNbr			Varchar(10),
	@ProcessName		Varchar(8),
	@UserName		Varchar(10),
	@UserAddress		Varchar(21)
	/*End Parameters*/
As
	Set NoCount On
	/*
	This procedure will audit the TrnsfrDoc records for a given batch to determine
	if all the necessary fields have values in each of the transaction records.

	Returns:	@True = 1	The procedure executed properly.
			@False = 0	An error occurred.
	*/

-- Error Trapping
DECLARE	@SQLErrorNbr		SmallInt

Declare	@True		Bit,
	@False		Bit
Select	@True 		= 1,
	@False 		= 0

/*
	Solomon Error # 16145 - %s Record (%s) is missing required data in the following field(s):  %s
	This will generate a listing in the event log of every field by record in the batch that has missing fields.
*/

Insert 	Into IN10400_RETURN (BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt, Parm00, Parm01, Parm02)
    Select @BatNbr, @UserAddress, 'DMG_10400_TrnsfrDoc_Validation', 16145, 3, 'TrnsfrDoc', 'TrnsfrDocNbr - ' + TrnsfrDocNbr, 'CPNYID'
            From TrnsfrDoc
            Where   DataLength(RTrim(CpnyID)) = 0
		AND BATNBR = @BATNBR

Insert 	Into IN10400_RETURN (BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt, Parm00, Parm01, Parm02)
    Select @BatNbr, @UserAddress, 'DMG_10400_TrnsfrDoc_Validation', 16145, 3, 'TrnsfrDoc', 'TrnsfrDocNbr - ' + TrnsfrDocNbr, 'SOURCE'
            From TrnsfrDoc
            Where   DataLength(RTrim(SOURCE)) = 0
		AND BATNBR = @BATNBR

Insert 	Into IN10400_RETURN (BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt, Parm00, Parm01, Parm02)
    Select @BatNbr, @UserAddress, 'DMG_10400_TrnsfrDoc_Validation', 16145, 3, 'TrnsfrDoc', 'TrnsfrDocNbr - ' + TrnsfrDocNbr, 'TRANSFERTYPE'
            From TrnsfrDoc
            Where   TransferType Not In ('1', '2')
		AND BATNBR = @BATNBR

Insert 	Into IN10400_RETURN (BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt, Parm00, Parm01, Parm02)
    Select @BatNbr, @UserAddress, 'DMG_10400_TrnsfrDoc_Validation', 16145, 3, 'TrnsfrDoc', 'BatNbr - ' + BatNbr, 'TrnsfrDocNbr'
            From TrnsfrDoc
            Where   DataLength(RTrim(TrnsfrDocNbr)) = 0
		AND BATNBR = @BATNBR

Insert 	Into IN10400_RETURN (BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt, Parm00, Parm01, Parm02)
    Select @BatNbr, @UserAddress, 'DMG_10400_TrnsfrDoc_Validation', 16145, 3, 'TrnsfrDoc', 'TrnsfrDocNbr - ' + TrnsfrDocNbr, 'SITEID'
            From TrnsfrDoc
            Where   (S4Future09 = 0 And DataLength(Rtrim(SiteID)) = 0)
		AND BATNBR = @BATNBR

Insert 	Into IN10400_RETURN (BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt, Parm00, Parm01, Parm02)
    Select @BatNbr, @UserAddress, 'DMG_10400_TrnsfrDoc_Validation', 16145, 3, 'TrnsfrDoc', 'TrnsfrDocNbr - ' + TrnsfrDocNbr, 'TOSITEID'
            From TrnsfrDoc
            Where   DataLength(Rtrim(ToSiteID)) = 0
		AND BATNBR = @BATNBR

Insert 	Into IN10400_RETURN (BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt, Parm00, Parm01, Parm02)
    Select @BatNbr, @UserAddress, 'DMG_10400_TrnsfrDoc_Validation', 16145, 3, 'TrnsfrDoc', 'TrnsfrDocNbr - ' + TrnsfrDocNbr, 'STATUS'
            From TrnsfrDoc
            Where   Status Not In ('P', 'I', 'R')
		AND BATNBR = @BATNBR

IF	EXISTS(SELECT BATNBR FROM IN10400_RETURN WHERE BATNBR = @BATNBR AND COMPUTERNAME = @USERADDRESS)
Begin
/*
	Solomon Error # 16088 - Required field values missing in '%s' record for Batch '%s'.  The batch will not be released.
*/
	Insert 	Into IN10400_RETURN
		(BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt,
		Parm00, Parm01)
	Values
		(@BatNbr, @UserAddress, 'DMG_10400_TrnsfrDoc_Validation', 16088, 2,
		 'TrnsfrDoc', @BatNbr)
	Goto Abort
End
	Goto Finish

Abort:
	Return @False

Finish:
	Return @True



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_10400_TrnsfrDoc_Validation] TO [MSDSL]
    AS [dbo];

