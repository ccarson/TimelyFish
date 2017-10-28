 Create Procedure GrantBFGRoup As

    IF exists( select * from sysusers where name = 'BFGROUP' and issqlrole = 1 )
    BEGIN
	-- Tables
	DECLARE tnames_cursor CURSOR
	FOR
	   SELECT TABLE_NAME
	   FROM INFORMATION_SCHEMA.TABLES
	OPEN tnames_cursor
	DECLARE @tablename sysname
	FETCH NEXT FROM tnames_cursor INTO @tablename
	WHILE (@@FETCH_STATUS <> -1)
	BEGIN
	   IF (@@FETCH_STATUS <> -2)
	   BEGIN
	       Exec( 'Grant Select,Insert,Update,Delete on [' + @tablename + '] to BFGROUP' )
	   END
	   FETCH NEXT FROM tnames_cursor INTO @tablename
	END
	CLOSE tnames_cursor
	DEALLOCATE tnames_cursor

	-- Views
	DECLARE vnames_cursor CURSOR
	FOR
	   SELECT TABLE_NAME FROM INFORMATION_SCHEMA.VIEWS
	OPEN vnames_cursor
	DECLARE @Viewname sysname
	FETCH NEXT FROM vnames_cursor INTO @Viewname
	WHILE (@@FETCH_STATUS <> -1)
	BEGIN
	   IF (@@FETCH_STATUS <> -2)
	   BEGIN
	       Exec( 'Grant Select,Insert,Update,Delete on [' + @Viewname + '] to BFGROUP' )
	   END
	   FETCH NEXT FROM vnames_cursor INTO @Viewname
	END
	CLOSE vnames_cursor
	DEALLOCATE vnames_cursor

	/* Stored Procs */
	DECLARE pnames_cursor CURSOR
	FOR
           select name from sysobjects where sysstat & 0xf = 4
	OPEN pnames_cursor
	DECLARE @Procname sysname
	FETCH NEXT FROM pnames_cursor INTO @Procname
	WHILE (@@FETCH_STATUS <> -1)
	BEGIN
	   IF (@@FETCH_STATUS <> -2)
	   BEGIN
	       Exec( 'Grant Execute on [' + @Procname + '] to BFGROUP' )
	   END
	   FETCH NEXT FROM pnames_cursor INTO @Procname
	END
	CLOSE pnames_cursor
	DEALLOCATE pnames_cursor
    END



GO
GRANT CONTROL
    ON OBJECT::[dbo].[GrantBFGRoup] TO [MSDSL]
    AS [dbo];

