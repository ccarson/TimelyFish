 create procedure ADG_SODiscCode_Descr
	@CpnyID		varchar(10),
	@DiscountID	varchar(1)
as
	-- return the description of the passed discount id
	select	Descr
	from	SODiscCode
	where 	CpnyID = @CpnyID
	  and	DiscountID = @DiscountID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SODiscCode_Descr] TO [MSDSL]
    AS [dbo];

