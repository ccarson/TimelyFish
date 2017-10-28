 create procedure DMG_RebuildIndexes
as

	declare @Table varchar(255)

	-- Loop through all the objects that are tables
	declare TempCursor cursor for select Name from SysObjects Where Type = 'U'
	open TempCursor
	fetch next from TempCursor into @Table

	while (@@fetch_status = 0)
	begin
		select 'Rebuilding Indexes for Table : ' + @Table
		dbcc dbreindex(@Table, '', 0)

		fetch next from TempCursor into @Table
	end

	close TempCursor
	deallocate TempCursor

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_RebuildIndexes] TO [MSDSL]
    AS [dbo];

