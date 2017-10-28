
/****** Object:  Stored Procedure dbo.pCF511GroupBarn    Script Date: 4/20/2005 3:20:26 PM ******/

CREATE   Procedure pCF511GroupBarn
	@parm1 varchar(10), @parm2 varchar(6)

as
		Select cftBarn.* 
	From cftBarn
	--Left Join cftSite on cftBarn.SiteID=cftSite.SiteID
	--WHERE cftSite.ContactID=@parm1
	Where ContactID=@parm1
		AND cftBarn.StatusTypeID='1' AND cftBarn.BarnNbr LIKE @parm2
	Order by BarnNbr, BarnDescription 




GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF511GroupBarn] TO [MSDSL]
    AS [dbo];

