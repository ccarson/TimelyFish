CREATE PROCEDURE PJProj_ARProject_ASRReqEDD
	@parm1 varchar(2),
	@parm2 varchar(15)
	
AS

SELECT * from PJProj JOIN vs_asrreqedd ON PJProj.Project = vs_asrreqedd.arProject WHERE vs_asrreqedd.DocType = @parm1 AND PJProj.Project like @parm2 and PJProj.Project <> ''
ORDER BY PJProj.Project


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJProj_ARProject_ASRReqEDD] TO [MSDSL]
    AS [dbo];

