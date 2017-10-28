

/****** Object:  View dbo.cfvBin    Script Date: 12/8/2004 8:29:05 PM ******/
CREATE  View cfvBin (Active, BarnNbr, BinNbr, BinSortOrder, BinTypeDesc, Capacity, ContactID, FeedingLevel, RoomNbr, Tstamp) as
/* Used in programs:  CF300, CF303
   Referenced in:  CF301
*/
    Select Coalesce(b.Active, 0), Coalesce(n.BarnNbr, ''), b.BinNbr, Coalesce(b.BinSortOrder, 0), Coalesce(t.Description, ''), Coalesce(t.BinCapacity, 0), 
	Coalesce(c.ContactID, ''), b.FeedingLevel, Coalesce(b.RoomNbr, ''), Convert(timestamp, 0)
	from cftBin b Join cftContact c On b.ContactId = c.ContactId
	Left Join cftBarn n On b.ContactId = n.ContactId and b.BarnNbr = n.BarnNbr
	Left Join cftBinType t on t.BinTypeId = b.BinTypeId


 