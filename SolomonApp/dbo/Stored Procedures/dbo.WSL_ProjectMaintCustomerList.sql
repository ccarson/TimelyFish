
CREATE PROCEDURE [dbo].[WSL_ProjectMaintCustomerList]
@page  int
,@size  int
,@sort   nvarchar(200)
,@parm1 varchar (17) -- CustID
,@parm2 varchar (62) -- Name
,@parm3 varchar (12) -- Zip code
,@parm4 varchar(3) -- Status
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int,
	@CustIDAlias varchar(15) = 'Customer ID',
	@ZipAlias varchar (15) = 'Postal Code',
    @whereExpression nvarchar(180)

       SET @whereExpression = ''

       IF @parm2 IS NOT NULL AND LEN(@parm2) > 0
              SET @whereExpression = @whereExpression + ' AND Customer.Name LIKE ' + QUOTENAME(@parm2, '''');
       IF @parm3 IS NOT NULL AND LEN(@parm3) > 0
              SET @whereExpression = @whereExpression + ' AND Customer.Zip LIKE ' + QUOTENAME(@parm3, '''');
	   IF @parm4 IS NOT NULL AND LEN(@parm4) > 0
              SET @whereExpression = @whereExpression + ' AND Customer.Status LIKE ' + QUOTENAME(@parm4, '''');

       IF @sort = ''
       BEGIN
              IF @parm1 IS NOT NULL AND LEN(@parm1) > 1 SET @sort = 'Customer.CustID'
              ELSE IF @parm2 IS NOT NULL AND LEN(@parm2) > 1 SET @sort = 'Customer.Name'
              ELSE IF @parm3 IS NOT NULL AND LEN(@parm3) > 1 SET @sort = 'Customer.Zip'
			  ELSE IF @parm4 IS NOT NULL AND LEN(@parm4) > 1 SET @sort = 'Customer.Status'
              ELSE SET @sort = 'Customer.CustID'
       END
	   Else
	   BEGIN
			  IF @sort = @CustIDAlias SET @sort = 'Customer.CustID'
			  ELSE IF @sort = @ZipAlias SET @sort = 'Customer.Zip'
	   END
       
  IF @page = 0  -- Don't do paging
         BEGIN
              SET @STMT = 
                     'SELECT CustID [' + @CustIDAlias + '], Name [Name], Phone [Phone], Zip [' + @ZipAlias + '], [Status]
                     FROM Customer (nolock)
                     WHERE CustID LIKE ' + quotename(@parm1,'''') + @whereExpression + ' 
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
                           SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') CustID, Name, Phone, Zip, Status,
                           ROW_NUMBER() OVER(
                           ORDER BY ' + @sort + ') AS row
                           FROM Customer (nolock)
                           WHERE CustID LIKE ' + quotename(@parm1,'''') + @whereExpression + '
                           ) 
                           SELECT CustID [' + @CustIDAlias + '], Name [Name], Phone [Phone], Zip [' + @ZipAlias + '], [Status]
                           FROM PagingCTE                     
                           WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
                                     row <  ' + CONVERT(varchar(9), @ubound) + '
                           ORDER BY row'
         END                      
  EXEC (@STMT) 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_ProjectMaintCustomerList] TO [MSDSL]
    AS [dbo];

