--*************************************************************

--	Purpose:Sales Order and Packer Selection
--	Author: Charity Anderson
--	Date: 3/17/2005
--	Usage: Transporation Module
--	Parms: DeliveryDate
--	      
--*************************************************************

CREATE PROC dbo.pXT100MarketSale
	@parm1 as smalldatetime
	
AS
Select * from cftPSOrdHdr ps WITH (NOLOCK) 
JOIN cftContact c WITH (NOLOCK) on c.ContactID=ps.PkrContactID 
where @parm1 between FirstDelDate and LastDelDate

order by c.ContactName


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pXT100MarketSale] TO [SOLOMON]
    AS [dbo];

