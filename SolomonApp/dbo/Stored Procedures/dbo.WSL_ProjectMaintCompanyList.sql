
CREATE PROCEDURE [dbo].[WSL_ProjectMaintCompanyList]
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (32) -- Database Name
 ,@parm2 varchar (12) -- Company ID
 ,@parm3 varchar (32) -- Company Name
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int,
	@CpnyIDAlias varchar (10) = 'Company',
	@CpnyNameAlias varchar (15) = 'Company Name',
    @whereExpression nvarchar(80)
    
    SET @whereExpression = ''

       IF @parm3 IS NOT NULL AND LEN(@parm3) > 0
              SET @whereExpression = @whereExpression + ' AND vs_company.cpnyname LIKE ' + QUOTENAME(@parm3, '''');

       IF @sort = ''
       BEGIN
              IF @parm2 IS NOT NULL AND LEN(@parm2) > 1 SET @sort = 'vs_company.CpnyID'
              ELSE IF @parm3 IS NOT NULL AND LEN(@parm3) > 1 SET @sort = 'vs_company.CpnyName'
              ELSE SET @sort = 'vs_company.CpnyID'
       END
	   ELSE
	   BEGIN
	          IF @sort = @CpnyIDAlias SET @sort = 'vs_company.CpnyID'
			  ELSE IF @sort = @CpnyNameAlias SET @sort = 'vs_company.CpnyName'
	   END
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT CpnyID [' + @CpnyIDAlias + '], CpnyName [' + @CpnyNameAlias + ']
			 FROM vs_company (nolock)
			 where DatabaseName = ' + quotename(@parm1,'''') + '
			  and  CpnyID like ' + quotename(@parm2,'''') + @whereExpression + '
			  and  Active =  1
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') CpnyID, CpnyName  
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM vs_company (nolock)
					where DatabaseName = ' + quotename(@parm1,'''') + '
					and  CpnyID like ' + quotename(@parm2,'''') + @whereExpression + '
					and  Active =  1
				) 
				SELECT CpnyID [' + @CpnyIDAlias + '], CpnyName [' + @CpnyNameAlias + ']
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_ProjectMaintCompanyList] TO [MSDSL]
    AS [dbo];

