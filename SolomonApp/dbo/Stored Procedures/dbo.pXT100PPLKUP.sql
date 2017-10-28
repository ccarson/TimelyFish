--*************************************************************
--	Purpose:Project Lookup for Purchased Pigs	
--	Author: Charity Anderson
--	Date: 2/10/2005
--	Usage: Pig Flow 
--	Parms: @parm1 (ContactID)
--	      
--*************************************************************

CREATE PROC dbo.pXT100PPLKUP
	@parm1 as varchar(6)
	
AS
Select p.*,ContactID=right(rtrim(project),6) from PJProj p WITH (NOLOCK) 
Where
	p.Project = (Select PigPurchPrefix from cftPGSetup) + @parm1
	


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pXT100PPLKUP] TO [SOLOMON]
    AS [dbo];

