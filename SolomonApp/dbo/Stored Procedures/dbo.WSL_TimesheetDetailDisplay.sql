
CREATE PROCEDURE [dbo].[WSL_TimesheetDetailDisplay]
 @parm1 char (10), -- Employee ID
 @parm2 char (16), -- Project ID
 @parm3 char (32), -- Task ID
 @parm4 char (10), -- Equipment ID
 @parm5 smalldatetime, -- Timesheet Detail Date
  @page  int
 ,@size  int
 ,@sort   nvarchar(200)
AS
  SET NOCOUNT ON

	SELECT
 	 	(SELECT dbo.NameFlip(e.emp_name) FROM PJEMPLOY e WHERE e.employee = @parm1) [EmployeeName],
 	 	p.project_desc [ProjectDescription],
 	 	COALESCE(t.pjt_entity_desc, '') [TaskDescription],
 	 	(SELECT equip_desc FROM PJEQUIP e WHERE equip_id = @parm4) [EquipmentDescription],
 	 	(SELECT unit_of_measure FROM PJEQRATE WHERE (project = @parm2 OR project = 'NA') AND equip_id = @parm4 AND effect_date = (SELECT MAX(effect_date) FROM PJEQRATE WHERE (project = @parm2 OR project = 'NA') AND equip_id = @parm4 AND effect_date <= @parm5)) [UOM]
 	FROM PJPROJ p
 	 	LEFT OUTER JOIN PJPENT t
 	 	ON p.project = t.project AND t.pjt_entity = @parm3
 	WHERE p.project = @parm2 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_TimesheetDetailDisplay] TO [MSDSL]
    AS [dbo];

