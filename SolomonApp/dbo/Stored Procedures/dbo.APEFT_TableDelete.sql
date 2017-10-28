
create procedure APEFT_TableDelete

as
	declare @TblName varchar(30)

	declare MMGCursor cursor for select name from sysobjects where substring(name,1,8) = 'APEFTOld' and  sysstat & 0xf = 3

	open MMGCursor
	fetch next from MMGCursor into @TblName

	while (@@fetch_status = 0)
	begin
		exec('drop table ' + @TblName)

		fetch next from MMGCursor into @TblName
	end

	close MMGCursor
	deallocate MMGCursor
