--*************************************************************
--	Purpose:Retrieve third level of litter genetics
--	Author: Charity Anderson
--	Date: 3/15/2005
--	Usage: SowGenetic Royalties
--	Parms:
--*************************************************************
CREATE VIEW dbo.vLevel3Litter
AS
Select  FarmID,  
s.GeneticLine as SowGenetics, s.CpnyID as Sow, da.GeneticAlias as Sire_Line,PICYear,PICWeek,
d.CpnyID as Sire, 
BWeek, BYear, EventDate,
1 as Qty, 
m.Litter
FROM
vLevel3Litter_ALL l
JOIN SowGenetics s on l.Dam_Line=s.GeneticLine
JOIN GeneticAliasDefault da on l.Sire_Line=da.Genetic
JOIN SowGenetics d on da.GeneticAlias=d.GeneticLine
LEFT JOIN MatingPattern m on l.Dam_Line=m.Dam and da.GeneticAlias=m.Sire and GenLevel=2
where isnull(m.Litter,0)<>'999'

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vLevel3Litter] TO [se\analysts]
    AS [dbo];

