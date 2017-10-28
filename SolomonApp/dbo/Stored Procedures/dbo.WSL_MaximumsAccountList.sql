CREATE PROCEDURE WSL_MaximumsAccountList
  @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (16) -- Project
 ,@parm2 varchar (32) -- Task
 ,@parm3 varchar (16) -- Account
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'project, pjt_entity, pjprojmx.acct'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT  PJPROJMX.ACCT [Account Category], ACCT_TYPE [Type], ACCT_DESC [Description]
			 FROM PJPROJMX (nolock)
			 INNER Join PJACCT
			   ON PJPROJMX.ACCT = PJACCT.ACCT 
			 where PJPROJMX.project = ' + quotename(@parm1,'''') + '
			 and   PJPROJMX.pjt_entity = ' + quotename(@parm2,'''') + '
			 and   PJPROJMX.acct LIKE ' + quotename(@parm3,'''') + '
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') PJPROJMX.ACCT, ACCT_TYPE, ACCT_DESC  
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				 FROM PJPROJMX (nolock)
				 INNER Join PJACCT
				   ON PJPROJMX.ACCT = PJACCT.ACCT 
				 where PJPROJMX.project = ' + quotename(@parm1,'''') + '
				 and   PJPROJMX.pjt_entity = ' + quotename(@parm2,'''') + '
				 and   PJPROJMX.acct LIKE ' + quotename(@parm3,'''') + '
				) 
				SELECT  ACCT [Account Category], ACCT_TYPE [Type], ACCT_DESC [Description]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 
