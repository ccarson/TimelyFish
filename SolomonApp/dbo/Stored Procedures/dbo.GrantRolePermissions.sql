 CREATE PROCEDURE GrantRolePermissions @ObjectType sysname, @RoleName sysname
AS
	Declare @ObjectName sysname
	Declare @permission varchar(10)

        select @permission = 'CONTROL'
	Declare @userid integer
	Declare query2_cursor cursor for select uid from sysusers where name = 'dbo'
	open query2_cursor
	fetch next from query2_cursor into @userid
	close query2_cursor
	deallocate query2_cursor
	Declare query_cursor CURSOR
	for
	select name from sysobjects where type = @ObjectType and uid = @userid order by name
	open query_cursor
		fetch next from query_cursor into @ObjectName
		while (@@FETCH_STATUS <> -1)
		begin
			EXEC ('grant ' + @permission + ' on [' + @ObjectName + '] to [' + @RoleName + ']')
			fetch next from query_cursor into @ObjectName
		end
	close query_cursor
	deallocate query_cursor



GO
GRANT CONTROL
    ON OBJECT::[dbo].[GrantRolePermissions] TO [MSDSL]
    AS [dbo];

