
--*************************************************************

--	Purpose:Pig Purchase
--	Author: Charity Anderson
--	Date: 2/25/2005
--	Usage: Flow Board
--	Parms: DeliveryDate
--	      
--*************************************************************

CREATE  PROC dbo.pXT100PigPurchase
	@parm1 as smalldatetime
	
AS
Select * from cftPigPurchase pp 
JOIN cftContact c WITH (NOLOCK) on pp.ContactID=c.ContactID 
where @parm1 between BegDelvDate and EndDelvDate




GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pXT100PigPurchase] TO [SOLOMON]
    AS [dbo];

