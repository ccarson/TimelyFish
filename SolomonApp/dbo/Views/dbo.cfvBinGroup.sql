

--*************************************************************
--	Purpose: Show all available bins for a Pig Group  
--	Author: Sue Matter
--	Date: 9/19/2006
--	Usage: XF616 Tag Bin Report		 
--	Parms: 
--*************************************************************

CREATE    View [dbo].[cfvBinGroup] (PigGroup, Active, BarnNbr, BinNbr, BinSortOrder, BinTypeDesc, Capacity, ContactID, FeedingLevel, RoomNbr, Tstamp) as

    Select pg.PigGroupID, Coalesce(b.Active, 0), Coalesce(n.BarnNbr, ''), b.BinNbr, Coalesce(b.BinSortOrder, 0), Coalesce(t.Description, ''), Coalesce(t.BinCapacity, 0), 
	Coalesce(c.ContactID, ''), b.FeedingLevel, Coalesce(b.RoomNbr, ''), Convert(timestamp, 0)
	from cftPigGroup pg (NOLOCK)
	Join cftContact c (NOLOCK) On pg.SiteContactId = c.ContactId 
	JOIN cftBin b (NOLOCK) ON c.ContactID = b.ContactID AND b.BarnNbr=pg.BarnNbr
	Left Join cftBarn n (NOLOCK) On b.ContactId = n.ContactId and b.BarnNbr = n.BarnNbr
	Left Join cftBinType t (NOLOCK) on t.BinTypeId = b.BinTypeId


 