
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
Create Procedure CF315p_cftPigGroup_ContActive @parm1 varchar (6) as 
    Select * from cftPigGroup p Where SiteContactId = @parm1 
	and Exists (Select * from PJPent Where ProjectId = p.ProjectID and Pjt_Entity = p.TaskId and
	Status_PA = 'A' and Status_IN = 'A')
	Order by p.PigGroupId

 
GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF315p_cftPigGroup_ContActive] TO [MSDSL]
    AS [dbo];

