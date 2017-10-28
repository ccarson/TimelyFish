 create proc ADG_OrdTot_DelTax
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15)
as
	delete		SOTax
	where		CpnyID = @CpnyID
	  and		OrdNbr = @OrdNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_OrdTot_DelTax] TO [MSDSL]
    AS [dbo];

