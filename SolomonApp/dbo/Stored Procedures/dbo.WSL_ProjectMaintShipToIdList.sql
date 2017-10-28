
CREATE PROCEDURE [dbo].[WSL_ProjectMaintShipToIdList]
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (17) -- CustId
 ,@parm2 varchar (12) -- ShipToId
 ,@parm3 varchar (62) -- Name
 ,@parm4 varchar (62) -- Address
 ,@parm5 varchar (12) -- Zip code
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max),  
    @lbound int,
    @ubound int,
	@ShipToIdAlias varchar (10) = 'Site ID',
	@Addr1Alias varchar (10) = 'Address',
	@ZipAlias varchar (15) = 'Postal Code',
    @whereExpression nvarchar(220)
    
    SET @whereExpression = ''

       IF @parm3 IS NOT NULL AND LEN(@parm3) > 0
              SET @whereExpression = @whereExpression + ' AND SOAddress.Name LIKE ' + QUOTENAME(@parm3, '''');
	   IF @parm4 IS NOT NULL AND LEN(@parm4) > 0
			  SET @whereExpression = @whereExpression + ' AND SOAddress.Addr1 LIKE ' + QUOTENAME(@parm4, '''');
	   IF @parm5 IS NOT NULL AND LEN(@parm5) > 0
			  SET @whereExpression = @whereExpression + ' AND SOAddress.Zip LIKE ' + QUOTENAME(@parm5, '''');

       IF @sort = ''
       BEGIN
              IF @parm2 IS NOT NULL AND LEN(@parm2) > 1 SET @sort = 'SOAddress.ShipToId'
			  Else IF @parm3 IS NOT NULL AND LEN(@parm3) > 1 SET @sort = 'SOAddress.Name'
			  Else IF @parm4 IS NOT NULL AND LEN(@parm4) > 1 SET @sort = 'SOAddress.Addr1'
			  Else IF @parm5 IS NOT NULL AND LEN(@parm5) > 1 SET @sort = 'SOAddress.Zip'
              ELSE SET @sort = 'SOAddress.ShipToId'
       END
	   ELSE
	   BEGIN
			  IF @sort = @ShipToIdAlias SET @sort = 'SOAddress.ShipToId'
			  ELSE IF @sort = @Addr1Alias SET @sort = 'SOAddress.Addr1'
			  ELSE IF @sort = @ZipAlias SET @sort = 'SOAddress.Zip'
	   END
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT ShipToId [' + @ShipToIdAlias + '], Name, Addr1 [' + @Addr1Alias + '], Phone, Zip [' + @ZipAlias + ']
			 FROM SOAddress (nolock)
			 WHERE CustId = ' + quotename(@parm1,'''') + ' 
			 AND ShipToId LIKE ' + quotename(@parm2,'''') + @whereExpression + ' 
			 ORDER BY ' + @sort
	  END		 
  ELSE
	  BEGIN
			IF @page < 1 SET @page = 1
			IF @size < 1 SET @size = 1
			SET @lbound = (@page-1) * @size
			SET @ubound = @page * @size + 1
			SET @STMT = 
				'WITH PagingCTE AS
				(
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') ShipToId, Name, Addr1, Phone, Zip
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM SOAddress
				WHERE CustId LIKE ' + quotename(@parm1,'''') + '
				AND ShipToId LIKE ' + quotename(@parm2,'''') + @whereExpression + '
				) 
				SELECT ShipToId [' + @ShipToIdAlias + '], Name, Addr1 [' + @Addr1Alias + '], Phone, Zip [' + @ZipAlias + ']
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_ProjectMaintShipToIdList] TO [MSDSL]
    AS [dbo];

