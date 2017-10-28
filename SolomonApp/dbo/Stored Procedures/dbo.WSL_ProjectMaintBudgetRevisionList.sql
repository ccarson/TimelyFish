
CREATE PROCEDURE [dbo].[WSL_ProjectMaintBudgetRevisionList]
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (18) -- Project
 ,@parm2 varchar (6) -- Revision ID
 ,@parm3 varchar (4) -- Status
 ,@parm4 varchar (62) -- Revision Description
 ,@parm5 varchar (18) -- Change Order Number
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int,
	@projectAlias varchar (15) = 'Project ID',
	@revidAlias varchar (15) = 'Revision',
	@statusAlias varchar (10) = 'Status',
	@Revision_DescAlias varchar (30) = 'Revision Description',
	@Change_Order_NumAlias varchar (30) = 'Change Order Number',
    @whereExpression nvarchar(250)
    
    SET @whereExpression = ''

       IF @parm3 IS NOT NULL AND LEN(@parm3) > 0
              SET @whereExpression = @whereExpression + ' AND PJREVHDR.status LIKE ' + QUOTENAME(@parm3, '''');
	   IF @parm4 IS NOT NULL AND LEN(@parm4) > 0
              SET @whereExpression = @whereExpression + ' AND PJREVHDR.Revision_Desc LIKE ' + QUOTENAME(@parm4, '''');
	   IF @parm5 IS NOT NULL AND LEN(@parm5) > 0
              SET @whereExpression = @whereExpression + ' AND PJREVHDR.Change_Order_Num LIKE ' + QUOTENAME(@parm5, '''');

       IF @sort = ''
       BEGIN
              IF @parm2 IS NOT NULL AND LEN(@parm2) > 1 SET @sort = 'PJREVHDR.revid'
			  IF @parm3 IS NOT NULL AND LEN(@parm3) > 1 SET @sort = 'PJREVHDR.status'
			  IF @parm4 IS NOT NULL AND LEN(@parm4) > 1 SET @sort = 'PJREVHDR.Revision_Desc'
			  IF @parm5 IS NOT NULL AND LEN(@parm5) > 1 SET @sort = 'PJREVHDR.Change_Order_Num'
              ELSE SET @sort = 'PJREVHDR.revid, PJREVHDR.Revision_Desc'
       END
	   ELSE
	   BEGIN
			  IF @sort = @projectAlias SET @sort = 'PJREVHDR.project'
			  ELSE IF @sort = @revidAlias SET @sort = 'PJREVHDR.revid'
			  ELSE IF @sort = @statusAlias SET @sort = 'PJREVHDR.status'
			  ELSE IF @sort = @Revision_DescAlias SET @sort = 'PJREVHDR.Revision_Desc'
			  ELSE IF @sort = @Change_Order_NumAlias SET @sort = 'PJREVHDR.Change_Order_Num'
	   END
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT project [' + @projectAlias + '], revid [' + @revidAlias + '], status [' + @statusAlias + '], Revision_Desc [' + @Revision_DescAlias + '], Change_Order_Num [' + @Change_Order_NumAlias + ']
			 FROM PJREVHDR (nolock)
			 where project = ' + quotename(@parm1,'''') + '
			  and  revid like ' + quotename(@parm2,'''') + @whereExpression + '
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') project, revid, status, Revision_Desc, Change_Order_Num  
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM PJREVHDR (nolock)
				 where project = ' + quotename(@parm1,'''') + '
				  and  revid like ' + quotename(@parm2,'''') + @whereExpression + '
				) 
				SELECT project [' + @projectAlias + '], revid [' + @revidAlias + '], status [' + @statusAlias + '], Revision_Desc [' + @Revision_DescAlias + '], Change_Order_Num [' + @Change_Order_NumAlias + ']
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_ProjectMaintBudgetRevisionList] TO [MSDSL]
    AS [dbo];

