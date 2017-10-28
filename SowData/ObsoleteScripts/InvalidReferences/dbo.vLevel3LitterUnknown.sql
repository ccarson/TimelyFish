--*************************************************************
--	Purpose:Unknown Matings from M3, M4, M5, M6
--	Author: Charity Anderson
--	Date: 3/22/2006
--	Usage: SowGenetic Royalties
--	Parms:
--*************************************************************
CREATE VIEW dbo.vLevel3LitterUnknown
AS
Select  Dam_Line, Sire_Line, Count(*) as Qty
from vLevel3LitterUnknown_All l
JOIN GeneticAliasDefault sa on l.Dam_Line=sa.Genetic
JOIN SowGenetics s on sa.GeneticAlias=s.GeneticLine
JOIN GeneticAliasDefault da on l.Sire_Line=da.Genetic
JOIN SowGenetics d on da.GeneticAlias=d.GeneticLine
LEFT JOIN MatingPattern m on sa.GeneticAlias=m.Dam and da.GeneticAlias=m.Sire and GenLevel=2
group by Dam_Line, Sire_Line, Litter
having Litter is null and Count(*)>10

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vLevel3LitterUnknown] TO [se\analysts]
    AS [dbo];

