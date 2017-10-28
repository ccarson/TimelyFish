 CREATE PROCEDURE smEmpSkill_All
	@parm1 varchar(10)
	,@parm2 varchar(10)
AS
SELECT *
FROM smEmpSkill
	left outer join smSkills
		on smempskill.employeeskillskill = smSkills.SkillsID
WHERE EmployeeSkillEmpId = @parm1
	AND EmployeeSkillSkill LIKE @parm2
ORDER BY EmployeeSkillEmpId
	,EmployeeSkillSkill



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smEmpSkill_All] TO [MSDSL]
    AS [dbo];

