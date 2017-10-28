--*************************************************************
--	Purpose:Retrieve second level of litter genetics
--	Author: Charity Anderson
--	Date: 10/13/2005
--	Usage: SowGenetic Royalties
--	Parms:
--*************************************************************
CREATE VIEW dbo.vLevel2LitterUnknown
AS
Select Dam_Line, Sire_Line, Count(*) as Qty
FROM vLevel2Litter
Group by Dam_Line, Sire_Line, Litter_Line
Having Litter_Line is null and Count(*)>10

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vLevel2LitterUnknown] TO [se\analysts]
    AS [dbo];

