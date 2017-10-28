--*************************************************************
--	Purpose:PV for SowSites
--		
--	Author: Charity Anderson
--	Date: 1/31/2005
--	Usage: FlowBoardModule, WeanEntry	 
--	Parms: ContactID
--*************************************************************

CREATE PROC dbo.pCF101SowSitePV
	(@parm1 as varchar(10))
AS

Select c.* from cftSowSite s  
JOIN cftContact c WITH (NOLOCK) on s.ContactID=c.ContactID
where s.ContactID like @parm1 order by c.ContactID
