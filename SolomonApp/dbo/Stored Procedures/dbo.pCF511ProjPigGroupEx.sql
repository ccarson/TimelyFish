
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 

CREATE   Procedure pCF511ProjPigGroupEx
	@parm1 varchar (10)

As

Select a.*
From PJPENTEX as a, cftPigGroup as b
Where a.pjt_entity=b.TaskID
AND a.pjt_entity=@parm1
Order By a.pjt_entity 




 