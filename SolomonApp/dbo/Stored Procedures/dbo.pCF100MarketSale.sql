--*************************************************************

--	Purpose:Sales Order and Packer Selection
--	Author: Charity Anderson
--	Date: 3/17/2005
--	Usage: Transporation Module
--	Parms: DeliveryDate
--	      
--*************************************************************

CREATE PROC dbo.pCF100MarketSale
	@parm1 as smalldatetime
	
AS
Select * from cftPSOrdHdr ps
JOIN cftContact c on c.ContactID=ps.PkrContactID 
where @parm1 between FirstDelDate and LastDelDate
order by c.ContactName


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF100MarketSale] TO [MSDSL]
    AS [dbo];

