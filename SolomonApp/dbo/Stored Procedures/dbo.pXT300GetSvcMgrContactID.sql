


--****************************************************************************************************************************************
--	Purpose:Return contact ID for provided name
--		
--	Author: Nick Honetschlager
--	Date: 10/7/2015
--	Usage: Transportation Module	 
--	Parms: SvcManagerName
--	-- 
--  Update
--  Author:	Nick Honetschlager
--	Date:	08/01/2017
--	Notes:	Was accidentally selecting more than one contact with the same username, but one was inactive. Added check for active.
--****************************************************************************************************************************************
--****************************************************************************************************************************************

CREATE PROCEDURE [dbo].[pXT300GetSvcMgrContactID]
	(@parm1 as varchar(10))
AS

SELECT *
FROM cftContact c
JOIN cftEmployee e ON c.ContactID = e.ContactID
WHERE e.UserID LIKE @parm1--)
AND c.StatusTypeID = 1


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT300GetSvcMgrContactID] TO [MSDSL]
    AS [dbo];

