
CREATE PROCEDURE WSL_TimesheetDocumentNumerList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (10) -- document number

AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'PJTIMHDR.preparer_id, PJTIMHDR.docnbr DESC, PJTIMHDR.th_type, PJTIMHDR.th_date DESC'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
          'SELECT PJTIMHDR.docnbr [Document], PJTIMHDR.project [Project], PJTIMHDR.th_status [Status], PJTIMHDR.th_date [Header Date]				     
			 FROM PJTIMHDR (nolock)
            WHERE PJTIMHDR.docnbr like ' + quotename(@parm1,'''') + ' 
              AND PJTIMHDR.th_status <> ''X'' 
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
                 SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') 
                           PJTIMHDR.docnbr, PJTIMHDR.project, PJTIMHDR.th_status, PJTIMHDR.th_date                 
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
			       FROM PJTIMHDR (nolock)
                  WHERE PJTIMHDR.docnbr like ' + quotename(@parm1,'''') + ' 
                    AND PJTIMHDR.th_status <> ''X'' 
				) 
				SELECT docnbr [Document], project [Project], th_status [Status], th_date [Header Date]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_TimesheetDocumentNumerList] TO [MSDSL]
    AS [dbo];

