
create procedure PMG_TableDelete

as
	declare @TblName varchar(30)

	declare PMGCursor cursor for select name from sysobjects where substring(name,1,6) = "PMGOld" and  sysstat & 0xf = 3

	open PMGCursor
	fetch next from PMGCursor into @TblName

	while (@@fetch_status = 0)
	begin
		exec("drop table " + @TblName)

		fetch next from PMGCursor into @TblName
	end

	close PMGCursor
	deallocate PMGCursor

GO
GRANT CONTROL
    ON OBJECT::[dbo].[PMG_TableDelete] TO [MSDSL]
    AS [dbo];

