
CREATE PROCEDURE [dbo].[WSL_TimesheetDetailList]
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (10) -- DocNbr
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'ts.employee,ts.equip_id'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'select ts.equip_id [EquipmentId],ts.employee [Employee],ts.project [Project],ts.pjt_entity [Task],
			   isnull(eq.equip_desc,'''') [EquipmentDesc], isnull(dbo.NameFlip(e.emp_name),'''') [EmployeeName], 
			   isnull(p.project_desc,'''') [ProjectDesc], isnull(t.pjt_entity_desc,'''') [TaskDesc], ts.[linenbr]
			 from pjtimdet as ts  (nolock)
				LEFT OUTER JOIN PJEQUIP eq (nolock) on eq.equip_id = ts.equip_id
  				LEFT OUTER JOIN PJEMPLOY e (nolock) on e.employee = ts.employee
				LEFT OUTER JOIN PJPROJ p (nolock) on p.project = ts.project
 	 			LEFT OUTER JOIN PJPENT t (nolock) on t.pjt_entity = ts.pjt_entity AND p.project = t.project
			 where ts.docnbr = ' + quotename(@parm1,'''') + '
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
					   ts.equip_id [EquipmentId],ts.employee [Employee],ts.project [Project],ts.pjt_entity [Task],
					   isnull(eq.equip_desc,'''') [EquipmentDesc], isnull(dbo.NameFlip(e.emp_name),'''') [EmployeeName], 
					   isnull(p.project_desc,'''') [ProjectDesc], isnull(t.pjt_entity_desc,'''') [TaskDesc], ts.[linenbr]
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM pjtimdet as ts (nolock)
				LEFT OUTER JOIN PJEQUIP eq (nolock) on eq.equip_id = ts.equip_id
  				LEFT OUTER JOIN PJEMPLOY e (nolock) on e.employee = ts.employee
				LEFT OUTER JOIN PJPROJ p (nolock) on p.project = ts.project
 	 			LEFT OUTER JOIN PJPENT t (nolock) on t.pjt_entity = ts.pjt_entity AND p.project = t.project
					where ts.docnbr = ' + quotename(@parm1,'''') + '
				) 
				SELECT 
				[EquipmentId],PagingCTE.[Employee],[Project],[Task],
					   [EquipmentDesc], [EmployeeName], 
					   [ProjectDesc], [TaskDesc], [linenbr]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

