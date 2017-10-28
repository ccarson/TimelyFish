
CREATE PROCEDURE [dbo].[WSL_LineApprovalContractList]
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (16) -- Contract
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int,
    @mgrRev char

    IF @sort = '' SET @sort = 'QQ_LineApprovals.Contract'
    IF LOWER(@sort) = 'contract' SET @sort = 'QQ_LineApprovals.Contract'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT distinct QQ_LineApprovals.Contract, QQ_pjcont.[contract description] [Description] from QQ_pjcont,QQ_LineApprovals (nolock) where QQ_pjcont.contract = QQ_LineApprovals.Contract
			and QQ_LineApprovals.Contract like ' + quotename(@parm1,'''') + '
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
				SELECT  TOP(' + CONVERT(varchar(9), @ubound-1) + ')   QQ_LineApprovals.Contract, min(QQ_pjcont.[contract description]) [Description] 
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM QQ_pjcont,QQ_LineApprovals (nolock)
					where QQ_pjcont.contract = QQ_LineApprovals.Contract
					and QQ_LineApprovals.Contract like ' + quotename(@parm1,'''') + '
					Group By QQ_LineApprovals.Contract
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
    ON OBJECT::[dbo].[WSL_LineApprovalContractList] TO [MSDSL]
    AS [dbo];

