--*************************************************************
--	Purpose:Retrieve first level of litter data
--  The sow genetics are from a single company
--	Author: Charity Anderson
--	Date: 10/13/2005
--	Usage: SowGenetic Royalties
--	Parms:
--*************************************************************
CREATE VIEW dbo.vLevel1Litter
AS
Select l.LineNbr,m.Litter as Litter_Line, s.CpnyID as Dam,d.CpnyID as Sire,
	Farrow=Case when l.XLS_Farrow_Day is null then 
		cast(l.XLS_Final_Service_Day+115 as smalldatetime)
	else cast(XLS_Farrow_Day as smalldatetime) end, 
	s.GeneticLine as Sow, d.GeneticLine as Sire_Line

from
LitterData l 
JOIN GeneticAliasDefault sa on l.Dam_Line=sa.Genetic
JOIN SowGenetics s on sa.GeneticAlias=s.GeneticLine
JOIN GeneticAliasDefault da on l.Sire_Line=da.Genetic
LEFT JOIN SowGenetics d on da.GeneticAlias=d.GeneticLine
--JOIN GeneticAliasDefault la on l.Litter_Line=la.Genetic
LEFT JOIN MatingPattern m on sa.GeneticAlias=m.Dam and da.GeneticAlias=m.Sire and GenLevel=1

--LEFT JOIN SowGenetics lit on la.GeneticAlias=lit.GeneticLine 
where s.PureSource=-1 and isnull(m.Litter,0) <> 999
