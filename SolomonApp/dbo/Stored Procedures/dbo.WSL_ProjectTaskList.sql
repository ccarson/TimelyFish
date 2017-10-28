
CREATE PROCEDURE [dbo].[WSL_ProjectTaskList]
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
    
    IF @sort = '' SET @sort = 'pjt_entity'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT pjt_entity, pjt_entity_desc, contract_type, start_date, end_date, noteid, status_pa
			 FROM pjpent (nolock)
			 where project like ' + quotename(@parm1,'''') + '
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') pjt_entity, pjt_entity_desc, contract_type, start_date, end_date, noteid, status_pa  
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM pjpent (nolock)
					where project like ' + quotename(@parm1,'''') + '
				) 
				SELECT pjt_entity, pjt_entity_desc, contract_type, start_date, end_date, noteid, status_pa  
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_ProjectTaskList] TO [MSDSL]
    AS [dbo];

