--*************************************************************
--	Purpose:DBNav for SowSites
--		
--	Author: Charity Anderson
--	Date: 1/31/2005
--	Usage: FlowBoardModule, WeanEntry	 
--	Parms: ContactID
--*************************************************************

CREATE PROC dbo.pCF101SowSiteDBNav
	(@parm1 as varchar(10))
AS

Select * from cftSowSite where ContactID like @parm1 order by ContactID
