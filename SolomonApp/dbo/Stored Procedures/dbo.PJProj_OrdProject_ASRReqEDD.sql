 CREATE PROCEDURE PJProj_OrdProject_ASRReqEDD
	@parm1 varchar (15)
AS
	
	SELECT PJProj.*
	FROM PJProj join vs_asrreqedd on pjproj.project = vs_asrreqedd.OrdProject
	WHERE vs_asrreqedd.DocType = 'O4' and PJProj.Project like @parm1 AND PJProj.Project <> ''
	ORDER BY PJProj.Project

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJProj_OrdProject_ASRReqEDD] TO [MSDSL]
    AS [dbo];

