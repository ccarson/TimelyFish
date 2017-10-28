
create procedure ADG_TableDelete

as
	declare @TblName varchar(30)

	declare DMGCursor cursor for select name from sysobjects where substring(name,1,6) = 'DMGOld' and  sysstat & 0xf = 3

	open DMGCursor
	fetch next from DMGCursor into @TblName

	while (@@fetch_status = 0)
	begin
		exec('drop table ' + @TblName)

		fetch next from DMGCursor into @TblName
	end

	close DMGCursor
	deallocate DMGCursor

GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_TableDelete] TO [MSDSL]
    AS [dbo];

