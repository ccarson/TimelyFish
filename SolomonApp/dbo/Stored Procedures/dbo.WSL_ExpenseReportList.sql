CREATE PROCEDURE WSL_ExpenseReportList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (10) -- Doc Nbr
 ,@parm2 varchar (10) -- Employee
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'docnbr DESC'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT docnbr [Document], report_date [Report Date], Status_1 [Status], Status_2 [Type], desc_hdr [Description], Employee [Employee]
			 FROM PJEXPHDR (nolock)
			 where employee = ' + quotename(@parm2,'''') + '
			  and  docnbr like ' + quotename(@parm1,'''') + '
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') docnbr, report_date, Status_1, Status_2, desc_hdr, Employee 
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM PJEXPHDR (nolock)
					where employee = ' + quotename(@parm2,'''') + '
					and  docnbr like ' + quotename(@parm1,'''') + '
				) 
				SELECT docnbr [Document], report_date [Report Date], Status_1 [Status], Status_2 [Type], desc_hdr [Description], Employee [Employee]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT)  

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_ExpenseReportList] TO [MSDSL]
    AS [dbo];

