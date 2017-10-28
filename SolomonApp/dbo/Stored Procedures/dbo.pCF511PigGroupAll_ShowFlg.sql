
/****** Object:  Stored Procedure dbo.pCF511PigGroupAll_ShowFlg    Script Date: 1/3/2006 8:43:06 AM ******/
-- Added new procedure for PigGroup Maint PV - filter inactive
-- Added by TJONES on 12/28/05
CREATE   Procedure [dbo].[pCF511PigGroupAll_ShowFlg]
	@parm1  smallint, -- ShowFlg 1 if include inactive, 0 if not
	@parm2  smallint, -- ShowFlg 1 if include inactive, 0 if not
	@parm3 varchar(10) -- PigGroupID or wildcard
	AS
	Select pg.*, cftSite.SiteID, pjpent.pe_id05 
	From cftPigGroup pg
	JOIN pjpent on pg.TaskID=pjpent.pjt_entity 
	JOIN cftSite on pg.SiteContactID=cftSite.ContactID 
	WHERE 
	(((pg.PGStatusID <> 'I' AND pg.PGStatusID <> 'X') AND @parm1 = 0) -- Don't show inactive
		Or
		(@parm2 = 1)) -- Show all including inactive
	AND pg.PigGroupID LIKE @parm3
	Order by pg.SiteContactID, pg.PigGroupID, pg.EstStartDate Desc


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF511PigGroupAll_ShowFlg] TO [MSDSL]
    AS [dbo];

