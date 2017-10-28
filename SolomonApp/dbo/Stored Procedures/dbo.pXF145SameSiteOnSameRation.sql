



CREATE PROC [dbo].[pXF145SameSiteOnSameRation]
	(@SiteContactID varchar(6),
	@RationID varchar(30))
	AS

	SELECT fo.BinNbr, bt.BinCapacity,fo.tstamp
	FROM cftFeedOrder fo (nolock)
	JOIN cftBin b  (nolock) ON fo.ContactID = b.ContactID 
		AND fo.BarnNbr = b.BarnNbr
		AND fo.BinNbr = b.BinNbr
	JOIN cftBinType bt  (nolock) ON b.BinTypeID = bt.BinTypeID
	LEFT JOIN cftPigGroup pg  (nolock) ON fo.PigGroupID = pg.PigGroupID
-- 20130809 sripley (user request to limit to only those bins that last received the specific ration
	inner join 
	(select contactid, binnbr, max(datedel) datedel from cftFeedOrder (nolock) 
	 where contactid = @SiteContactID 
	 and dateord > getdate() - 90	-- performance requirement
	 and ordtype <> 'FL'			-- do not include Flush events  20130826 sripley as per user request (Jacque H)
	 group by contactid, binnbr) mfo
		on mfo.contactid = fo.contactid and mfo.datedel = fo.datedel and mfo.binnbr = fo.binnbr
-- 20130809 sripley - end of new code
	WHERE FO.ContactID = @SiteContactID
	AND fo.InvtIdOrd = @RationID
	and fo.dateord > getdate() - 90			-- added this line 20121011 sripley and added supporting index 
	AND fo.StageOrd >= (Select Max(StageOrd) from cftFeedOrder (nolock)
		WHERE ContactID = fo.ContactID
			AND fo.BarnNbr = BarnNbr 
			AND fo.BinNbr = BinNbr
			AND fo.PigGroupID = PigGroupID
			and fo.InvtIdOrd = InvtIdOrd	-- added this line 20121011 sripley only concerned about the specific ration
			and dateord > getdate() - 90	-- added this line 20121011 sripley and added supporting index
			and ordtype <> 'FL'			-- do not include Flush events  20130826 sripley as per user request (Jacque H)
			)
	AND fo.Reversal = 0
	AND (FO.piggroupid = '' or pg.PGStatusID In('F','A'))
	ORDER BY fo.BinNbr, bt.BinCapacity




