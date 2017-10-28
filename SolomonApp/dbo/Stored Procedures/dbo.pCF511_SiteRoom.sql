
CREATE   PROCEDURE pCF511_SiteRoom
		@parm1 varchar (6),
		@parm2 varchar(10),
		@parm3 varchar(10)
AS

Select cftRoom.*
FROM cftRoom
Where cftRoom.ContactID=@parm1
AND cftRoom.BarnNbr=@parm2
And cftRoom.RoomNbr Like @parm3
Order by cftRoom.RoomNbr




GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF511_SiteRoom] TO [MSDSL]
    AS [dbo];

