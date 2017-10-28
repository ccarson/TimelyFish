--*************************************************************
--	Purpose:Determines access rights for a user
--		
--	Author: Charity Anderson
--	Date: 3/24/2005
--	Usage: Transportation Module	 
--	Parms: UserID,ScreenNbr
--*************************************************************

CREATE PROC [dbo].[pXT100AccessRights]
	(@parm1 as varchar(47),@parm2 as varchar(8))
AS

IF @parm1='SYSADMIN' 
BEGIN Select 1 as DeleteRights
END
else
BEGIN
Select * from vs_AccessDetRights WITH (NOLOCK) 
	WHERE ScreenNumber = @parm2
	and (userid=@parm1 or userid in
			(Select Distinct GroupID from vs_UserGrp where UserID=@parm1))
	order by DeleteRights DESC
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pXT100AccessRights] TO [SOLOMON]
    AS [dbo];

