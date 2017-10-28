--*************************************************************
--	Purpose:DBNav for Market Sale Type
--		
--	Author: Charity Anderson
--	Date: 3/29/2005
--	Usage: Transportation Module	 
--	Parms: MarketSaleTypeID
--*************************************************************

CREATE PROC dbo.pXT301MarketSaleTypeNav
	(@parm1 as varchar(2))
AS

	Select * from cftMarketSaleType
	where MarketSaleTypeID like @parm1 
	Order by MarketSaleTypeID

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pXT301MarketSaleTypeNav] TO [SOLOMON]
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT301MarketSaleTypeNav] TO [MSDSL]
    AS [dbo];

