--*************************************************************
--	Purpose:Project Lookup		
--	Author: Charity Anderson
--	Date: 9/8/2004
--	Usage: PigTransportRecord 
--	Parms: @parm1 (ContactID)
--	      
--*************************************************************

CREATE PROC dbo.pCF507ProjLKUP
	@parm1 as varchar(6)
	
AS
Select p.* from PJProj p
JOIN cftSite s on 
	p.Project = (Select ProjectPrefix from cftPGSetup) + s.SiteID
where s.ContactID = @parm1


