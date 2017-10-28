--*************************************************************
--	Purpose:Pig Purchase
--	Author: Charity Anderson
--	Date: 2/25/2005
--	Usage: Flow Board
--	Parms: DeliveryDate
--	      
--*************************************************************

CREATE PROC dbo.pCF100PigPurchase
	@parm1 as smalldatetime
	
AS
Select * from cftPigPurchase pp 
JOIN cftContact c on pp.ContactID=c.ContactID 
where @parm1 between BegDelvDate and EndDelvDate

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF100PigPurchase] TO [MSDSL]
    AS [dbo];

