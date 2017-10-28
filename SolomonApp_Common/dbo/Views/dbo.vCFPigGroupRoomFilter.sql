--*************************************************************
--	Purpose:view for filtering true pig groups configured as rooms
--		
--	Author: Charity Anderson
--	Date: 7/12/2005
--	Usage: Pig Group Room views
--	Parms: None
--*************************************************************

CREATE VIEW dbo.vCFPigGroupRoomFilter
as
Select PigGroupID, count(*) as GroupCount from cftPigGroupRoom group by PigGroupID



 