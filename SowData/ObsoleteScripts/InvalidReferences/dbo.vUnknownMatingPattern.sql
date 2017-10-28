--*************************************************************
--	Purpose:Queries unknown Mating Patterns from all levels
--	
--	Author: Charity Anderson
--	Date: 3/21/2005
--	Usage: SowGenetic Royalties
--	Parms:
--*************************************************************
CREATE VIEW dbo.vUnknownMatingPattern
AS
Select '1' as GenLevel, *
from vLevel1LitterUnknown
UNION 
Select '2' as GenLevel, *
FROM vLevel2LitterUnknown
UNION 
Select '2' as GenLevel, *
FROM vLevel3LitterUnknown

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vUnknownMatingPattern] TO [se\analysts]
    AS [dbo];

