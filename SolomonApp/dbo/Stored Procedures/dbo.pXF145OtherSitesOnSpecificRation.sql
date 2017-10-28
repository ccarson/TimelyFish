


/*
===============================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2012-05-10  Doran D,    Included a inline table that gets the max value for dateord and stageord  for each contactid, barnnbr, binnbr, piggroupid.   
( lists the last order date for any kind of ration) 
			Steve R.    The sql then includes only those rows where for a specified contactid,ration; there is a hit if the order date >= the value from the inline table.
2012-10-11	sripley     Modified the code and added an index for better accuracy and better performance.
2012-10-22  sripley     data was not pulling back the proper data, still getting sites what were not currently feeding the ration.
===============================================================================
*/

CREATE PROC [dbo].[pXF145OtherSitesOnSpecificRation]
	(@SiteContactID varchar(6), @SiteAddrID varchar(6),
	@RationID varchar(30))
	AS

SELECT others.ContactID, c.ContactName, others.BinNbr, bt.BinCapacity, 
		OneWayMiles = Round(mm.OneWayMiles,2)
		,min(others.tstamp) 
FROM
 (SELECT ContAddrID, InvtIdOrd, max(dateord) dateord
   FROM cftfeedorder (nolock)
   where ContAddrID = @SiteAddrID and InvtIdOrd = @RationID
   and ordtype <> 'FL'			-- do not include Flush events  20130826 sripley as per user request (Jacque H)
   group by ContAddrID, InvtIdOrd) src
join (select contactid, ContAddrID, barnnbr, binnbr,InvtIdOrd, reversal, piggroupid,tstamp, max(dateord) dateord
	  from cftfeedorder (nolock)
      where InvtIdOrd = @RationID and dateord > getdate() - 30
      and ordtype <> 'FL'			-- do not include Flush events  20130826 sripley as per user request (Jacque H)
      group by contactid, ContAddrID, barnnbr, binnbr,InvtIdOrd, reversal, piggroupid, tstamp  ) others
	on others.InvtIdOrd = src.InvtIdOrd and others.dateord >= src.dateord - 7
JOIN cftContact c  (nolock) ON others.ContactID = c.ContactID
JOIN cftBin b  (nolock) ON others.ContactID = b.ContactID 
            AND others.BarnNbr = b.BarnNbr
            AND others.BinNbr = b.BinNbr
jOIN cftBinType bt  (nolock) ON b.BinTypeID = bt.BinTypeID
LEFT JOIN cftPigGroup pg  (nolock) ON others.PigGroupID = pg.PigGroupID
LEFT JOIN cftMilesMatrix mm  (nolock) ON others.ContAddrID = mm.AddressIDTo
      WHERE
      others.Reversal = 0
      AND mm.AddressIDFrom = @SiteAddrID
      AND (others.piggroupid = '' or pg.PGStatusID In('F','A'))
      GROUP BY mm.OneWayMiles, others.ContactID, c.ContactName, others.BinNbr, bt.BinCapacity
      ORDER BY mm.OneWayMiles, others.ContactID, others.BinNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF145OtherSitesOnSpecificRation] TO [MSDSL]
    AS [dbo];

