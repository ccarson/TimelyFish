
CREATE PROCEDURE [dbo].[WSL_ProjectMaintBillWithList]
  @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (6) -- Bill Curyid
 ,@parm2 varchar (18) -- Project
 ,@parm3 varchar (62) -- Project Description
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int,
	@projectAlias varchar (10) = 'Project',
	@project_descAlias varchar (15) = 'Description',
    @whereExpression nvarchar(100)
    
    SET @whereExpression = ''

       IF @parm3 IS NOT NULL AND LEN(@parm3) > 0
              SET @whereExpression = @whereExpression + ' AND pjproj.project_desc LIKE ' + QUOTENAME(@parm3, '''');

       IF @sort = ''
       BEGIN
			  IF @parm2 IS NOT NULL AND LEN(@parm2) > 1 SET @sort = 'pjbill.project'
              Else IF @parm3 IS NOT NULL AND LEN(@parm3) > 1 SET @sort = 'pjproj.project_desc'
              ELSE SET @sort = 'pjbill.project'
       END
	   ELSE
	   BEGIN
			  IF @sort = @projectAlias SET @sort = 'pjbill.project'
			  ELSE IF @sort = @project_descAlias SET @sort = 'pjproj.project_desc'
	   END
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT  pjbill.project [' + @projectAlias + '], pjproj.project_desc [' + @project_descAlias + '] 
			 FROM PJBILL (nolock)
			 INNER Join PJPROJ
			   ON PJBILL.project = PJPROJ.project 
			 where PJBILL.billcuryid = ' + quotename(@parm1,'''') + '
			 and   PJBILL.project like ' + quotename(@parm2,'''') + @whereExpression + '
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
			      and   PJBILL.project like ' + quotename(@parm2,'''') + @whereExpression + '
				) 
				SELECT  project [' + @projectAlias + '], description [' + @project_descAlias + '] 
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_ProjectMaintBillWithList] TO [MSDSL]
    AS [dbo];

