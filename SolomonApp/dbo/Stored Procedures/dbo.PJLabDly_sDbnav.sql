 CREATE PROCEDURE PJLabDly_sDbnav  @Parm1 varchar (10) , @parm2 varchar (4) , @Parm3Min smallint , @Parm3Max smallint  AS

SELECT PJLABDLY.*, pjproj.*, pjpent.*, PJLabdly.*
from   PJLABDLY
	left outer join PJPROJ
		on 	pjlabdly.project = pjproj.project
	left outer join PJPENT
		on 	pjlabdly.project = pjpent.project
		and pjlabdly.pjt_entity = pjpent.pjt_entity
WHERE  docNbr = @Parm1 AND
	  ldl_SiteId = @Parm2 AND
	  lineNbr BETWEEN @Parm3Min AND @Parm3Max
ORDER BY pjlabdly.DocNbr, pjlabdly.ldl_SiteId, pjlabdly.lineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJLabDly_sDbnav] TO [MSDSL]
    AS [dbo];

