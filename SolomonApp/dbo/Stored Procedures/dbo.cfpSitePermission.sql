
--****************************************************************
--	Purpose:Control Entry of Data for a specific Site based on 
--		Solomon UserId
--		
--	Author: Sue Matter
--	Date: 7/28/2005
--	Program Usage: XF100, XF102
--	Parms: USERID
--****************************************************************

CREATE PROCEDURE [dbo].[cfpSitePermission]
	@parm1 AS char(47)
	
	-- Added Execute As to handle SL Integrated Security method -- TJones 3/8/2012
	WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
	
AS

BEGIN
DECLARE	@testval AS char(47) 
--Select @parm1='B50USER'
Select @testval = gp.GroupID
		From vs_UserGrp gp
		Where gp.UserID=@parm1 AND gp.GroupID IN('FEEDMGT', 'ADMINISTRATORS')
IF ISNULL(@testval,'')=''
	BEGIN
		select ct.ContactName, pm.SiteContactID
		FROM cftContact ct 
		JOIN cftUserSitePerm pm ON ct.ContactID=pm.SiteContactID
		Where ct.ContactTypeID='04' AND ct.StatusTypeID='1' AND pm.UserID=@parm1
        	Order by ct.ContactName
	END
ELSE
	BEGIN
		SELECT	ct.ContactName, ct.ContactID
		FROM cftContact ct 
		Where ct.ContactTypeID='04' AND ct.StatusTypeID='1' 
	        Order by ct.ContactName
	END
END






