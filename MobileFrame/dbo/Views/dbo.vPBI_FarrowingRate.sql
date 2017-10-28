


CREATE VIEW [dbo].[vPBI_FarrowingRate]
AS

select
wd.GROUPNAME as [EventWeek]
,AT.TAGNBR as [SowID]
,mf.NAME as [MatingFarm]
,ME.PARITYNBR
,g.NAME as [Genetics]
,1 as [MatingCnt]
,ME.EVENTDATE [MatingDate]
,b.NAME as [Breeder]
,ME.PARITYSERVICENBR
,ME.ANIMALSTATUS
,ME.PREVSTATUS
,s.NAME as [PrevStatusName]
,case when aef.ID is null then 0
	else 1 end as [FarrowCnt]
,aef.EVENTDATE as [FarrowDate]
,aef.BORNALIVE
,aef.MUMMY
,aef.STILLBORN
,aef.GESTATIONLENGTH
,ff.NAME [FarrowFarm]
,fl.ROOM,fl.CRATE
from  dbo.CFT_ANIMALEVENTS ME
inner Join dbo.CFT_EVENTTYPE as ET on ME.EVENTTYPEID = ET.ID AND ET.EVENTNAME = 'MATING' and ET.DELETED_BY = -1
left join dbo.CFT_FARMANIMAL fa on fa.ANIMALID=ME.ANIMALID and fa.DELETED_BY=-1
left join dbo.CFT_FARM mf on mf.ID=fa.FARMID and mf.DELETED_BY=-1
left join dbo.CFT_ANIMALTAG as at on AT.ANIMALID=ME.ANIMALID and AT.PRIMARYTAG=1 and AT.DELETED_BY = -1
left join dbo.CFT_ANIMAL as a on a.ID=ME.ANIMALID and a.DELETED_BY=-1
left join dbo.CFT_GENETICS as g on g.ID=a.GENETICSID
left join dbo.CFT_WEEKDEFINITION as wd on ME.EVENTDATE between wd.WEEKOFDATE-119 and wd.WEEKENDDATE-119  and wd.DELETED_BY=-1
left join dbo.CFT_BREEDER as b on b.ID = ME.BREEDERID and b.DELETED_BY=-1
left join dbo.CFT_STATUS as s on s.STATUSID=ME.PREVSTATUS and s.DELETED_BY=-1
left join (select aef.* from dbo.CFT_ANIMALEVENTS aef 
	inner join dbo.CFT_EVENTTYPE etf on etf.ID=aef.EVENTTYPEID and etf.DELETED_BY=-1 and etf.EVENTTYPE='Farrowing'
	where aef.DELETED_BY=-1) as aef
	on aef.ANIMALID=ME.ANIMALID and aef.PARITYNBR=ME.PARITYNBR+1 and DATEDIFF(d,ME.EVENTDATE,aef.EVENTDATE) between 109 and 125
left join dbo.CFT_LOCATION as fl on fl.ID = aef.LOCATIONID and fl.DELETED_BY=-1
left join dbo.CFT_FARM as ff on ff.ID=fl.FARMID and ff.DELETED_BY=-1
where ME.DELETED_BY=-1 and ME.MATINGNBR=1




GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vPBI_FarrowingRate';

