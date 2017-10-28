CREATE   VIEW dbo.vXT605MarketTrucking

AS
select c.contactname as Trucker, ps.pmloadid as LoadNbr, c3.contactname as Packer, 
c2.contactname as Site, ps.barnnbr, ps.saledate, sd.WgtLive as Livewgt, 
ps.amttruck as TruckingCost, ps.headcount, dt.descr as Type, sd.qty,
sd.DetailTypeID,pm.TruckerContactID,ps.PkrContactID,ps.SiteContactID,

Case when sd.DetailTypeID in ('AB','BB','BO','CP','HV','IB','LT','RR','SB','TB')
	THEN sd.Qty else 0 end as SubQty,
Case when sd.DetailTypeID in ('SS')
	THEN sd.Qty else 0 end as StdQty,
Case when sd.DetailTypeID in ('CD','DT','DY')
	THEN sd.Qty else 0 end as DeadQty, ps.PigGroupID
from cftpm as pm
join cftcontact as c on (pm.truckercontactid = c.contactid)
join cftpigsale as ps on (pm.pmid = ps.pmloadid)
Join cftcontact as c2 on (ps.sitecontactid = c2.contactid)
join cftpsdetail as sd on (ps.refnbr = sd.refnbr)
join cftpsdetailtype as dt on (sd.detailtypeid = dt.detailtypeid)
Join cftcontact as C3 on (ps.pkrcontactid = c3.contactid)
LEFT JOIN cftPigSale rev on (ps.RefNbr=rev.OrigRefNbr)
where ps.DocType<>'RE' and rev.RefNbr is null


