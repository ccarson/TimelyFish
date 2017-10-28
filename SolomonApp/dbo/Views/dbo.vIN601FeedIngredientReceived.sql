Create View dbo.vIN601FeedIngredientReceived
as

Select s.SiteID,s.Name, int.InvtID,i.Descr,int.PerEnt,int.Qty,int.UnitDesc,
Value=Qty*UnitPrice
FROM 
INTran int 
JOIN Inventory i on int.InvtID=i.InvtID
JOIN Site s on int.SiteID=s.SiteID
where int.TranType='RC' and i.ClassID='ING'
and int.ReasonCd<>'BB' and int.JrnlType like 'IN%'

UNION
Select s.SiteID,s.Name,po.InvtID,i.Descr,po.PerEnt,po.RcptQty, po.UnitDescr,
Value=RcptQty*UnitCost
From
POTran po
JOIN Inventory i on po.InvtID=i.InvtID
JOIN Site s on po.SiteID=s.SiteID
where i.ClassID='ING'
