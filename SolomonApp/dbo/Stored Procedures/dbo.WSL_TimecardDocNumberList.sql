
CREATE PROCEDURE WSL_TimecardDocNumberList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (10) -- employee
 ,@parm2 varchar (10) -- docnbr
 AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'PJLABHDR.pe_date'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT docnbr [Document], pe_date [W/E Date], le_type [Type], le_status [Status]
			 FROM PJLABHDR(nolock)
			 where employee = ' + QUOTENAME(@parm1,'''') + '
			  and  docnbr LIKE ' + quotename(@parm2,'''') + '
			  and le_status <> ''X'' 
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') docnbr, pe_date, le_type, le_status
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM PJLABHDR(nolock)
					where employee = ' + QUOTENAME(@parm1,'''') + '
			  		and  docnbr LIKE ' + quotename(@parm2,'''') + '
			  		and le_status <> ''X''
				) 
				SELECT docnbr [Document], pe_date [W/E Date], le_type [Type], le_status [Status]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_TimecardDocNumberList] TO [MSDSL]
    AS [dbo];

