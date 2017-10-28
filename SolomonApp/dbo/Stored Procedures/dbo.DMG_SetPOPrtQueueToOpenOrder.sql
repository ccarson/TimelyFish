 create proc DMG_SetPOPrtQueueToOpenOrder
	@ri_id		smallint
as
	update	PurchOrd
	Set	Status = 'O'
	Where	Status = 'P'
	and	PONbr In (select PONbr from poprintqueue where RI_ID = @ri_id)

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SetPOPrtQueueToOpenOrder] TO [MSDSL]
    AS [dbo];

