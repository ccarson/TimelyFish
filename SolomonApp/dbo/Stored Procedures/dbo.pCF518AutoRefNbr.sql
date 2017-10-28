--*************************************************************
--	Purpose:Autonumber RefNbr
--	Author: Charity Anderson
--	Date: 10/15/2004
--	Usage: Pig Sales Entry		 
--	Parms: 
--*************************************************************

CREATE PROC dbo.pCF518AutoRefNbr
	
AS
Select LastRefNbr from ARSetup
