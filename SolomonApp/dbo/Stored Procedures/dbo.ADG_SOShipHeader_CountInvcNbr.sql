 Create	Procedure ADG_SOShipHeader_CountInvcNbr
	@CpnyID		VarChar(10),
	@InvcNbr	VarChar(10)

As
	Declare	@Count	Integer
	Set	@Count = 0

	Select	@Count = Count(*)
		From	SOShipHeader
		Where	CpnyID = @CpnyID
			And InvcNbr = @InvcNbr
			And Cancelled = 0
	Select	InvcCnt = Coalesce(@Count, 0)

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SOShipHeader_CountInvcNbr] TO [MSDSL]
    AS [dbo];

