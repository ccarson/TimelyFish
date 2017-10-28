 CREATE PROCEDURE GrantReportUserPermissions @ObjectType sysname, @UserName sysname
AS
	Declare @ObjectName sysname
	Declare @permType  varchar(10)
	Declare @userid integer
	Declare query2_cursor cursor for select uid from sysusers where name = 'dbo'
	open query2_cursor
	fetch next from query2_cursor into @userid
	close query2_cursor
	deallocate query2_cursor
	Declare query_cursor CURSOR
	for
	select name from sysobjects where type = @ObjectType and uid = @userid order by name
	if (@ObjectType in ('FN', 'P') )
	begin
		select @permType = 'Execute'
	end
	else
	begin
	 	select @permType = 'Select'
	end
	open query_cursor
		fetch next from query_cursor into @ObjectName
		while (@@FETCH_STATUS <> -1)
		begin
			EXEC ('grant ' + @permType  + ' on [' + @ObjectName + '] to [' + @UserName + ']')
			fetch next from query_cursor into @ObjectName
		end
	close query_cursor
	deallocate query_cursor

	if (@ObjectType = 'V')
	begin
		declare ct_query_cursor cursor
		for
		select t.name from sys.tables t join sys.change_tracking_tables ctt on t.object_id = ctt.object_id
		open ct_query_cursor
			fetch next from ct_query_cursor into @ObjectName
			while (@@FETCH_STATUS <> -1)
			begin
				EXEC ('grant view change tracking on [' + @ObjectName + '] to [' + @UserName + ']')
				fetch next from ct_query_cursor into @ObjectName
			end
		close ct_query_cursor
		deallocate ct_query_cursor
	end

GO
GRANT CONTROL
    ON OBJECT::[dbo].[GrantReportUserPermissions] TO [MSDSL]
    AS [dbo];

