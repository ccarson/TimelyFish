

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
CREATE  Procedure CF311p_cftPigGroup_CPigGroupId @parm1 varchar (10), @parm2 varchar (10) as 
    Select * from cftPigGroup Where SiteContactId = @parm1 and PigGroupId Like @parm2
	Order by PigGroupId

 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF311p_cftPigGroup_CPigGroupId] TO [MSDSL]
    AS [dbo];

