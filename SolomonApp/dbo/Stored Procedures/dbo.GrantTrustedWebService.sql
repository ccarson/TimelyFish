
Create Procedure GrantTrustedWebService As 

    IF exists( select * from sysusers where name = 'TrustedWebService' and issqlrole = 1 )
    BEGIN
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
	       Exec( 'Grant Execute on [' + @Procname + '] to TrustedWebService' )
	   END
	   FETCH NEXT FROM pnames_cursor INTO @Procname 
	END
	CLOSE pnames_cursor
	DEALLOCATE pnames_cursor
	Exec( 'Grant Execute on [NameFlip] to TrustedWebService' )
    END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[GrantTrustedWebService] TO [MSDSL]
    AS [dbo];

