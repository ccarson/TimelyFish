--*************************************************************
--	Purpose:Project Lookup for Purchased Pigs	
--	Author: Charity Anderson
--	Date:11/5/2004
--	Usage: PigTransportRecord 
--	Parms: @parm1 (ContactID)
--	      
--*************************************************************

CREATE PROC dbo.pCF507PPLKUP
	@parm1 as varchar(6)
	
AS
Select p.* from PJProj p
Where
	p.Project = (Select PigPurchPrefix from cftPGSetup) + @parm1
	

