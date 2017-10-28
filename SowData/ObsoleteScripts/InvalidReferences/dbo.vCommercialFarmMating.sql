--*************************************************************
--	Purpose:Commercial Farm Matings
--	Author: Charity Anderson
--	Date: 3/22/2006
--	Usage: SowGenetic Royalties
--	Parms:
--*************************************************************
CREATE VIEW dbo.vCommercialFarmMating
AS

Select 
me.FarmID, rTrim(me.FarmID) + '_' + rTrim(me.SowID) as FarmSow, 
Case 
when SemenID like '19%' then '19'
when SemenID like '3%' and (len(rtrim(SemenID)) in (5,6,7)) then '3'
when SemenID like '2%' and (len(rtrim(SemenID)) in (5,6,7)) then '2'
--when SemenID like 'V22%' then '722'
--when SemenID like 'V40%' then '740'
when right(rtrim(SemenID),3)='019' then '19'
when right(rtrim(SemenID),3)='002' then '2'
when left(SemenID,2) in ('03','04','05') then 'TR4'
else SemenID end as Account,
--SemenID as Account, 
cast(right(rtrim(w.PICYear),2) + 'WK' + 
replicate('0',2-len(rtrim(convert(char(2),rtrim(w.PICWeek)))))
	 			+ rtrim(convert(char(2),rtrim(w.PICWeek))) as varchar(6)) as Week,
s.Genetics as SowGenetics, ga.GeneticAlias as Genetics, 1 as Value
FROM vSowMatings me
JOIN Sow s on s.FarmID=me.FarmID and s.SowID=me.SowID
JOIN WeekDefinitionTemp w on me.WeekOfDate=w.WeekOfDate
JOIN GeneticAliasDefault ga on s.Genetics=ga.Genetic 
JOIN FarmSetup fs on s.FarmID=fs.FarmID --and fs.Status='A' 
and LEFT(fs.FarmID,1)<>'B'--and LEFT(fs.FarmID,1)='C'
--LEFT JOIN SowMultiplierFarm mf on me.FarmID=mf.Multiplier
WHERE 
  me.WeekOfDate>'8/3/2003' 
  --and mf.Multiplier is null 
  and me.SemenID is not null

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vCommercialFarmMating] TO [se\analysts]
    AS [dbo];

