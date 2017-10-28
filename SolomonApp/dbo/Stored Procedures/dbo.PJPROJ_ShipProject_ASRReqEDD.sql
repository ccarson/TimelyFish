 create procedure PJPROJ_ShipProject_ASRReqEDD  
	@parm1 varchar (16)
AS

SELECT PJProj.* 
from PJProj JOIN vs_asrreqedd ON PJProj.Project = vs_asrreqedd.ShipProject AND vs_asrreqedd.DocType = 'O4' 
WHERE  PJProj.Project like @parm1 and PJProj.Project <> '' 
ORDER BY PJProj.Project

