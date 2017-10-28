
create view dbo.tmpsiteaddress

as 

select s.SiteID, a.ShipToID, c.contactname, a.name, c.shortname, a.descr,

centraladdr = rtrim(s.addr1) + ' ' + rtrim(s.addr2) + ' ' + rtrim(s.city)

 + ' ' + rtrim(s.state) + ' ' + rtrim(s.zip),

serviceaddress = rtrim(a.addr1) + ' ' + rtrim(a.addr2) + ' ' + rtrim(a.city)

 + ' ' + rtrim(a.state) + ' ' + rtrim(a.zip)

from dbo.cfvSite s

left join soaddress a on s.siteid = a.shiptoid

left join cftcontact c on s.contactid = c.contactid

where c.StatusTypeID=1
