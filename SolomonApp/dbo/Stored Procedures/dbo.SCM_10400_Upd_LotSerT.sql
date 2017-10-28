 Create Procedure SCM_10400_Upd_LotSerT
	/*Begin Process Parameter Group*/
	@BatNbr			Varchar(10),
	@ProcessName		Varchar(8),
	@UserName		Varchar(10),
	@UserAddress		Varchar(21),
	/*End Process Parameter Group*/
	/*Begin Values Parameter Group*/
	@CpnyID			Varchar(10),
	@INTranLineRef		Varchar(5),
	@SiteID			Varchar(10),
	@TranType		Char(10),
	@Rlsed			Smallint,
	@WarrantyDays		SmallInt
	/*End Values Parameter Group*/
As
	Set NoCount On
	/*
	Parameters are grouped together functionally.

	This procedure will update the quantity on hand (QTYONHAND) and quantity shipped
	not invoiced for the record matching the primary key fields passed as parameters.
	The primary key fields in the LotSerT table define a specific warehouse storage
	LotSerT.

	Automatically determines if record to be updated exists.

	Returns:	@True = 1	The procedure executed properly.
			@False = 0	An error occurred.
	*/

	Declare	@True		Bit,
		@False		Bit
	Select	@True 		= 1,
		@False 		= 0

	Declare	@SQLErrNbr	SmallInt,
		@ReturnStatus	Bit
	Select	@SQLErrNbr	= 0,
		@ReturnStatus	= @True

	/*
	Update the released status.
	*/
	Update	LotSerT
		Set	Rlsed = @Rlsed,
			LUpd_DateTime = Convert(SmallDateTime, GetDate()),
			LUpd_Prog = @ProcessName,
			LUpd_User = @UserName,
			WarrantyDate =	Case	When	@WarrantyDays > 0
							Then	Convert(SmallDateTime, DateAdd(dd, @WarrantyDays, GetDate()))
						Else	WarrantyDate
					End
		Where	BatNbr = @BatNbr
			And CpnyID = @CpnyID
			And INTranLineRef = @INTranLineRef
			And SiteID = @SiteID
			And TranType = @TranType

	Select @SQLErrNbr = @@Error
	If @SQLErrNbr <> 0
	Begin
		Insert 	Into IN10400_RETURN
				(BatNbr, ComputerName, S4Future01, SQLErrorNbr, ParmCnt,
				Parm00, Parm01, Parm02, Parm03, Parm04)
			Values
				(@BatNbr, @UserAddress, 'SCM_10400_Upd_LotSerT', @SQLErrNbr, 5,
				 @BatNbr, @CpnyID, @INTranLineRef, @SiteID, @TranType)
		Goto Abort
	End

Goto Finish

Abort:
	Return @False

Finish:
	Return @True



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_10400_Upd_LotSerT] TO [MSDSL]
    AS [dbo];

