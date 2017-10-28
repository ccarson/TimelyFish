/****** Object:  Stored Procedure dbo.pCF511NextStart    Script Date: 12/8/2004 7:29:02 PM ******/

CREATE    PROCEDURE pCF511NextStart
		@parm1 varchar (6),
		@parm2 varchar(6),
		@parm3 varchar(10),
		@parm4 varchar(6)
AS

Select pg.PigGroupID, Min(ActStartDate) As PGClose
FROM cftPigGroup pg
LEFT JOIN cftPigGroupRoom rm ON pg.PigGroupID=rm.PigGroupID
Where pg.SiteContactID=@parm1
AND pg.BarnNbr=@parm2
AND rm.RoomNbr Like @parm3
AND pg.PigGroupID <> @parm4
AND (pg.PGStatusID='P' or pg.PGStatusID='F' or pg.PGStatusID='A')
Group by pg.PigGroupID




 