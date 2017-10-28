

--*************************************************************
--	Purpose: Displays groups that split but do not have source group info
--	Author:Charity Anderson
--	Date: 9/14/2005
--	Usage: Split Pig Group Exception Report
--	Parms: --
--*************************************************************
CREATE     VIEW dbo.vXP638SplitPigGroup

AS
select c.ContactName, pg.PigGroupID, pg.BarnNbr, 
BarnType = ft.Description, pg.PGStatusID, pp.PhaseDesc, pg.SplitSrcPigGroupID
	from cftPigGroup pg
	JOIN cftPigProdPhase pp ON pg.PigProdPhaseID = pp.PigProdPhaseID
	JOIN cftBarn b ON pg.SiteContactID = b.ContactID AND pg.BarnNbr = b.BarnNbr
	JOIN cftFacilityType ft ON b.FacilityTypeID = ft.FacilityTypeID
	JOIN cftContact c ON pg.SiteContactID = c.ContactID
	LEFT JOIN cftPM pm ON pg.PigGroupID = pm.DestPigGroupID
	WHERE pg.PigProdPhaseID = 'FIN'
	AND PGStatusID In('P','F','A')
	AND pm.DestPigGroupID Is Null
	AND b.FacilityTypeID = '005'
	AND pg.SplitSrcPigGroupID = ''

 