
CREATE PROCEDURE [dbo].[WSL_ProjectMaintSubaccountXRefList]
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (12) -- CpnyID
 ,@parm2 varchar (26) -- Sub 
 ,@parm3 varchar (32) -- Description
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max),  
    @lbound int,
    @ubound int,
    @SubAlias varchar (15) = 'Subaccount',
	@DescrAlias varchar (15) = 'Description',
    @whereExpression nvarchar(150)
    
    SET @whereExpression = ''

	   IF @parm3 IS NOT NULL AND LEN(@parm3) > 0
              SET @whereExpression = @whereExpression + ' AND vs_SubXRef.Descr LIKE ' + QUOTENAME(@parm3, '''');

       IF @sort = ''
       BEGIN
              IF @parm2 IS NOT NULL AND LEN(@parm2) > 1 SET @sort = 'vs_SubXRef.Sub'
			  Else IF @parm3 IS NOT NULL AND LEN(@parm3) > 1 SET @sort = 'vs_SubXRef.Descr'
              ELSE SET @sort = 'vs_SubXRef.Sub'
       END
	   ELSE
	   BEGIN
			  IF @sort = @SubAlias SET @sort = 'vs_SubXRef.Sub'
			  ELSE IF @sort = @DescrAlias SET @sort = 'vs_SubXRef.Descr'
	   END
	
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT Sub [' + @SubAlias + '], Descr [' + @DescrAlias + ']
			 FROM vs_SubXRef (nolock)
			 WHERE CpnyID = (SELECT CpnySub from vs_company WHERE CpnyID = ' + quotename(@parm1,'''') + ') 
			 AND Sub LIKE ' + quotename(@parm2,'''') + @whereExpression + ' 
			 AND Active = 1
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') Sub, Descr,
				ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM vs_SubXRef (nolock)
				WHERE CpnyID = (SELECT CpnySub from vs_company WHERE CpnyID = ' + quotename(@parm1,'''') + ') 
				AND Sub LIKE ' + quotename(@parm2,'''') + @whereExpression + ' 
				AND Active = 1
				) 
				SELECT Sub [' + @SubAlias + '], Descr [' + @DescrAlias + ']
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_ProjectMaintSubaccountXRefList] TO [MSDSL]
    AS [dbo];

