--*************************************************************
--	Purpose:Auto Number for PigPurchase Nbr
--		
--	Author: Charity Anderson
--	Date: 2/22/2005
--	Usage: Pig Purchase Agreement 
--	Parms: 
--*************************************************************

CREATE PROC dbo.pCF102PPIDAuto

AS
Select LastPPRefNbr from cftPMSetup

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF102PPIDAuto] TO [MSDSL]
    AS [dbo];

