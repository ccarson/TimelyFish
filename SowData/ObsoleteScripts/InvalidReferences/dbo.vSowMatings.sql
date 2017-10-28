--*************************************************************
--	Purpose:Commercial Farm mating code for farrow events
--   where sows were mated at an Origin farm
--	Author: Charity Anderson
--	Date: 3/22/2006
--	Usage: SowGenetic Royalties
--	Parms:
--*************************************************************
CREATE VIEW dbo.vSowMatings
AS
Select m.FarmID, m.SowID, m.WeekOfDate, m.SemenID 
FROM SowMatingEvent m
JOIN vSowMatingCode mc on m.SowID=mc.SowID and mc.MatingSortCode=m.SortCode and m.FarmID=mc.FarmID
	and mc.MatingSortCode<>0
UNION
Select mc.FarmID, mc.SowID, m.WeekOfDate, m.SemenID
FROM SowMatingEvent m
JOIN vSowMatingCodeFromOrigin mc on m.SowID=mc.SowID 
and mc.MatingSortCode=m.SortCode and m.FarmID=mc.Source

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vSowMatings] TO [se\analysts]
    AS [dbo];

