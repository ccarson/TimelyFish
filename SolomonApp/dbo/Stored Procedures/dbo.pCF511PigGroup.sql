
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 

/****** Object:  Stored Procedure dbo.pCF511PigGroup    Script Date: 1/6/2005 4:20:17 PM ******/
CREATE  Procedure pCF511PigGroup
	@parm1 varchar(6), @parm2 varchar(10)
as
	Select cftPigGroup.* 
	From cftPigGroup
	WHERE cftPigGroup.SiteContactID LIKE @parm1
	AND cftPigGroup.PigGroupID LIKE @parm2
	Order by cftPigGroup.SiteContactID, cftPigGroup.PigGroupID 



 