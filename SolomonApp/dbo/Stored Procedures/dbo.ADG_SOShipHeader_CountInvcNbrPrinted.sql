 Create	Procedure ADG_SOShipHeader_CountInvcNbrPrinted
	@CpnyID		VarChar(10),
	@InvcNbr	VarChar(10),
	@RI_ID		SmallInt

As
	Declare	@CountSH	Integer
	Declare	@CountPQ	Integer
	Declare	@CountSE	Integer

	Select	@CountSH = Count(*)
		From	SOShipHeader (NOLOCK)
		Where	CpnyID = @CpnyID
			And InvcNbr = @InvcNbr
			And Cancelled = 0
			And ConsolInv = 0
	Select	@CountPQ = Count(*)
		From	SOPrintQueue (NOLOCK)
		Where	CpnyID = @CpnyID
			And InvcNbr = @InvcNbr
			And RI_ID <> @RI_ID
	Select	@CountSE = Count(*)
		From	SOEvent (NOLOCK)
		Where	CpnyID = @CpnyID
			And InvcNbr = @InvcNbr
			And EventType = 'PINV'
	Select	InvcCnt = Coalesce(@CountSH, 0) + Coalesce(@CountPQ, 0) +  Coalesce(@CountSE, 0)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SOShipHeader_CountInvcNbrPrinted] TO [MSDSL]
    AS [dbo];

