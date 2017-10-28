--*************************************************************
--	Purpose:Project Lookup for Purchased Pigs	
--	Author: Charity Anderson
--	Date:11/5/2004
--	Usage: PigTransportRecord 
--	Parms: @parm1 (ContactID)
--	      
--*************************************************************

CREATE PROC dbo.pXP135PPLKUP
	@parm1 as varchar(6)
	
AS
Select p.* from PJProj p
Where
	p.Project = (Select PigPurchPrefix from cftPGSetup) + @parm1
	


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXP135PPLKUP] TO [MSDSL]
    AS [dbo];

