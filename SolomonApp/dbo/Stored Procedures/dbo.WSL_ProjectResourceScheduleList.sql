
CREATE PROCEDURE WSL_ProjectResourceScheduleList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (10) -- Employee
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
  IF @sort = '' SET @sort = 'PJPentem.Project, PJPentem.PJT_Entity, pjpentem.subtask_name'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'Select pjpentem.project [Project],
	       pjpentem.pjt_entity [Task],
	       pjpent.pjt_entity_desc [Task Description],
	       pjpentem.subtask_name [SubTask],
	       pjpentem.date_start [SubTask Start Date],
	       pjpentem.date_end [SubTask End Date],
	       pjpent.start_date [Task Start Date],
	       pjpent.end_date [Task End Date],
	       pjproj.start_date [Project Start Date],
	       pjproj.end_date [Project End Date],
	       pjpentem.Actual_units [Actual Hours],
	       pjpentem.Budget_units [Estimated Hours],
	       pjpentem.comment [Commnet]
		   from pjpentem (nolock)
		   	INNER JOIN PJPent
	ON PJPentem.Project = Pjpent.Project and PJPentem.PJT_Entity = Pjpent.PJT_Entity

	INNER JOIN PJProj
	ON PJPentem.Project = Pjproj.Project
			 where
	Pjpentem.employee = ' + quotename(@parm1,'''')  
		 + 'ORDER BY ' + @sort
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') pjpentem.project [Project],
	       pjpentem.pjt_entity [Task],
	       pjpent.pjt_entity_desc [Task Description],
	       pjpentem.subtask_name [SubTask],
	       pjpentem.date_start [SubTask Start Date],
	       pjpentem.date_end [SubTask End Date],
	       pjpent.start_date [Task Start Date],
	       pjpent.end_date [Task End Date],
	       pjproj.start_date [Project Start Date],
	       pjproj.end_date [Project End Date],
	       pjpentem.Actual_units [Actual Hours],
	       pjpentem.Budget_units [Estimated Hours],
	       pjpentem.comment [Commnet]
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM pjpentem (nolock)
				INNER JOIN PJPent
	ON PJPentem.Project = Pjpent.Project and PJPentem.PJT_Entity = Pjpent.PJT_Entity

	INNER JOIN PJProj
	ON PJPentem.Project = Pjproj.Project
				where
	Pjpentem.employee = ' + quotename(@parm1,'''') 
				 + ') 
				SELECT Project,
	       Task,
	       [Task Description],
	       SubTask,
	       [SubTask Start Date],
	       [SubTask End Date],
	       [Task Start Date],
	       [Task End Date],
	       [Project Start Date],
	       [Project End Date],
	       [Actual Hours],
	       [Estimated Hours],
	       [Commnet]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_ProjectResourceScheduleList] TO [MSDSL]
    AS [dbo];

