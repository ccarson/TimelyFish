CREATE PROCEDURE WSL_EmployeeTaskList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (16) -- project
 ,@parm2 varchar (32) -- pjt_entity
 ,@parm3 varchar (10) -- employee
 
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int,
    @AllTask varchar(1),
    @APFlag varchar(1)
    
    SET @AllTask = (select status_18 from PJPROJ where project = @parm1)
    SET @APFlag = (select SUBSTRING(control_data,103,1) from PJCONTRL where control_type = 'TE' and control_code = 'SETUP')
    
    IF @sort = '' SET @sort = 'project, pjt_entity'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
	  IF @AllTask = 'Y'
	    BEGIN
		SET @STMT = 
			'SELECT pjt_entity [Task], pjt_entity_desc [Description]
			 FROM PJvETask (nolock)
			 where project = ' + quotename(@parm1,'''') + '
			  and  pjt_entity LIKE ' + quotename(@parm2,'''') + '
			  and  status_pa = ''A'''
			  
			IF @APFlag = 'Y'
			 BEGIN
			   SET @STMT = @STMT + ' and  status_ap = ''A'''
			 END
			 
			 SET @STMT = @STMT + ' and  employee = ' + quotename(@parm3,'''') + '
			  ORDER BY ' + @sort
		END
      ELSE
       BEGIN
		SET @STMT = 
			'SELECT pjt_entity [Task], pjt_entity_desc [Description]
			 FROM PJPENT (nolock)
			 where project = ' + quotename(@parm1,'''') + '
			  and  pjt_entity LIKE ' + quotename(@parm2,'''') + '
			  and  status_pa = ''A'''
			  
			IF @APFlag = 'Y'
			 BEGIN
			   SET @STMT = @STMT + ' and  status_ap = ''A'''
			 END
			 
			 SET @STMT = @STMT + ' ORDER BY ' + @sort
		END
	  END		 
  ELSE
	  BEGIN
			IF @page < 1 SET @page = 1
			IF @size < 1 SET @size = 1
			SET @lbound = (@page-1) * @size
			SET @ubound = @page * @size + 1
			IF @AllTask = 'Y'
			 BEGIN
				SET @STMT = 
					'WITH PagingCTE AS
					(
					SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') pjt_entity, pjt_entity_desc 
					,ROW_NUMBER() OVER(
					ORDER BY ' + @sort + ') AS row
					FROM PJvETask (nolock)
						where project = ' + quotename(@parm1,'''') + '
			  			and  pjt_entity LIKE ' + quotename(@parm2,'''') + '
			  			and status_pa = ''A'''
				IF @APFlag = 'Y'
				 BEGIN
						SET @STMT = @STMT + ' and  status_ap = ''A'''
				 END
				SET @STMT = @STMT + ' and  employee = ' + quotename(@parm3,'''') + ')'
			END
			ELSE
			 BEGIN
				SET @STMT = 
					'WITH PagingCTE AS
					(
					SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') pjt_entity, pjt_entity_desc 
					,ROW_NUMBER() OVER(
					ORDER BY ' + @sort + ') AS row
					FROM PJPENT (nolock)
						where project = ' + quotename(@parm1,'''') + '
						and  pjt_entity LIKE ' + quotename(@parm2,'''') + '
						and  status_pa = ''A'''
				IF @APFlag = 'Y'
				 BEGIN
					SET @STMT = @STMT + ' and  status_ap = ''A'''
				 END
				SET @STMT = @STMT + ')'
			 END
				 
				set @STMT = @STMT + ' SELECT pjt_entity [Task], pjt_entity_desc [Description]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT)  

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_EmployeeTaskList] TO [MSDSL]
    AS [dbo];

