--*************************************************************
--	Purpose:Retrieve last Order Number
--	Author: Charity Anderson
--	Date: 10/10/2004
--	Usage: Pig Sales Order			 
--	Parms:
--*************************************************************

CREATE PROC dbo.pCF519AutoOrdNbr
AS
Select LastOrdNbr
From
cftPSSetup


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF519AutoOrdNbr] TO [MSDSL]
    AS [dbo];

