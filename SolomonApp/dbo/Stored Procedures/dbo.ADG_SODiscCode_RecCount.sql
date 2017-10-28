 create procedure ADG_SODiscCode_RecCount
	@CpnyID		varchar(10),
	@DiscountID	varchar(1)
as

	-- return the count of the records that match the discount id
	select	count(*)
	from	SODiscCode
	where 	CpnyID = @CpnyID
	  and	DiscountID = @DiscountID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SODiscCode_RecCount] TO [MSDSL]
    AS [dbo];

