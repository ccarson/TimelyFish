----------------------------------------------------------------------------------------
--	Purpose: 
--	Author: Timothy Jones
--	Date: 9/1/2005
--	Program Usage: XF120
--	Parms: 
----------------------------------------------------------------------------------------
CREATE PROCEDURE pXF120cftSSMA_SvcMgr 
	@parm1 varchar (6), 
	@parm2 smalldatetime 
	AS 
    	SELECT c.* 
	FROM cftContact c 
	JOIN cftSiteSvcMgrAsn s ON c.ContactId = s.SvcMgrContactID 
	WHERE s.SiteContactId = @parm1 
	AND s.EffectiveDate <= @parm2
	ORDER BY s.EffectiveDate DESC

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF120cftSSMA_SvcMgr] TO [MSDSL]
    AS [dbo];

