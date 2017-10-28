/****** Object:  Stored Procedure dbo.testpCF511OtherGroups    Script Date: 12/14/2004 1:49:29 PM ******/

/****** Object:  Stored Procedure dbo.testpCF511OtherGroups    Script Date: 12/14/2004 1:44:42 PM ******/
CREATE   PROCEDURE testpCF511OtherGroups
		@parm1 varchar (6),
		@parm2 varchar(6),
		@parm3 varchar(10),
		@parm4 varchar(6)
AS

Select pg.*
FROM cftPigGroup pg
LEFT JOIN cftPigGroupRoom rm ON pg.PigGroupID=rm.PigGroupID
Where pg.SiteContactID=@parm1
AND pg.BarnNbr=@parm2
AND (pg.PGStatusID='A' or pg.PGStatusID='F')
AND pg.PigGroupID <> @parm4
AND rm.RoomNbr=RTrim(@parm3)



 
GO
GRANT CONTROL
    ON OBJECT::[dbo].[testpCF511OtherGroups] TO [MSDSL]
    AS [dbo];

