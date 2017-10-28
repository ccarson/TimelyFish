
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 

/****** Object:  Stored Procedure dbo.pCF511ProjPigGroup    Script Date: 8/26/2004 9:57:25 AM ******/
CREATE  Procedure pCF511ProjPigGroup 
	@parm1 varchar (10)

As

Select a.*
From PJPENT as a, cftPigGroup as b
Where a.pjt_entity=b.TaskID
AND a.pjt_entity=@parm1
Order By a.pjt_entity 



 