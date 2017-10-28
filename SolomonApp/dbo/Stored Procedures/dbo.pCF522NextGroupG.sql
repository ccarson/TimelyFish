/****** Object:  Stored Procedure dbo.pCF522NextGroupG    Script Date: 6/23/2005 4:16:00 PM ******/

/****** Object:  Stored Procedure dbo.pCF522NextGroupG    Script Date: 6/23/2005 11:47:42 AM ******/

/****** Object:  Stored Procedure dbo.pCF522NextGroupG    Script Date: 6/3/2005 8:50:32 AM ******/

/****** Object:  Stored Procedure dbo.pCF522NextGroupG    Script Date: 5/23/2005 2:25:31 PM ******/



/****** Temporary procedure to allow selection of next group ******/


CREATE                  Procedure pCF522NextGroupG 
	    @parm1 varchar (16), 
	    @parm2 varchar(6),
	    @parm3 varchar (10),
	    @parm4 smalldatetime


AS 
/* Original
Select pg.*, rm.*
from cftPigGroup pg
JOIN cftPigGroup pg2 ON pg.SiteContactID=pg2.SiteContactID AND pg.BarnNbr=pg2.BarnNbr AND pg.PigGroupID<>pg2.PigGroupID
LEFT JOIN cftPigGroupRoom rm2 ON pg2.PigGroupID=rm2.PigGroupID
LEFT JOIN cftPigGroupRoom rm ON pg.PigGroupID=rm.PigGroupID AND rm.RoomNbr=rm2.RoomNbr
Where pg2.PigGroupID=@parm1 AND pg2.BarnNbr=@parm2 AND DateAdd(day, 5, pg.EstCloseDate) > @parm3 
AND pg2.PGStatusID<>'X' AND pg.CostFlag='0' */
Select *
	from cftPigGroup pg
	LEFT JOIN cftPigGroupRoom rm ON pg.PigGroupID=rm.PigGroupID 
	Where pg.SiteContactID=@parm1 
	AND pg.BarnNbr=@parm2 
	AND pg.CF03<>@parm3
--	AND DateAdd(day, 5, pg.EstStartDate) > @parm4 	
	AND pg.PGStatusID<>'X' AND pg.CostFlag<>'2'
       -- AND rm.RoomNbr=@parm4







 