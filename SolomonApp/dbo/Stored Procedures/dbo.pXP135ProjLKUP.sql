
--*************************************************************
--	Purpose:Project Lookup		
--	Author: Charity Anderson
--	Date: 9/8/2004
--	Usage: PigTransportRecord 
--	Parms: @parm1 (ContactID)
--	20130311 added nolock hint      
--*************************************************************

CREATE PROC [dbo].[pXP135ProjLKUP]
	@parm1 as varchar(6)
	
AS
Select p.* from PJProj p (nolock)
JOIN cftSite s  (nolock) on 
	p.Project = (Select ProjectPrefix from cftPGSetup (nolock)) + s.SiteID
where s.ContactID = @parm1



