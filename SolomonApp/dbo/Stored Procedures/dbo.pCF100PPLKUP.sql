--*************************************************************
--	Purpose:Project Lookup for Purchased Pigs	
--	Author: Charity Anderson
--	Date: 2/10/2005
--	Usage: Pig Flow 
--	Parms: @parm1 (ContactID)
--	      
--*************************************************************

CREATE PROC dbo.pCF100PPLKUP
	@parm1 as varchar(6)
	
AS
Select p.*,ContactID=right(rtrim(project),6) from PJProj p
Where
	p.Project = (Select PigPurchPrefix from cftPGSetup) + @parm1
	


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF100PPLKUP] TO [MSDSL]
    AS [dbo];

