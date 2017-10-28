
CREATE PROCEDURE WSL_ProjectWeekEndingDateList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 smalldatetime -- Post Date
 AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'pjweek.we_date'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT we_date [W/E Date], week_num [Week #], period_num [Period #]
			 FROM pjweek(nolock)
			 where we_date >= ' + quotename(@parm1,'''') + ' 
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') we_date, week_num, period_num
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM pjweek(nolock)
					where we_date >= ' + quotename(@parm1,'''') + ' 
				) 
				SELECT we_date [W/E Date], week_num [Week #], period_num [Period #]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_ProjectWeekEndingDateList] TO [MSDSL]
    AS [dbo];

