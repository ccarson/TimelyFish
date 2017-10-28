--*************************************************************
--	Purpose:Retrieve third level of litter genetics ALL
--	including records that are still unknown
--	Author: Charity Anderson
--	Date: 3/15/2005
--	Usage: SowGenetic Royalties
--	Parms:
--*************************************************************
CREATE VIEW dbo.vLevel3Litter_ALL
AS
Select  m.FarmID, m.SowID, m.EventDate,
GeneticAlias as Dam_Line, w.PICYear,w.PICWeek,b.PICYear as BYear, b.PICWeek as BWeek,
sb.BDate as BirthDate,s.EntryDate,
--need to figure out Semen based on rules
Case 
when EventDate between '1/19/04' and '4/19/04' then '740'
when SemenID like '19%' then '19'
when SemenID like '3%' and (len(rtrim(SemenID)) in (5,6,7)) then '3'
when SemenID like '2%' and (len(rtrim(SemenID)) in (5,6,7)) then '2'
when SemenID like 'V22%' then '722'
when SemenID like 'V40%' then '740'
when right(rtrim(SemenID),3)='019' then '19'
when right(rtrim(SemenID),3)='002' then '2'
when left(SemenID,2) in ('03','04','05') then 'PIC'
when (EventDate not between '1/19/04' and '4/19/04') and GeneticAlias='7120' then '19'
when (EventDate not between '1/19/04' and '4/19/04') and GeneticAlias='7700' then '2'
else SemenID end as Sire_Line

from vMultiplierMatingEvent m 
JOIN WeekDefinition w on m.FarrowDate between w.WeekOfDate and w.WeekEndDate  --left
JOIN Sow s on m.SowID=s.SowID and m.FarmID=s.FarmID			--left
JOIN vSowBirthDateCalc2 sb on s.FarmID=sb.FarmID and s.SowID=sb.SowID  --made left
Left JOIN GeneticAliasDefault a on s.Genetics=a.Genetic
JOIN WeekDefinition b on sb.BDate between b.WeekOfDate and b.WeekEndDate --made left

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vLevel3Litter_ALL] TO [se\analysts]
    AS [dbo];

