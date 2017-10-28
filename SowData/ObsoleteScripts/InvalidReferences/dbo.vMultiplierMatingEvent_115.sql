--*************************************************************
--	Purpose:Retrieve mating events at Multipliers with the FarrowDate
--	including records that are still unknown
--	Author: Charity Anderson
--	Date: 3/15/2005
--	Usage: SowGenetic Royalties
--	Parms:
--*************************************************************
CREATE VIEW dbo.[vMultiplierMatingEvent_115]
AS
Select me.*, EventDate+115 as FarrowDate
from SowMatingEvent me
JOIN SowMultiplierFarm m on me.FarmID=m.Multiplier
where me.MatingNbr=1

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vMultiplierMatingEvent_115] TO [se\analysts]
    AS [dbo];

