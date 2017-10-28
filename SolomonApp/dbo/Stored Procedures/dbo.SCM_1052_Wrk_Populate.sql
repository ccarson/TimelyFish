 Create Proc SCM_1052_Wrk_Populate
	@ComputerName 	Varchar(21),
	@UpdateOption	Varchar(1)
As
/*
	This procedure will populate the IN10520_Wrk table with records from Inventory and ProductClass
	Returns:	@True = 1	The procedure executed properly.
			@False = 0	An error occurred.
	*/

	Declare	@True		Bit,
		@False		Bit
	Select	@True 		= 1,
		@False 		= 0

	Declare	@SQLErrNbr	SmallInt
	Select	@SQLErrNbr	= 0

	Set	NoCount On

	If @UpdateOption = 'I' 	/* ItemPendingCost */
	Begin
		Insert	Into IN10520_Wrk
				(ClassID,ComputerName,Crtd_DateTime,InvtID)
		Select	'',@ComputerName,Crtd_DateTime,InvtID
			From	Inventory(NoLock)
			Where ValMthd = 'T'
	End
	Else
	If @UpdateOption = 'P' /* ProdClsMatOvrheadRate */
	Begin
		Insert	Into IN10520_Wrk
				(ClassID,ComputerName,Crtd_DateTime,InvtID)
		Select	ClassID,@ComputerName,Crtd_DateTime,''
			From	ProductClass(NoLock)
	End

    	Select @SQLErrNbr = @@Error
	If @SQLErrNbr <> 0
	Begin
		Goto Abort
  	End

Goto Finish

Abort:
	Return @False

Finish:
	Return @True



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_1052_Wrk_Populate] TO [MSDSL]
    AS [dbo];

