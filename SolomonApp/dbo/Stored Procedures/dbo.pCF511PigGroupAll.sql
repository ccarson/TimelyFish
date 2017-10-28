
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 



CREATE  Procedure pCF511PigGroupAll
	@parm1  varchar(10)


AS
Select cftPigGroup.*, cftSite.SiteID, pjpent.pe_id05 
From cftPigGroup 
JOIN pjpent on cftPigGroup.TaskID=pjpent.pjt_entity 
JOIN cftSite on cftPigGroup.SiteContactID=cftSite.ContactID 
WHERE cftPigGroup.PigGroupID LIKE @parm1 
Order by cftPigGroup.SiteContactID, cftPigGroup.PigGroupID




 