--------------------------------------------------------------------------------------------------------------------
/*to determine the correct replacement rates on our new start up farms. In an effort to do this we need to understand 
a few things about the current culling practices. We would like to develop a new cube looking specifically at the following pieces of information:
Farm Name (the farm the animal was on when removed) (animals transferred from one sow farm to another should not be included) 
Sow ID 
First service date 
Last service date 
Last wean date 
Parity at removal 
Removal Type(Death, Destroyed, Culled) 
Reason for removal (There will be a lot of these) 
Date of removal 
Lifetime total born 
Lifetime born alive 
Lifetime pigs weaned 
Genetics 
-- CREATED BY: CANDERSON
-- CREATED ON: 2/21/2006 */
--------------------------------------------------------------------------------------------------------------------
CREATE VIEW vRemovalCube_Removals (PICWeek, SowFarm, FarmSow, SowParity, RemovalType,RemovalReason,GeneticLine,FirstService,
									LastService,RemovalDate,LastWeanDate, InitialAge, SowAge, HeadCount,BornAliveQty, MummyQty, 
									StillbornQty,NaturalWeanQty,WeanQty, EntryDate,NbrLastParityServices)
	AS

Select
right(d.PICYear,2)+'WK'
+replicate('0',2-len(rtrim(convert(char(2),d.PICWeek)))) + rtrim(convert(char(2),d.PICWeek)) as PICWeek,
r.FarmID as SowFarm,
r.FarmID + '_' + r.SowID as Farm_Sow,
'P'+convert(char(2),r.SowParity) as Parity,
r.RemovalType,
r.PrimaryReason,
convert(char,s.Genetics) as GeneticLine,
FirstService=cast((Select min(EventDate)
	from SowMatingEventTemp
	where SowID=r.SowID and FarmID=r.FarmID) as Int),

LastService=cast((Select max(EventDate)
	from SowMatingEventTemp
	where SowID=r.SowID and FarmID=r.FarmID) as Int),
cast(r.EventDate as Int) as RemovalDate,
LastWeanDate =
	Case when (Select Max(EventDate)
		from SowNurseEventTemp
		where SowID=r.SowID and FarmID=r.FarmID
		and EventType='NURSE OFF')
		>(Select max(EventDate)
		from SowWeanEventTemp
		where SowID=r.SowID and FarmID=r.FarmID)
	THEN
		cast((Select Max(EventDate)
		from SowNurseEventTemp
		where SowID=r.SowID and FarmID=r.FarmID
		and EventType='NURSE OFF') as Int)
	ELSE
		cast((Select max(EventDate)
		from SowWeanEventTemp
		where SowID=r.SowID and FarmID=r.FarmID) as Int)
		END,
s.InitialParity as InitialAge,
r.SowParity as SowAge,
1 as Headcount,
BornAlive=cast((Select sum(QtyBornAlive)
		from SowFarrowEventTemp
		where SowID=r.SowID and FarmID=r.FarmID) as Int),
PigsMummified=cast((Select sum(qtyMummy)
	from SowFarrowEventTemp
	where SowID=r.SowID and FarmID=r.FarmID) as Int),
PigsStillborn=cast((Select sum(QtyStillBorn)
	from SowFarrowEventTemp
	where SowID=r.SowID and FarmID=r.FarmID) as Int),
NaturalWeaned=cast((Select sum(t.Qty)
	from SowWeanEventTemp t
	LEFT JOIN SowNurseEventTemp n
	on t.SowID=n.SowID and t.FarmID=n.FarmID and t.SowParity=n.SowParity and n.EventType='NURSE ON'
	where t.SowID=r.SowID and t.FarmID=r.FarmID
	and (t.SortCode<n.SortCode or n.SortCode is null)) as Int),
Weaned=cast((select sum(Qty)
	from SowWeanEventTemp
	where SowID=r.SowID and FarmID=r.FarmID) as Int),
cast(s.EntryDate as Int) as EntryDate,
NbrLastParityServices=
	(select count(m.MatingNbr)
	from SowMatingEventTemp m
	where r.SowID=m.SowID and r.FarmID=m.FarmID and r.SowParity=m.SowParity and m.MatingNbr = '1')

from SowRemoveEventTemp r
LEFT JOIN SowTemp s on r.SowID=s.SowID and r.FarmID=s.FarmID
--SJM 7/25/2006 Only pull data for the week selected by the user
--LEFT Join WeekDefinition d on r.EventDate>=d.WeekOfDate and r.EventDate<=d.WeekEndDate
Join WeekDefinition d on r.EventDate>=d.WeekOfDate and r.EventDate<=d.WeekEndDate
where r.RemovalType<>'TRANSFER' and r.EventDate between '1/1/2003' and getDate()


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vRemovalCube_Removals] TO [se\analysts]
    AS [dbo];

