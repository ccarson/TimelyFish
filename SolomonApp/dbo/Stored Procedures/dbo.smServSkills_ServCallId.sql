 CREATE PROCEDURE smServSkills_ServCallId
	@parm1 varchar(10)
	,@parm2 varchar(10)
AS
SELECT *
FROM smServSkills
	left outer join smSkills
		on smServSkills.SkillsID = smSkills.SkillsID
WHERE ServiceCallId = @parm1
	AND smServSkills.SkillsID LIKE @parm2
ORDER BY smServSkills.ServiceCallId
	,smServSkills.SkillsID


