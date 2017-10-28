 CREATE PROCEDURE GrantViewPermissions
AS
	Declare @ObjectName sysname
	Declare @userid integer
	Declare query2_cursor cursor for select uid from sysusers where name = 'dbo'
	open query2_cursor
	fetch next from query2_cursor into @userid
	close query2_cursor
	deallocate query2_cursor
	Declare query_cursor CURSOR
	for
	select name from sysobjects where type = 'V' and name like 'vs_%' and uid = @userid order by name
	open query_cursor
		fetch next from query_cursor into @ObjectName
		while (@@FETCH_STATUS <> -1)
		begin
			EXEC ('grant select on [' + @ObjectName + '] to [07718158D19D4f5f9D23B55DBF5DF1]')
			fetch next from query_cursor into @ObjectName
		end
	close query_cursor
	deallocate query_cursor



GO
GRANT CONTROL
    ON OBJECT::[dbo].[GrantViewPermissions] TO [MSDSL]
    AS [dbo];

