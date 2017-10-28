--*************************************************************
--	Purpose:Auto Number for PMID
--		
--	Author: Charity Anderson
--	Date: 2/3/2005
--	Usage: FlowBoardModule, WeanEntry	 
--	Parms: 
--*************************************************************

CREATE PROC dbo.pCF101PMIDAuto

AS
Select LastPMID from cftPigTranspSetup
