
--*************************************************************
--	Purpose:Retrieve mating events at Multipliers with the FarrowDate
--	including records that are still unknown
--	Author: Charity Anderson
--	Date: 3/15/2005
--	Usage: SowGenetic Royalties
--	Parms:
--  20130624 smr changed 115 to 119
--*************************************************************
CREATE VIEW [dbo].[vMultiplierMatingEvent]
AS
Select me.*, EventDate+119 as FarrowDate
from SowMatingEvent me
JOIN SowMultiplierFarm m on me.FarmID=m.Multiplier
where me.MatingNbr=1

