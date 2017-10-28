
--*************************************************************
--	Purpose:Retrieve second level of litter genetics
--	Author: Charity Anderson
--	Date: 10/13/2005
--	Usage: SowGenetic Royalties
--	Parms:
--*************************************************************
CREATE VIEW [dbo].[vLevel2Litter]
AS
Select l.LineNbr,l.SowID, l.Litter_Line as Litter_Line, s.CpnyID as Dam,d.CpnyID as Sire,
sa.GeneticAlias as Dam_Line, da.GeneticAlias as Sire_Line,
	Farrow=Case when l.XLS_Farrow_Day is null then 
		cast(l.XLS_Final_Service_Day+119 as smalldatetime)  -- 20130626 changed 115 to 119 for pigchamp impl.
	else cast(XLS_Farrow_Day as smalldatetime) end,
	l.Sow_BirthDate,
	BirthDate=case when l.Farm='482' then
		(Select EntryDate - Days from vSowBirthDateCalcTemp where SowID=l.SowID and FarmID='M01')
	else	
		(Select EntryDate - Days from vSowBirthDateCalcTemp where SowID=l.SowID and FarmID='M04')
	END
from
LitterData l 
JOIN GeneticAliasDefault sa on l.Dam_Line=sa.Genetic
JOIN SowGenetics s on sa.GeneticAlias=s.GeneticLine
JOIN GeneticAliasDefault da on l.Sire_Line=da.Genetic
JOIN SowGenetics d on da.GeneticAlias=d.GeneticLine
--JOIN GeneticAliasDefault la on l.Litter_Line=la.Genetic
--LEFT JOIN SowGenetics lit on la.GeneticAlias=lit.GeneticLine
LEFT JOIN MatingPattern m on sa.GeneticAlias=m.Dam and da.GeneticAlias=m.Sire and GenLevel=2
where isnull(s.PureSource,0)=0 and isnull(m.Litter,0) <> 999 

