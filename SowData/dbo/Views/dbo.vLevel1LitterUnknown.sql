--*************************************************************
--	Purpose:Retrieve first level of litter data
--  The sow genetics are from a single company
--	Author: Charity Anderson
--	Date: 10/13/2005
--	Usage: SowGenetic Royalties
--	Parms:
--*************************************************************
CREATE VIEW dbo.vLevel1LitterUnknown
AS

Select Sow as Dam_Line, Sire_Line, Count(*) as Qty
from vLevel1Litter 
Group by Sow, Sire_Line, Litter_Line
Having Litter_Line is null and Count(*)>10

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vLevel1LitterUnknown] TO [se\analysts]
    AS [dbo];

