
CREATE PROCEDURE [dbo].[WSL_TimesheetHeaderDisplay]
 @parm1 char (10), -- Preparer employee ID
 @parm2 char (16), -- Project ID
 @parm3 char (32), -- Task ID
  @page  int
 ,@size  int
 ,@sort   nvarchar(200)
AS
    SET NOCOUNT ON

 	SELECT
 	 	dbo.NameFlip(e.emp_name) [PreparerName] ,
 	 	isnull(p.project_desc,'') [ProjectDescription],
 	 	isnull(dbo.NameFlip(m.emp_name),'') [ManagerName],
 	 	isnull(t.pjt_entity_desc,'') [TaskDescription]
 	FROM  PJEMPLOY e  (nolock) 
		LEFT OUTER JOIN PJPROJ p (nolock) on p.project = @parm2
 	 	LEFT OUTER JOIN PJPENT t (nolock) on t.pjt_entity = @parm3  AND p.project = t.project
  		LEFT OUTER JOIN PJEMPLOY m (nolock)  on m.employee = p.manager1
	 WHERE e.employee = @parm1	

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_TimesheetHeaderDisplay] TO [MSDSL]
    AS [dbo];

