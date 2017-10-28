
CREATE PROCEDURE [dbo].[WSL_ProjectMaintSalespersonList]
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (12) -- SlsperId 
 ,@parm2 varchar (62) -- Name
 ,@parm3 varchar (12) -- Zip Code
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max),
    @lbound int,
    @ubound int,
	@SlsperIdAlias varchar (15) = 'SalesPerson ID',
	@ZipAlias varchar (15) = 'Postal Code',
	@whereExpression nvarchar(180)
    
    SET @whereExpression = ''

       IF @parm2 IS NOT NULL AND LEN(@parm2) > 0
              SET @whereExpression = @whereExpression + ' AND Salesperson.Name LIKE ' + QUOTENAME(@parm2, '''');
       IF @parm3 IS NOT NULL AND LEN(@parm3) > 0
              SET @whereExpression = @whereExpression + ' AND Salesperson.Zip LIKE ' + QUOTENAME(@parm3, '''');

       IF @sort = ''
       BEGIN
              IF @parm1 IS NOT NULL AND LEN(@parm1) > 1 SET @sort = 'Salesperson.SlsperId'
              ELSE IF @parm2 IS NOT NULL AND LEN(@parm2) > 1 SET @sort = 'Salesperson.Name'
              ELSE IF @parm3 IS NOT NULL AND LEN(@parm3) > 1 SET @sort = 'Salesperson.Zip'
              ELSE SET @sort = 'Salesperson.SlsperId'
       END
	   Else
	   BEGIN
			  IF @sort = @SlsperIdAlias SET @sort = 'Salesperson.SlsperId'
			  ELSE IF @sort = @ZipAlias SET @sort = 'Salesperson.Zip'
	   END
	
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT SlsperId [' + @SlsperIdAlias + '], Name [Name], Phone [Phone], Zip [' + @ZipAlias + ']
			 FROM Salesperson (nolock)
			 WHERE SlsperId LIKE ' + quotename(@parm1,'''') + @whereExpression + ' 
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') SlsperId, Name, Phone, Zip,
				ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM Salesperson (nolock)
				WHERE SlsperId LIKE ' + quotename(@parm1,'''') + @whereExpression + '
				) 
				SELECT SlsperId [' + @SlsperIdAlias + '], Name [Name], Phone [Phone], Zip [' + @ZipAlias + ']
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_ProjectMaintSalespersonList] TO [MSDSL]
    AS [dbo];

