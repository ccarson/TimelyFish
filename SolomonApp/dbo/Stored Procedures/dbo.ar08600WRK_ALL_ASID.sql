
CREATE PROCEDURE ar08600WRK_ALL_ASID
	 @RI_ID smallint,
	 @WhereStr varchar(1024)
AS

	Declare @SqlStr As Varchar(500)


	Set @SqlStr = 'SELECT TOP(1)* FROM ar08600_wrk WITH (NOLOCK) WHERE RI_ID=' + CONVERT(VARCHAR(30),@RI_ID) + ' AND (ASID = 0 or WSID = 0) ' 

	if ( LTRIM(@WhereStr) <> '' And @WhereStr is not NULL ) 
        BEGIN
	    Set @SqlStr = @SqlStr + @WhereStr
	END

	Set @SqlStr = @SqlStr + ' ORDER BY CUSTID, RECORDID'

	exec (@SqlStr)
