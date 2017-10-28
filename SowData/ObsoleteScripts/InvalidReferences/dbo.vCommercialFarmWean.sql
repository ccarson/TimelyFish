--*************************************************************
--	Purpose:Commercial Farm Weans
--	Author: Charity Anderson
--	Date: 3/22/2006
--	Usage: SowGenetic Royalties
--	Parms:
--*************************************************************
CREATE VIEW dbo.vCommercialFarmWean
AS
Select 
s.FarmID, rTrim(s.FarmID) + '_' + rTrim(s.SowID) as FarmSow, 'WeanQty' as EventType,
cast(right(rtrim(w.PICYear),2) + 'WK' + 
replicate('0',2-len(rtrim(convert(char(2),rtrim(w.PICWeek)))))
	 			+ rtrim(convert(char(2),rtrim(w.PICWeek))) as varchar(6)) as Week,
s.Genetics as SowGenetics, ga.GeneticAlias as Genetics,
sum(we.Qty) as Qty
from Sow s
JOIN SowWeanEvent we on s.FarmID=we.FarmID and s.SowID=we.SowID
LEFT JOIN WeekDefinition w on we.WeekOfDate=w.WeekOfDate
LEFT JOIN GeneticAliasDefault ga on s.Genetics=ga.Genetic 
JOIN FarmSetup fs on s.FarmID=fs.FarmID --and fs.Status='A' 
and LEFT(fs.FarmID,1)<>'B'--and LEFT(fs.FarmID,1)='C'
--LEFT JOIN SowMultiplierFarm mf on s.FarmID=mf.Multiplier
WHERE 
  we.EventDate>'8/3/2003' 
  --and mf.Multiplier is null
  and we.Qty >0

Group by s.FarmID, s.SowID, w.PICYear, w.PICWeek,ga.GeneticAlias, s.Genetics


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vCommercialFarmWean] TO [se\analysts]
    AS [dbo];

