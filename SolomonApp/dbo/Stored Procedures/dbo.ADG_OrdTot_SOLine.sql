 create proc ADG_OrdTot_SOLine
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15)
as
	select	*
	from	SOLine
	where	CpnyID = @CpnyID
	  and	OrdNbr = @OrdNbr
	  and	Status = 'O'

	order by
		LineRef

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_OrdTot_SOLine] TO [MSDSL]
    AS [dbo];

