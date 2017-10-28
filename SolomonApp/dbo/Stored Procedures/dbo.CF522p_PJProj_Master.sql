CREATE  Procedure dbo.CF522p_PJProj_Master 
	@parm1 varchar(6)
AS 
Select Min(CF03)
From cftPigGroup 
Where CostFlag=1 
AND PGStatusID='I'
AND ISNULL(CF03,'') <> ''
AND PigProdPhaseID IN ('NUR','WTF','FIN')
AND SiteContactID=@parm1 




 
GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF522p_PJProj_Master] TO [MSDSL]
    AS [dbo];

