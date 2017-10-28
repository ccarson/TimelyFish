
/****** Object:  View dbo.cfvLastBinReading    Script Date: 2/1/2006 10:48:02 AM ******/

CREATE  view cfvLastBinReading
as
select 
b.contactid, b.binnbr, MillID = max(s.feedmillcontactid),
--LastBinReadingDate = max(ISNULL(r.binreadingdate, '01/01/1900'))
LastBinReadingDate = CONVERT(varchar(10), max(ISNULL(r.binreadingdate, '01/01/1900')),101)
from cftBin b
	left join cftBinReading r on b.contactid = r.sitecontactid
	and b.binnbr = r.binnbr
	left join cftSite s on b.contactid = s.contactid
	join cftContact c on c.contactid = b.contactid      
        join cftBinType t on b.bintypeid = t.bintypeid
where b.active = -1
and s.deliverfeedflag = -1 
and c.statustypeid <> '2'
and description not like '%creep%'
group by b.contactid, b.binnbr


 
