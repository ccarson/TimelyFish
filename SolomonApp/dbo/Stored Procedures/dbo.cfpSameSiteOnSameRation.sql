
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
CREATE PROC cfpSameSiteOnSameRation
	(@SiteContactID varchar(6),
	@RationID varchar(30))
	AS

	SELECT fo.BinNbr, bt.BinCapacity, 
		fo.tstamp 
	FROM cftFeedOrder fo
	JOIN cftBin b ON fo.ContactID = b.ContactID 
		AND fo.BarnNbr = b.BarnNbr
		AND fo.BinNbr = b.BinNbr
	JOIN cftBinType bt ON b.BinTypeID = bt.BinTypeID
	LEFT JOIN cftPigGroup pg ON fo.PigGroupID = pg.PigGroupID
	WHERE FO.ContactID = @SiteContactID
	AND fo.InvtIdOrd = @RationID 
	AND fo.StageOrd >= (Select Max(StageOrd) from cftFeedOrder
		WHERE ContactID = fo.ContactID
			AND fo.BarnNbr = BarnNbr 
			AND fo.BinNbr = BinNbr
			AND fo.PigGroupID = PigGroupID)
	AND fo.Reversal = 0
	AND (FO.piggroupid = '' or pg.PGStatusID In('F','A'))
	ORDER BY fo.BinNbr, bt.BinCapacity

 
GO
GRANT CONTROL
    ON OBJECT::[dbo].[cfpSameSiteOnSameRation] TO [MSDSL]
    AS [dbo];

