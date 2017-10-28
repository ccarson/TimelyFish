--*************************************************************
--	Purpose:Trucker Vendor PV for Open Sales Order
--	Author: Charity Anderson
--	Date: 10/20/2004
--	Usage: Pig Sales Entry		 
--	Parms: TrkVendID
--*************************************************************

CREATE PROC dbo.pCF518TrkVendID
	(@parm1 as varchar(15))
AS
Select Distinct vendor.* from Vendor right join cftMarketTrucker on vendor.VendID=cftMarketTrucker.VendID 
where vendor.vendID like @parm1 order by vendor.VendID
