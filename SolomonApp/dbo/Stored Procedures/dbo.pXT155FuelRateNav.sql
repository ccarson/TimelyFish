--*************************************************************
--	Purpose:DBNav for FuelRate
--		
--	Author: Charity Anderson
--	Date: 3/29/2005
--	Usage: Transportation Module	 
--	Parms: EffectiveDate
--*************************************************************

CREATE PROC dbo.pXT155FuelRateNav
	(@parm1 as smalldatetime, @parm2 as smalldatetime)
AS

	Select * from cftFuelRate where EffectiveWeek 
	between @parm1 and @parm2
	Order by EffectiveWeek DESC

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pXT155FuelRateNav] TO [SOLOMON]
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT155FuelRateNav] TO [MSDSL]
    AS [dbo];

