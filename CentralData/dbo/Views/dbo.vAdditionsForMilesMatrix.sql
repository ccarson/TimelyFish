
Create View dbo.vAdditionsForMilesMatrix
	As
     select afrom.addressid As AddressIDFrom, afrom.latitude As AddressFromLatitude, afrom.longitude as AddressFromLongitude, 
	ato.addressid As AddressIDTo, ato.latitude as AddressToLatitude, ato.longitude As AddressToLongitude
	from dbo.address afrom
	join dbo.address ato on afrom.addressid <> ato.addressid
	left outer join dbo.milesmatrix mm on afrom.addressid = mm.addressidfrom and ato.addressid = mm.addressidto
	where mm.onewaymiles is null and 
	afrom.longitude is not null 
	and afrom.latitude <> 0
	and ato.longitude is not null
	and ato.latitude <> 0
	--and ato.addressid not in (select distinct addressid from addressidtemp)


