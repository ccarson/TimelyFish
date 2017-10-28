--*************************************************************
--	Purpose:Commercial Farm mating code for farrow events
--   where sows were mated at an Origin farm
--	Author: Charity Anderson
--	Date: 3/22/2006
--	Usage: SowGenetic Royalties
--	Parms:
--*************************************************************
CREATE VIEW dbo.vSowMatingCodeFromOrigin
AS
Select mc.FarmID, mc.SowID, max(m.SortCode) as MatingSortCode, mc.Source
FROM SowMatingEvent m
JOIN vSowMatingCode mc on m.SowID=mc.SowID and m.FarmID=mc.Source and mc.MatingSortCode=0
GROUP BY mc.FarmID, mc.SowID, mc.Source

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vSowMatingCodeFromOrigin] TO [se\analysts]
    AS [dbo];

