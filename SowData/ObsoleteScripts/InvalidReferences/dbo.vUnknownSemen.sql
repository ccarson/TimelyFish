
--*************************************************************
--	Purpose:Retrieve third level of litter genetics ALL
--	including records that are still unknown
--	Author: Charity Anderson
--	Date: 3/15/2005
--	Usage: SowGenetic Royalties
--	Parms:
--*************************************************************
CREATE VIEW [dbo].[vUnknownSemen]
AS
Select  
Sire_Line, Count(*) as Qty from
(Select FarmID, EventDate,
--need to figure out Semen based on rules
Case 
when EventDate between '1/19/04' and '4/19/04' then '740'
when SemenID like '19%' then '19'
when SemenID like '3%' and (len(rtrim(SemenID)) in (5,6,7)) then '3'
when SemenID like '2%' and (len(rtrim(SemenID)) in (5,6,7)) then '2'
when SemenID like 'V22%' then '722'
when SemenID like 'V40%' then '740'
when SemenID like 'V10%' then '710'
when right(rtrim(SemenID),3)='019' then '19'
when right(rtrim(SemenID),3)='002' then '2'
when left(SemenID,2) in ('03','04','05') then 'PIC'
when SemenID='02' then '2'
when (EventDate<'1/19/04' or EventDate>'4/19/04') and GeneticAlias='7120' then '19'
when (EventDate<'1/19/04' or EventDate>'4/19/04') and GeneticAlias='7700' then '2'
when left(semenid,2) = '07' then '7'
when left(semenid,2) = '02' then '2'
else SemenID end as Sire_Line

from SowMatingEvent m 
Left JOIN GeneticAliasDefault a on m.SowGenetics=a.Genetic
JOIN SowMultiplierFarm mf on m.FarmID=mf.Multiplier
 where m.MatingNbr=1 and EventDate>'8/3/2003') 
as temp
Left JOIN GeneticAliasDefault a on temp.Sire_Line=a.Genetic
Group by Sire_Line, a.Genetic
having a.Genetic is null and temp.Sire_Line is not null and count(*) >10

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vUnknownSemen] TO [se\analysts]
    AS [dbo];

