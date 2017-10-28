--*************************************************************
--	Purpose:Sow entries for non-multiplier farms
--	Author: Charity Anderson
--	Date: 3/22/2006
--	Usage: SowGenetic Royalties
--	Parms:
--*************************************************************
CREATE VIEW dbo.vCommercialFarmEntry
AS
Select 
s.FarmID, rTrim(s.FarmID) + '_' + rTrim(s.SowID) as FarmSow, 'Entry' as EventType,
cast(right(rtrim(w.PICYear),2) + 'WK' + 
replicate('0',2-len(rtrim(convert(char(2),rtrim(w.PICWeek)))))
	 			+ rtrim(convert(char(2),rtrim(w.PICWeek))) as varchar(6)) as Week,
isnull(ga.GeneticAlias,'NOT LISTED') as Genetics,
bw.PICYear, bw.PICWeek, g.CpnyID as SowCpny,isnull(d.DefaultGP,0) as GP,isnull(d.DefaultPIC,0) as PIC,
isnull(d.DefaultNL,0) as NL,
isnull(d.DefaultOther,0) as Other, d.OtherCompany, isnull(d.OverRide,0) as OverRide
from Sow s
LEFT JOIN vSowBirthDateCalcTemp sb on s.FarmID=sb.FarmID and s.SowID=sb.SowID
LEFT JOIN WeekDefinition bw on (sb.EntryDate-sb.Days) between bw.WeekOfDate and bw.WeekEndDate
LEFT JOIN WeekDefinition w on sb.EntryDate=w.WeekOfDate
LEFT JOIN SowGenetics g on s.Genetics=g.GeneticLine and PureSource=-1
LEFT JOIN GeneticAliasDefault d on s.Genetics=d.Genetic and d.OverRide=-1
LEFT JOIN GeneticAliasDefault ga on s.Genetics=ga.Genetic 
LEFT JOIN SowMultiplierFarm mf on s.FarmID=mf.Multiplier
JOIN FarmSetup fs on s.FarmID=fs.FarmID --and fs.Status='A' 
and LEFT(fs.FarmID,1)<>'B'--and LEFT(fs.FarmID,1)='C'
WHERE 
  sb.EntryDate-sb.Days>'8/2/2003' 
  --and mf.Multiplier is null

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vCommercialFarmEntry] TO [se\analysts]
    AS [dbo];

