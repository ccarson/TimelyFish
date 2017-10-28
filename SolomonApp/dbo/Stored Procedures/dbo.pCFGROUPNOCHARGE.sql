
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 

CREATE      Proc pCFGROUPNOCHARGE
	
AS
	Select *
	From cftPigGroup pg
	JOIN PJPENT pj ON pg.TaskID=pj.pjt_entity
	JOIN PJCHARGD pjc ON pj.Project=pjc.Project AND pj.pjt_entity=pjc.pjt_entity
	Where pg.Crtd_User='IMPORT' and pjc.pjt_entity IS NULL


 