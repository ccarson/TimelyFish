--*************************************************************
--	Purpose:Project Lookup		
--	Author: Charity Anderson
--	Date: 2/10/2005
--	Usage: Pig Flow 
--	Parms: @parm1 (ContactID), @parm2 (MovementDate)
--	      
--*************************************************************

CREATE PROC dbo.pCF100ProjLKUP
	@parm1 as varchar(6),
	@parm2 as smalldatetime
	
AS
Select p.*, ServiceMan=dbo.GetSvcManagerNm(@parm1,@parm2,''), s.ContactID
from PJProj p
JOIN cftSite s on 
	p.Project = (Select ProjectPrefix from cftPGSetup) + s.SiteID
where s.ContactID = @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF100ProjLKUP] TO [MSDSL]
    AS [dbo];

