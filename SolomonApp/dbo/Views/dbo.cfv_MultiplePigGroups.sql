/****** Sue Matter:  Used on Feed Exception Report    Script Date: 11/30/2004 ******/
CREATE VIEW cfv_MultiplePigGroups
AS
select pg1.SiteID As Site, pg1.BarnNbr As Barn, pg1.RoomNbr As Room, pg1.PigGroupID As Group1, CONVERT(CHAR(10),pg1.LastOrder,101) As Group1_LastFeed, pg2.PigGroupID As Group2, CONVERT(CHAR(10),pg2.EstStartDate,101) As Group2_EstStart
from cfv_PigGroup1 pg1
LEFT JOIN cfv_PigGroup2 pg2 ON pg1.SiteID=pg2.SiteID AND pg1.BarnNbr=pg2.BarnNbr AND pg1.RoomNbr=pg2.RoomNbr AND pg1.PigGroupID<>pg2.PigGroupID
Where pg1.LastOrder > pg2.EstStartDate

