Create View dbo.vSowBreedResultByObserver
AS


Select mo.FarmID,rTrim(f.FarmID) + '_' + rTrim(f.SowID) as FarmSow, 'P' + cast(mo.SowParity as varchar(2)) as Parity, 
cast(right(rtrim(wo.PICYear),2) + 'WK' + 
replicate('0',2-len(rtrim(convert(char(2),rtrim(wo.PICWeek)))))
	 			+ rtrim(convert(char(2),rtrim(wo.PICWeek))) as varchar(6)) as OriginWeek,
Case when mo.Observer is null then rtrim(mo.FarmID) + '_UNKNOWN' else rtrim(mo.FarmID) + mo.Observer end as Observer,
Case when DateDiff(day,mo.EventDate,f.EventDate)<108 then
'ForcedService' else
'Farrow' end as Account, 
Case when DateDiff(day,mo.EventDate,f.EventDate)<108 then 1
else DateDiff(day, mo.EventDate, f.EventDate) end as Value
from SowFarrowEventTemp f 
LEFT JOIN SowGroupEventTemp g on f.FarmID=g.FarmID and f.SowID=g.SowID and f.SowParity=g.SowParity and g.SortCode<f.SortCode
LEFT JOIN SowTemp s on f.SowID=s.SowID and f.FarmID=s.FarmID
--LEFT JOIN SowMatingEventTemp me on me.FarmID=f.FarmID and me.SowID=f.SowID and me.SowParity=f.SowParity-1 and me.MatingNbr=1

JOIN SowMatingEvent mo on s.Origin=mo.FarmID and (mo.SowID like s.SowID + '%')  and mo.EventDate between (f.EventDate-140) and s.EntryDate
--and mo.MatingNbr=1
and ((mo.MatingNbr=1 and isnull(mo.Observer,'UNKNOWN') not like 'CYCLE%') or (mo.MatingNbr=2 and isnull(mo.Observer,'UNKNOWN') like 'CYCLE%')) 
 and mo.SowParity=f.SowParity-1
and DateDiff(day,mo.EventDate,f.EventDate)<135 
--LEFT JOIN WeekDefinitionTemp w on me.WeekOfDate=w.WeekOfDate
JOIN WeekDefinitionTemp wo on mo.WeekOfDate=wo.WeekOfDate

where g.FarmID is null
--and mo.SowID like '012775%'

--From Origin Total Born
UNION
Select mo.FarmID,rTrim(f.FarmID) + '_' + rTrim(f.SowID) as FarmSow, 'P' + cast(mo.SowParity as varchar(2)), 
cast(right(rtrim(wo.PICYear),2) + 'WK' + 
replicate('0',2-len(rtrim(convert(char(2),rtrim(wo.PICWeek)))))
	 			+ rtrim(convert(char(2),rtrim(wo.PICWeek))) as varchar(6)) as OriginWeek,
Case when mo.Observer is null then rtrim(mo.FarmID) + '_UNKNOWN' else rtrim(mo.FarmID) + mo.Observer end,
'TotalPigsBorn' as Account, Value=f.QtyBornAlive+f.QtyStillBorn+f.QtyMummy
from SowFarrowEventTemp f 
LEFT JOIN SowGroupEventTemp g on f.FarmID=g.FarmID and f.SowID=g.SowID and f.SowParity=g.SowParity and g.SortCode<f.SortCode
LEFT JOIN SowTemp s on f.SowID=s.SowID and f.FarmID=s.FarmID
--LEFT JOIN SowMatingEventTemp me on me.FarmID=f.FarmID and me.SowID=f.SowID and me.SowParity=f.SowParity-1 and me.MatingNbr=1
JOIN SowMatingEvent mo on s.Origin=mo.FarmID and (mo.SowID like s.SowID + '%') and mo.EventDate between (f.EventDate-140) and s.EntryDate
and ((mo.MatingNbr=1 and isnull(mo.Observer,'UNKNOWN') not like 'CYCLE%') or (mo.MatingNbr=2 and isnull(mo.Observer,'UNKNOWN') like 'CYCLE%')) and mo.SowParity=f.SowParity-1
and DateDiff(day,mo.EventDate,f.EventDate)<135 
--LEFT JOIN WeekDefinitionTemp w on me.WeekOfDate=w.WeekOfDate
JOIN WeekDefinitionTemp wo on mo.WeekOfDate=wo.WeekOfDate
where g.FarmID is null and DateDiff(day,mo.EventDate,f.EventDate)>=110
--and mo.SowId like '012775%'

--From Origin Aborts
UNION
Select mo.FarmID,rTrim(f.FarmID) + '_' + rTrim(f.SowID) as FarmSow, 'P' + cast(mo.SowParity as varchar(2)), 
cast(right(rtrim(wo.PICYear),2) + 'WK' + 
replicate('0',2-len(rtrim(convert(char(2),rtrim(wo.PICWeek)))))
	 			+ rtrim(convert(char(2),rtrim(wo.PICWeek))) as varchar(6)) as OriginWeek,
Case when mo.Observer is null then rtrim(mo.FarmID) + '_UNKNOWN' else rtrim(mo.FarmID) + mo.Observer end,
f.EventType as Account, Value =DateDiff(day,mo.EventDate,f.EventDate)
from SowFalloutEventTemp f 
LEFT JOIN SowGroupEventTemp g on f.FarmID=g.FarmID and f.SowID=g.SowID and f.SowParity=g.SowParity and g.SortCode<f.SortCode
LEFT JOIN SowTemp s on f.SowID=s.SowID
JOIN SowMatingEvent mo on s.Origin=mo.FarmID and (mo.SowID like s.SowID + '%') and mo.EventDate between (f.EventDate-140) and s.EntryDate
and ((mo.MatingNbr=1 and isnull(mo.Observer,'UNKNOWN') not like 'CYCLE%') or (mo.MatingNbr=2 and isnull(mo.Observer,'UNKNOWN') like 'CYCLE%')) and mo.SowParity=f.SowParity
and f.SortCode<=mo.SortCode+2
JOIN WeekDefinitionTemp wo on mo.WeekOfDate=wo.WeekOfDate
where g.FarmID is null

--From Origin Removals
UNION
Select mo.FarmID,rTrim(f.FarmID) + '_' + rTrim(f.SowID) as FarmSow, 'P' + cast(mo.SowParity as varchar(2)), 
cast(right(rtrim(wo.PICYear),2) + 'WK' + 
replicate('0',2-len(rtrim(convert(char(2),rtrim(wo.PICWeek)))))
	 			+ rtrim(convert(char(2),rtrim(wo.PICWeek))) as varchar(6)) as OriginWeek,
Case when mo.Observer is null then rtrim(mo.FarmID) + '_UNKNOWN' else rtrim(mo.FarmID) + mo.Observer end,
f.RemovalType as Account, Value=DateDiff(day,mo.EventDate,f.EventDate)
from SowRemoveEventTemp f 
LEFT JOIN SowFalloutEventTemp fo on fo.FarmID=f.FarmID and fo.SowID=f.SowID and fo.SowParity=f.SowParity
LEFT JOIN SowGroupEventTemp g on f.FarmID=g.FarmID and f.SowID=g.SowID and f.SowParity=g.SowParity and g.SortCode<f.SortCode
LEFT JOIN SowTemp s on f.SowID=s.SowID and f.FarmID=s.FarmID
JOIN SowMatingEvent mo on s.Origin=mo.FarmID and (mo.SowID like s.SowID + '%') and mo.EventDate between (f.EventDate-140) and s.EntryDate
and ((mo.MatingNbr=1 and isnull(mo.Observer,'UNKNOWN') not like 'CYCLE%') or (mo.MatingNbr=2 and isnull(mo.Observer,'UNKNOWN') like 'CYCLE%')) and mo.SowParity=f.SowParity
and f.SortCode<=mo.SortCode+2
JOIN WeekDefinitionTemp wo on mo.WeekOfDate=wo.WeekOfDate and f.RemovalType<>'TRANSFER'
where g.FarmID is null and fo.FarmID is null

--From OrigiRecyclen 
UNION
Select mo.FarmID, rTrim(s.FarmID) + '_' + rTrim(s.SowID) as FarmSow, 'P' + cast(mo.SowParity as varchar(2)), 
cast(right(rtrim(wo.PICYear),2) + 'WK' + 
replicate('0',2-len(rtrim(convert(char(2),rtrim(wo.PICWeek)))))
	 			+ rtrim(convert(char(2),rtrim(wo.PICWeek))) as varchar(6)) as OriginWeek,
Case when mo.Observer is null then rtrim(mo.FarmID) + '_UNKNOWN' else rtrim(mo.FarmID) + mo.Observer end,
Account=
'Recycle', DateDiff(day,mo.EventDate,g.EventDate) as Value
from SowMatingEvent mo 
JOIN SowRemoveEvent r on mo.FarmID=r.FarmID and mo.SowID=r.SowID and r.RemovalType='TRANSFER'
JOIN SowTemp s on r.PrimaryReason=s.FarmID and r.SowID like (s.SowID + '%') and s.EntryDate between r.EventDate and (r.EventDate+135)
JOIN WeekDefinition wo on mo.WeekOfDate=wo.WeekOfDate
LEFT JOIN vFirstGroupEvent fg on fg.FarmID=s.FarmID and fg.SowID=s.SowID 
LEFT JOIN SowGroupEventTemp g on g.FarmID=s.FarmID and g.SowID=s.SowID and g.SortCode=fg.FirstGroup
LEFT JOIN  SowFarrowEventTemp f on (s.FarmID=f.FarmID) and (s.SowID = f.SowID) and 
(f.EventDate between (mo.EventDate + 95) and (mo.EventDate + 135)) 
and ((mo.MatingNbr=1 and isnull(mo.Observer,'UNKNOWN') not like 'CYCLE%') or (mo.MatingNbr=2 and isnull(mo.Observer,'UNKNOWN') not like 'CYCLE%'))
and (f.SowParity=(mo.SowParity + 1)) and f.SortCode<g.SortCode
LEFT JOIN SowFalloutEventTemp fo on s.FarmID=fo.FarmID and s.SowID=fo.SowID and mo.SowParity=fo.SowParity and fo.EventDate<=g.EventDate
	and fo.SortCode<g.SortCode
where f.FarmID is null   and mo.MatingNbr=1 and g.EventDate<mo.EventDate+250 and 
fo.FarmID is null and g.SowParity=mo.SowParity and DateDiff(day,mo.EventDate,g.EventDate)<120
--and mo.SowID='015224'

--From Origin Fail to Farrow
UNION
Select mo.FarmID, rTrim(s.FarmID) + '_' + rTrim(s.SowID) as FarmSow, 'P' + cast(mo.SowParity as varchar(2)), 
cast(right(rtrim(wo.PICYear),2) + 'WK' + 
replicate('0',2-len(rtrim(convert(char(2),rtrim(wo.PICWeek)))))
	 			+ rtrim(convert(char(2),rtrim(wo.PICWeek))) as varchar(6)) as OriginWeek,
Case when mo.Observer is null then rtrim(mo.FarmID) + '_UNKNOWN' else rtrim(mo.FarmID) + mo.Observer end,
Account=
'FailtoFarrow', DateDiff(day,mo.EventDate,g.EventDate) as Value
from SowMatingEvent mo 
JOIN SowRemoveEvent r on mo.FarmID=r.FarmID and mo.SowID=r.SowID and r.RemovalType='TRANSFER'
JOIN SowTemp s on r.PrimaryReason=s.FarmID and r.SowID like (s.SowID + '%') and  s.EntryDate between r.EventDate and (r.EventDate+135)
JOIN WeekDefinition wo on mo.WeekOfDate=wo.WeekOfDate
LEFT JOIN vFirstGroupEvent fg on fg.FarmID=s.FarmID and fg.SowID=s.SowID 
LEFT JOIN SowGroupEventTemp g on g.FarmID=s.FarmID and g.SowID=s.SowID and g.SortCode=fg.FirstGroup
LEFT JOIN  SowFarrowEventTemp f on (s.FarmID=f.FarmID) and (s.SowID = f.SowID) and 
(f.EventDate between (mo.EventDate + 95) and (mo.EventDate + 135)) 
and ((mo.MatingNbr=1 and isnull(mo.Observer,'UNKNOWN') not like 'CYCLE%') or (mo.MatingNbr=2 and isnull(mo.Observer,'UNKNOWN') like 'CYCLE%'))
and (f.SowParity=(mo.SowParity + 1)) and f.SortCode<g.SortCode
LEFT JOIN SowFalloutEventTemp fo on s.FarmID=fo.FarmID and s.SowID=fo.SowID and mo.SowParity=fo.SowParity and fo.EventDate<=g.EventDate
	and fo.SortCode<g.SortCode
where f.FarmID is null   and mo.MatingNbr=1 and g.EventDate<mo.EventDate+250 and 
fo.FarmID is null and g.SowParity=mo.SowParity and DateDiff(day,mo.EventDate,g.EventDate)>=120
--Select * from vFirstGroupEvent where SowID='012909'
--From Farm Farrows
UNION
Select mo.FarmID,rTrim(f.FarmID) + '_' + rTrim(f.SowID) as FarmSow, 'P' + cast(mo.SowParity as varchar(2)), 
cast(right(rtrim(wo.PICYear),2) + 'WK' + 
replicate('0',2-len(rtrim(convert(char(2),rtrim(wo.PICWeek)))))
	 			+ rtrim(convert(char(2),rtrim(wo.PICWeek))) as varchar(6)) as OriginWeek,
Case when mo.Observer is null then rtrim(mo.FarmID) + '_UNKNOWN' else rtrim(mo.FarmID) + mo.Observer end,
Case when DateDiff(day,mo.EventDate,f.EventDate)<108 then
'ForcedService' else
'Farrow' end as Account, 
Case when DateDiff(day,mo.EventDate,f.EventDate)<108 then 1
else DateDiff(day, mo.EventDate, f.EventDate) end as Value
FROM SowMatingEventTemp mo
LEFT JOIN vSowGroupEventTempNext gn on mo.FarmID=gn.FarmID and mo.SowID=gn.SowID and mo.SortCode=gn.SortCode+1
LEFT JOIN SowGroupEventTemp ge on ge.FarmID=mo.FarmID and ge.SowID=mo.SowID and ge.SortCode=gn.NextGroup
JOIN SowFarrowEventTemp f on mo.FarmID=f.FarmID and mo.SowID=f.SowID and mo.SowParity+1=f.SowParity 
	and f.SortCode<gn.NextGroup 
LEFT JOIN SowFalloutEventTemp fo on fo.FarmID=mo.FarmID and fo.SowID=mo.SowID 
and fo.SortCode between gn.SortCode and ge.SortCode and fo.SowParity=mo.SowParity 
JOIN WeekDefinitionTemp wo on mo.WeekOfDate=wo.WeekOfDate
where fo.FarmID is null 
and ((mo.MatingNbr=1 and isnull(mo.Observer,'UNKNOWN') not like 'CYCLE%') or (mo.MatingNbr=2 and isnull(mo.Observer,'UNKNOWN') like 'CYCLE%')) 
--and mo.SowID = '010055'

--From Source Total Born
UNION
Select mo.FarmID,rTrim(f.FarmID) + '_' + rTrim(f.SowID) as FarmSow, 'P' + cast(mo.SowParity as varchar(2)), 
cast(right(rtrim(wo.PICYear),2) + 'WK' + 
replicate('0',2-len(rtrim(convert(char(2),rtrim(wo.PICWeek)))))
	 			+ rtrim(convert(char(2),rtrim(wo.PICWeek))) as varchar(6)) as OriginWeek,
Case when mo.Observer is null then rtrim(mo.FarmID) + '_UNKNOWN' else rtrim(mo.FarmID) + mo.Observer end,
'TotalPigsBorn'  as Account, (f.QtyBornAlive+f.QtyStillBorn+f.QtyMummy) as Value
FROM SowMatingEventTemp mo
LEFT JOIN vSowGroupEventTempNext gn on mo.FarmID=gn.FarmID and mo.SowID=gn.SowID and mo.SortCode=gn.SortCode+1
LEFT JOIN SowGroupEventTemp ge on ge.FarmID=mo.FarmID and ge.SowID=mo.SowID and ge.SortCode=gn.NextGroup
JOIN SowFarrowEventTemp f on mo.FarmID=f.FarmID and mo.SowID=f.SowID and mo.SowParity+1=f.SowParity 
	and f.SortCode<gn.NextGroup 
LEFT JOIN SowFalloutEventTemp fo on fo.FarmID=mo.FarmID and fo.SowID=mo.SowID 
and fo.SortCode between gn.SortCode and ge.SortCode and fo.SowParity=mo.SowParity 
JOIN WeekDefinitionTemp wo on mo.WeekOfDate=wo.WeekOfDate
where fo.FarmID is null 
and ((mo.MatingNbr=1 and isnull(mo.Observer,'UNKNOWN') not like 'CYCLE%') or (mo.MatingNbr=2 and isnull(mo.Observer,'UNKNOWN') like 'CYCLE%')) 
 and DateDiff(day,mo.EventDate,f.EventDate)>=110

--From Source Aborts
UNION
Select mo.FarmID,rTrim(mo.FarmID) + '_' + rTrim(mo.SowID) as FarmSow, 'P' + cast(mo.SowParity as varchar(2)), 
cast(right(rtrim(wo.PICYear),2) + 'WK' + 
replicate('0',2-len(rtrim(convert(char(2),rtrim(wo.PICWeek)))))
	 			+ rtrim(convert(char(2),rtrim(wo.PICWeek))) as varchar(6)) as OriginWeek,
Case when mo.Observer is null then rtrim(mo.FarmID) + '_UNKNOWN' else rtrim(mo.FarmID) + mo.Observer end,
fo.EventType as Account, DateDiff(day,mo.EventDate, fo.EventDate) as value
FROM SowMatingEventTemp mo
LEFT JOIN vSowGroupEventTempNext gn on mo.FarmID=gn.FarmID and mo.SowID=gn.SowID and mo.SortCode=gn.SortCode+1
LEFT JOIN SowGroupEventTemp ge on ge.FarmID=mo.FarmID and ge.SowID=mo.SowID and ge.SortCode=gn.NextGroup

JOIN SowFalloutEventTemp fo on fo.FarmID=mo.FarmID and fo.SowID=mo.SowID 
 and fo.SowParity=mo.SowParity and fo.SortCode  between gn.SortCode and ge.SortCode
JOIN WeekDefinitionTemp wo on mo.WeekOfDate=wo.WeekOfDate
and 
((mo.MatingNbr=1 and isnull(mo.Observer,'UNKNOWN') not like 'CYCLE%') or (mo.MatingNbr=2 and isnull(mo.Observer,'UNKNOWN') like 'CYCLE%')) 

--From Source Removals
UNION
Select mo.FarmID,rTrim(f.FarmID) + '_' + rTrim(f.SowID) as FarmSow, 'P' + cast(mo.SowParity as varchar(2)), 
cast(right(rtrim(wo.PICYear),2) + 'WK' + 
replicate('0',2-len(rtrim(convert(char(2),rtrim(wo.PICWeek)))))
	 			+ rtrim(convert(char(2),rtrim(wo.PICWeek))) as varchar(6)) as OriginWeek,
isnull(mo.Observer,'UNKNOWN'),
f.RemovalType as Account, DateDiff(day,mo.EventDate, f.EventDate) as value
FROM SowMatingEventTemp mo
LEFT JOIN vSowGroupEventTempNext gn on mo.FarmID=gn.FarmID and mo.SowID=gn.SowID and mo.SortCode=gn.SortCode+1
LEFT JOIN SowGroupEventTemp ge on ge.FarmID=mo.FarmID and ge.SowID=mo.SowID and ge.SortCode=gn.NextGroup
JOIN SowRemoveEventTemp f on mo.FarmID=f.FarmID and mo.SowID=f.SowID and mo.SowParity=f.SowParity 
	and f.SortCode<gn.NextGroup 
and f.RemovalType<>'TRANSFER'
LEFT JOIN SowFalloutEventTemp fo on fo.FarmID=mo.FarmID and fo.SowID=mo.SowID 
and fo.SortCode between gn.SortCode and ge.SortCode and fo.SowParity=mo.SowParity 
JOIN WeekDefinitionTemp wo on mo.WeekOfDate=wo.WeekOfDate
where fo.FarmID is null 
and ((mo.MatingNbr=1 and isnull(mo.Observer,'UNKNOWN') not like 'CYCLE%') or (mo.MatingNbr=2 and isnull(mo.Observer,'UNKNOWN') like 'CYCLE%')) 



--From Source Recycle
UNION
Select mo.FarmID, rTrim(mo.FarmID) + '_' + rTrim(Mo.SowID) as FarmSow, 'P' + cast(mo.SowParity as varchar(2)), 
cast(right(rtrim(wo.PICYear),2) + 'WK' + 
replicate('0',2-len(rtrim(convert(char(2),rtrim(wo.PICWeek)))))
	 			+ rtrim(convert(char(2),rtrim(wo.PICWeek))) as varchar(6)) as OriginWeek,
isnull(mo.Observer,'UNKNOWN'),
Account=
'Recycle', DateDiff(day,mo.EventDate, ge.EventDate) as Value
FROM SowMatingEventTemp mo
LEFT JOIN vSowGroupEventTempNext gn on mo.FarmID=gn.FarmID and mo.SowID=gn.SowID and mo.SortCode=gn.SortCode+1
LEFT JOIN SowGroupEventTemp ge on ge.FarmID=mo.FarmID and ge.SowID=mo.SowID and ge.SortCode=gn.NextGroup
LEFT JOIN SowFalloutEventTemp fo on fo.FarmID=mo.FarmID and fo.SowID=mo.SowID and fo.SortCode between gn.SortCode and ge.SortCode
JOIN WeekDefinitionTemp wo on mo.WeekOfDate=wo.WeekOfDate
where fo.FarmID is null and
mo.SowParity=ge.SowParity and DateDiff(day,mo.EventDate, ge.EventDate)<120
and ((mo.MatingNbr=1 and isnull(mo.Observer,'UNKNOWN') not like 'CYCLE%') or (mo.MatingNbr=2 and isnull(mo.Observer,'UNKNOWN') like 'CYCLE%')) 
 and ge.SortCode is not null

--From Source Fail to Farrow
UNION
Select mo.FarmID, rTrim(mo.FarmID) + '_' + rTrim(Mo.SowID) as FarmSow, 'P' + cast(mo.SowParity as varchar(2)), 
cast(right(rtrim(wo.PICYear),2) + 'WK' + 
replicate('0',2-len(rtrim(convert(char(2),rtrim(wo.PICWeek)))))
	 			+ rtrim(convert(char(2),rtrim(wo.PICWeek))) as varchar(6)) as OriginWeek,
isnull(mo.Observer,'UNKNOWN'),
Account=
'FailtoFarrow',1 as Value
FROM SowMatingEventTemp mo
LEFT JOIN vSowGroupEventTempNext gn on mo.FarmID=gn.FarmID and mo.SowID=gn.SowID and mo.SortCode=gn.SortCode+1
LEFT JOIN SowGroupEventTemp ge on ge.FarmID=mo.FarmID and ge.SowID=mo.SowID and ge.SortCode=gn.NextGroup
LEFT JOIN SowFalloutEventTemp fo on fo.FarmID=mo.FarmID and fo.SowID=mo.SowID and fo.SortCode between gn.SortCode and ge.SortCode
JOIN WeekDefinitionTemp wo on mo.WeekOfDate=wo.WeekOfDate
where fo.FarmID is null and
mo.SowParity=ge.SowParity and DateDiff(day,mo.EventDate, ge.EventDate)>=120
and ((mo.MatingNbr=1 and isnull(mo.Observer,'UNKNOWN') not like 'CYCLE%') or (mo.MatingNbr=2 and isnull(mo.Observer,'UNKNOWN') like 'CYCLE%')) 
and ge.SortCode is not null



GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vSowBreedResultByObserver] TO [se\analysts]
    AS [dbo];

