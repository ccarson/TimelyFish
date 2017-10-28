CREATE PROCEDURE WSL_ProjectBillwithList
  @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (4) -- Bill Curyid
 ,@parm2 varchar (16) -- Project
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'pjbill.project'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT  pjbill.project [Project], pjproj.project_desc [Description] 
			 FROM PJBILL (nolock)
			 INNER Join PJPROJ
			   ON PJBILL.project = PJPROJ.project 
			 where PJBILL.billcuryid = ' + quotename(@parm1,'''') + '
			 and   PJBILL.project like ' + quotename(@parm2,'''') + '
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') pjbill.project [project], pjproj.project_desc [description]  
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
	            FROM PJBILL (nolock)
			    INNER Join PJPROJ
			       ON PJBILL.project = PJPROJ.project 
			    where PJBILL.billcuryid = ' + quotename(@parm1,'''') + '
			      and   PJBILL.project like ' + quotename(@parm2,'''') + '
				) 
				SELECT  project [Project], description [Description] 
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 
