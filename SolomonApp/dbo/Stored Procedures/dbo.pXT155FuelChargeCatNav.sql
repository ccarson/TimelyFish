--*************************************************************
--	Purpose:DBNav for FuelChargeCategory
--		
--	Author: Charity Anderson
--	Date: 3/28/2005
--	Usage: Transportation Module	 
--	Parms: LineNbr
--*************************************************************

CREATE PROC dbo.pXT155FuelChargeCatNav
	(@parm1 as smallint, @parm2 as smallint)
AS

	Select * from cftFuelChargeCat where LineNbr 
	between @parm1 and @parm2
	Order by LineNbr

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pXT155FuelChargeCatNav] TO [SOLOMON]
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT155FuelChargeCatNav] TO [MSDSL]
    AS [dbo];

