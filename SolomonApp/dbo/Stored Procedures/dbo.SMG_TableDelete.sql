
create procedure SMG_TableDelete

as
	declare @TblName varchar(30)

	declare SMGCursor cursor for select name from sysobjects where substring(name,1,6) = "SMGOld" and  sysstat & 0xf = 3

	open SMGCursor
	fetch next from SMGCursor into @TblName

	while (@@fetch_status = 0)
	begin
		exec("drop table " + @TblName)

		fetch next from SMGCursor into @TblName
	end

	close SMGCursor
	deallocate SMGCursor

GO
GRANT CONTROL
    ON OBJECT::[dbo].[SMG_TableDelete] TO [MSDSL]
    AS [dbo];

