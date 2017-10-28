--*************************************************************
--	Purpose:Returns the next Schedule Status for the specified ID
--	Author: Charity Anderson
--	Date: 3/8/2005
--	Usage: Internal Transportation
--	Parms: PMTypeID,PMStatusID
--	      
--*************************************************************

CREATE PROC dbo.pXT200NextStatusName
	(@parm2 as varchar(2),@parm3 as varchar(2))
	
AS
Select * from cftPMStatus WITH (NOLOCK) where 
PMTypeID=@parm2
and PMStatusID =(Select min(PMStatusID) from cftPMStatus where PMTypeID=@parm2
		 and PMStatusID>@parm3)

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pXT200NextStatusName] TO [SOLOMON]
    AS [dbo];

