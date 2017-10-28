 create proc ADG_SO40600_wrk_Delete
	@ri_id		smallint

as

	-- Delete all records with the current ri_id out of SOPrintQueue.
	delete from SO40600_Wrk where ri_id = @ri_id

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SO40600_wrk_Delete] TO [MSDSL]
    AS [dbo];

