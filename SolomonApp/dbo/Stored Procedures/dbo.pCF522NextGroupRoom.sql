/****** Object:  Stored Procedure dbo.pCF522NextGroupRoom    Script Date: 5/24/2005 9:45:18 AM ******/

CREATE     Procedure pCF522NextGroupRoom @parm1 varchar (6), @parm2 varchar(6), @parm3 varchar(10), @parm4 varchar(10)
AS 
--Select pg.*
--from cftPigGroup pg
--JOIN cftPigGroupRoom rm ON pg.PigGroupID=rm.PigGroupID
--JOIN cftPigGroup pg2 ON pg.SiteContactID=pg2.SiteContactID 
--AND pg.BarnNbr=pg2.BarnNbr AND pg.PigGroupID<>pg2.PigGroupID
--JOIN cftPigGroupRoom rm2 ON pg2.PigGroupID=rm2.PigGroupID
--Where pg2.PigGroupID=@parm1 AND pg2.BarnNbr=@parm2 AND pg.PGStatusID=@parm3 AND rm2.RoomNbr=@parm4 
Select pg.*
from cftPigGroup pg
JOIN cftPigGroupRoom rm ON pg.PigGroupID=rm.PigGroupID
Where pg.SiteContactID=@parm1 AND pg.BarnNbr=@parm2 AND pg.CF03<>@parm3 AND rm.RoomNbr=@parm4 
AND pg.CF03=(Select Min(pg.CF03) 
		from cftPigGroup pg
		JOIN cftPigGroupRoom rm ON pg.PigGroupID=rm.PigGroupID AND rm.RoomNbr=@parm4
		Where SiteContactID=@parm1 AND BarnNbr=@parm2 
		AND CostFlag<>2 AND pg.CF03<>@parm3 AND PGStatusID<>'X' AND ISNULL(pg.CF03,'')<>'')

--JOIN cftPigGroup pg2 ON pg.SiteContactID=pg2.SiteContactID 
--AND pg.BarnNbr=pg2.BarnNbr AND pg.PigGroupID<>pg2.PigGroupID
--JOIN cftPigGroupRoom rm2 ON pg2.PigGroupID=rm2.PigGroupID
--Where pg2.PigGroupID=@parm1 AND pg2.BarnNbr=@parm2 AND pg.PGStatusID=@parm3 AND rm2.RoomNbr=@parm4 





 