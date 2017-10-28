 CREATE PROCEDURE smCodeSkill_All
	@parm1 varchar(10)
	,@parm2 varchar(10)
AS
SELECT *
FROM smCodeSkills
	left outer join smSkills
		on smCodeSkills.FaultSkillsSkillID = smSkills.SkillsID
WHERE FaultSkillsId = @parm1
	AND FaultSkillsSkillID LIKE @parm2
ORDER BY FaultSkillsId, FaultSkillsSkillId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smCodeSkill_All] TO [MSDSL]
    AS [dbo];

