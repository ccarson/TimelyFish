
Create PROCEDURE [dbo].[WSL_ProjectMaintBudgetRevisionDetailList]
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (18) -- Project
 ,@parm2 varchar (6) -- Revision ID
 ,@parm3 varchar (4) -- Task
 ,@parm4 varchar (62) -- Account Category
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int,
    @whereExpression nvarchar(250)
    
    SET @whereExpression = ''

       IF @parm3 IS NOT NULL AND LEN(@parm3) > 0
              SET @whereExpression = @whereExpression + ' AND QQ_pjbudgets.[Task] LIKE ' + QUOTENAME(@parm3, '''');
	   IF @parm4 IS NOT NULL AND LEN(@parm4) > 0
              SET @whereExpression = @whereExpression + ' AND QQ_pjbudgets.[Acct Cat] LIKE ' + QUOTENAME(@parm4, '''');

       IF @sort = ''
       BEGIN
			  IF @parm3 IS NOT NULL AND LEN(@parm3) > 1 SET @sort = 'QQ_pjbudgets.[Task]'
			  IF @parm4 IS NOT NULL AND LEN(@parm4) > 1 SET @sort = 'QQ_pjbudgets.[Acct Cat]'
              ELSE SET @sort = 'QQ_pjbudgets.Task, QQ_pjbudgets.[Acct Cat]'
       END
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT Revision, [Revision Description], Status, [Task], [Acct Cat]
			 FROM QQ_pjbudgets (nolock)
			 where project = ' + quotename(@parm1,'''') + '
			  and  Revision = ' + quotename(@parm2,'''') + @whereExpression + '
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') Revision, [Revision Description], Status, [Task], [Acct Cat]
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM QQ_pjbudgets (nolock)
				 where project = ' + quotename(@parm1,'''') + '
				  and  Revision like ' + quotename(@parm2,'''') + @whereExpression + '
				) 
				SELECT Revision, [Revision Description], Status, [Task], [Acct Cat]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 


