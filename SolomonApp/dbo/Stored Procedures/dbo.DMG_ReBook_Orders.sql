 create procedure DMG_ReBook_Orders
as
	declare @CpnyID varchar(10)
	declare @Ordnbr varchar(15)

	-- Loop through each sales order
	declare TempCursor cursor for select CpnyID, OrdNbr from SOHeader
	open TempCursor
	fetch next from TempCursor into @CpnyID, @OrdNbr

	while (@@fetch_status = 0)
	begin
		execute ADG_Book_Order @CpnyID, @OrdNbr

		execute DMG_Book_Order_Misc @CpnyID, @OrdNbr

		fetch next from TempCursor into @CpnyID, @OrdNbr
	end

	close TempCursor
	deallocate TempCursor

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_ReBook_Orders] TO [MSDSL]
    AS [dbo];

