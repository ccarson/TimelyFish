


--*************************************************************
--	Purpose:PV for Contact table			
--	Author: Charity Anderson
--	Date: 8/3/2004
--	Usage: PigTransportRecord 
--	Parms: @parm1 (SolomonContactID)
--	       @RoleTypeID1-3 (optional)
--*************************************************************

CREATE PROC [dbo].[pXP135ContactPV]
	@RoleTypeID1 int=NULL,
	@RoleTypeID2 int=NULL,
	@RoleTypeID3 int=NULL,
	@parm1 as varchar(6)
	

AS

SELECT  c.*
FROM cftContact c 
JOIN vXP135Contact v ON c.ContactID = v.ContactID
WHERE v.RoleTypeID IN (@RoleTypeID1, @RoleTypeID2, @RoleTypeID3)
AND v.ContactID LIKE @parm1

ORDER BY c.ContactID






