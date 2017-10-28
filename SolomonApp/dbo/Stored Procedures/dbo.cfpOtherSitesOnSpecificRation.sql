
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
CREATE PROC cfpOtherSitesOnSpecificRation
	(@SiteContactID varchar(6), @SiteAddrID varchar(6),
	@RationID varchar(30))
	AS

	SELECT fo.ContactID, c.ContactName, fo.BinNbr, bt.BinCapacity, 
		OneWayMiles = Round(mm.OneWayMiles,2),
		min(fo.tstamp) 
	FROM cftFeedOrder fo
	JOIN cftContact c ON fo.ContactID = c.ContactID
	JOIN cftBin b ON fo.ContactID = b.ContactID 
		AND fo.BarnNbr = b.BarnNbr
		AND fo.BinNbr = b.BinNbr
	JOIN cftBinType bt ON b.BinTypeID = bt.BinTypeID
	LEFT JOIN cftPigGroup pg ON fo.PigGroupID = pg.PigGroupID
	LEFT JOIN cftMilesMatrix mm ON fo.ContAddrID = mm.AddressIDTo
	WHERE
	fo.InvtIdOrd = @RationID 
	AND fo.StageOrd >= (Select Max(StageOrd) from cftFeedOrder
		WHERE ContactID = fo.ContactID
			AND fo.BarnNbr = BarnNbr 
			AND fo.BinNbr = BinNbr
			AND fo.PigGroupID = PigGroupID)
	AND fo.Reversal = 0
	AND mm.AddressIDFrom = @SiteAddrID
	AND (FO.piggroupid = '' or pg.PGStatusID In('F','A'))
	GROUP BY mm.OneWayMiles, fo.ContactID, c.ContactName, fo.BinNbr, bt.BinCapacity
	ORDER BY mm.OneWayMiles, fo.ContactID, fo.BinNbr

 
GO
GRANT CONTROL
    ON OBJECT::[dbo].[cfpOtherSitesOnSpecificRation] TO [MSDSL]
    AS [dbo];

