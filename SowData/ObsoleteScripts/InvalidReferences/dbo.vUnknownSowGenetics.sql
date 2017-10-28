--*************************************************************
--	Purpose:Calculate Sow Birthdate based on the first mating
--	
--	Author: Charity Anderson
--	Date: 3/21/2005
--	Usage: SowGenetic Royalties
--	Parms:
--*************************************************************
CREATE VIEW dbo.vUnknownSowGenetics
AS

Select Dam_Line, count(*) as Qty
FROM
(Select l.Dam_Line, l.LineNbr from
LitterData l 
LEFT JOIN GeneticAliasDefault sa on l.Dam_Line=sa.Genetic
where sa.Genetic is null and l.Dam_Line<>'999'

UNION
Select  s.SowGenetics,EventID  from
SowMatingEvent s
LEFT JOIN GeneticAliasDefault sa on s.SowGenetics=sa.Genetic
--JOIN SowMultiplierFarm mf on s.FarmID=mf.Multiplier
where sa.Genetic is null and s.SowGenetics<>'999' and isnull(sa.OverRide,0)=0
and s.EventDate>'8/1/2003')
as temp
Group by Dam_Line


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vUnknownSowGenetics] TO [se\analysts]
    AS [dbo];

