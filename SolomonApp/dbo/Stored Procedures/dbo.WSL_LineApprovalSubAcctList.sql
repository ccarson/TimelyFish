
CREATE PROCEDURE [dbo].[WSL_LineApprovalSubAcctList]
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (24) -- SubAcct
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int,
    @mgrRev char

    IF @sort = '' SET @sort = 'SubAcct'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT distinct SubAcct, QQ_subaccount.Description from QQ_subaccount,QQ_LineApprovals (nolock) where Subaccount = SubAcct
			and SubAcct like ' + quotename(@parm1,'''') + '
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
				SELECT  TOP(' + CONVERT(varchar(9), @ubound-1) + ')   SubAcct, min(QQ_subaccount.Description) [Description]
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM QQ_subaccount,QQ_LineApprovals (nolock)
					where Subaccount = SubAcct
					and SubAcct like ' + quotename(@parm1,'''') + '
					Group By SubAcct
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
    ON OBJECT::[dbo].[WSL_LineApprovalSubAcctList] TO [MSDSL]
    AS [dbo];

