 CREATE PROCEDURE ADG_SOPrintQueue_RollbackNbrs
	@RI_ID 	smallint as

declare
  @rowcount int,
  @error int

set nocount on

select
  @rowcount = 1

begin tran

/*rollback numbers taken from SOType*/
while @rowcount > 0
begin
update y set
  y.LastInvcNbr = right('0000000000' + convert(varchar(15),convert(int, y.LastInvcNbr) - 1), len(y.LastInvcNbr))
from
(select top 1 y.CpnyID, SOTypeID = coalesce(y2.SOTypeID, y.SOTypeID)
from
SOPrintQueue q
inner join SOShipHeader h on h.CpnyID = q.CpnyID and h.ShipperID = q.ShipperID
inner join SOType y on y.CpnyID = h.CpnyID and y.SOTypeID = h.SOTypeID
left join SOType y2 on y2.CpnyID = y.CpnyID and y2.SOTypeID = y.InvcNbrType
where q.RI_ID = @RI_ID and q.S4Future11 = '40680' and (q.S4Future09 & 1) = 1 and rtrim(rtrim(y.InvcNbrPrefix)+coalesce(y2.LastInvcNbr,y.LastInvcNbr)) = rtrim(q.InvcNbr)) v
inner join SOType y on y.CpnyID = v.CpnyID and y.SOTypeID = v.SOTypeID
select @rowcount = @@rowcount, @error = @@error
if @error <> 0 begin rollback return end
end

update h set  
	h.ShipDateAct = q.S4Future08
from SOPrintQueue q  
	inner join SOShipHeader h 
		on h.CpnyID = q.CpnyID 
			and h.ShipperID = q.ShipperID  
where q.RI_ID = @RI_ID 
	and q.S4Future11 = '40680' 

select
  @rowcount = 1

/*rollback numbers taken from ARSetup*/
while @rowcount > 0
begin
update y set
  y.LastRefNbr = reverse(
    stuff(reverse(rtrim(y.LastRefNbr)), 1, patindex('%[1-9]%', reverse(rtrim(y.LastRefNbr))),
    replicate('9',patindex('%[1-9]%', reverse(rtrim(y.LastRefNbr)))-1) +
    convert(char(1),convert(int, substring(reverse(rtrim(y.LastRefNbr)),patindex('%[1-9]%', reverse(rtrim(y.LastRefNbr))),1))-1)
    ))
from
(select top 1 SetupID
from
SOPrintQueue q
inner join SOShipHeader h on h.CpnyID = q.CpnyID and h.ShipperID = q.ShipperID
inner join SOType y on y.CpnyID = h.CpnyID and y.SOTypeID = h.SOTypeID
cross join ARSetup
where q.RI_ID = @RI_ID and y.InvcNbrAR = 1 and q.S4Future11 = '40680' and (q.S4Future09 & 1) = 1 and LastRefNbr = q.InvcNbr) v
inner join ARSetup y on y.SetupID = v.SetupID
select @rowcount = @@rowcount, @error = @@error
if @error <> 0 begin rollback return end
end

select @rowcount = PrenumberedForms from SOSetup

while @rowcount > 0
begin
update c set
  c.NextInvcNbr = v.InvcNbr
from
(select top 1 c.CpnyID, c.ReportName, q.InvcNbr
from
SOPrintQueue q
inner join RptRuntime r on r.RI_ID = q.RI_ID
inner join SOPrintCounters c on c.CpnyID = r.CpnyID and c.ReportName = r.ReportNbr
where q.RI_ID = @RI_ID and q.S4Future11 = '40680' and
c.NextInvcNbr = reverse(
stuff(reverse(rtrim(q.InvcNbr)), 1, patindex('%[0-8]%', reverse(rtrim(q.InvcNbr))),
replicate('0', patindex('%[0-8]%', reverse(rtrim(q.InvcNbr)))-1) +
convert(char(1), convert(int, substring(reverse(rtrim(q.InvcNbr)), patindex('%[0-8]%', reverse(rtrim(q.InvcNbr))), 1))+1)
))) v
inner join SOPrintCounters c on c.CpnyID = v.CpnyID and c.ReportName = v.ReportName
select @rowcount = @@rowcount, @error = @@error
if @error <> 0 begin rollback return end
end

delete r from
SOPrintQueue q
inner join RefNbr r on r.RefNbr = q.InvcNbr
cross join SOSetup (nolock)
--when using prenumbered forms we should NOT be able to enter invoice number in shipper screen and should always delete RefNbrs
where q.RI_ID = @RI_ID and q.S4Future11 = '40680' and ((q.S4Future09 & 1) = 1 or PrenumberedForms = 1)
if @@error <> 0 begin rollback return end

commit


