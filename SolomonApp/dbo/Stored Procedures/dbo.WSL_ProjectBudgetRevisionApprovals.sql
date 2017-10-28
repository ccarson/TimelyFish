
CREATE PROCEDURE WSL_ProjectBudgetRevisionApprovals
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (10) -- Employee (Approver)
 ,@parm2 varchar (10) -- CompanyID
 ,@parm3 varchar (10) -- Employee (Document author)
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int,
    @mgrRev char

    IF @sort = '' SET @sort = 'QQ_pjrevcat.[project start date]'

  IF @page = 0  -- Don't do paging
 	  BEGIN
 	 	SET @STMT = 
 	 	 	'SELECT QQ_pjrevcat.*, PJREVCAT.NoteId, PJREVCAT.tstamp from QQ_pjrevcat INNER JOIN PJREVCAT WITH (nolock) ON QQ_pjrevcat.[revision ID] = PJREVCAT.RevId AND QQ_pjrevcat.project = PJREVCAT.project AND QQ_pjrevcat.task = PJREVCAT.pjt_entity AND QQ_pjrevcat.[account category] = PJREVCAT.Acct
 	 	 	where QQ_pjrevcat.Approver = ' + quotename(@parm1,'''') + ' and QQ_pjrevcat.[project company] = ' + quotename(@parm2,'''') + ' and QQ_pjrevcat.Preparer like ' + quotename(@parm3,'''') + '
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
 	 	 	 	SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') QQ_pjrevcat.*, PJREVCAT.NoteId, PJREVCAT.tstamp
 	 	 	 	,ROW_NUMBER() OVER(
 	 	 	 	ORDER BY ' + @sort + ') AS row
 	 	 	 	FROM QQ_pjrevcat INNER JOIN PJREVCAT WITH (nolock) ON QQ_pjrevcat.[revision ID] = PJREVCAT.RevId AND QQ_pjrevcat.project = PJREVCAT.project AND QQ_pjrevcat.task = PJREVCAT.pjt_entity AND QQ_pjrevcat.[account category] = PJREVCAT.Acct
 	 	 	 	 	where QQ_pjrevcat.Approver = ' + quotename(@parm1,'''') + ' and QQ_pjrevcat.[project company] = ' + quotename(@parm2,'''') + ' and QQ_pjrevcat.Preparer like ' + quotename(@parm3,'''') + '
 	 	 	 	) 
 	 	 	 	SELECT *
 	 	 	 	FROM PagingCTE                     
 	 	 	 	WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
 	 	 	 	 	   row <  ' + CONVERT(varchar(9), @ubound) + '
 	 	 	 	ORDER BY row'
 	  END 	 	
  EXEC (@STMT) 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_ProjectBudgetRevisionApprovals] TO [MSDSL]
    AS [dbo];

