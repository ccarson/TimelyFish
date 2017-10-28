
CREATE PROCEDURE WSL_ActiveARProjectList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (16) -- Project
 AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'Project'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT PJPROJ.Project [Project #], PJPROJ.Project_Desc [Description], PJPROJ.Customer [Customer #], PJProj.CpnyID [Company]
			 FROM PJPROJ(nolock)
			 WHERE Project LIKE ' + quotename(@parm1,'''') + ' 
			 AND Status_PA = ''A'' 
			 AND Status_AR = ''A'' 
			 AND Status_20 = '''' 
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') PJPROJ.Project, PJPROJ.Project_Desc, PJPROJ.Customer, PJProj.CpnyID
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM PJPROJ(nolock)
					WHERE Project LIKE ' + quotename(@parm1,'''') + ' 
					AND Status_PA = ''A'' 
					AND Status_AR = ''A'' 
					AND Status_20 = '''' 
				) 
				SELECT Project [Project #], Project_Desc [Description], Customer [Customer #], CpnyID [Company]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 
