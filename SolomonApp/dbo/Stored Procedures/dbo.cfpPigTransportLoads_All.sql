--*************************************************************
--	Purpose:Distinct list of Loads w/Date,Trucking Info
--	Author: Charity Anderson
--	Date: 7/27/2004
--	Usage: PigTransportRecord app Load Detail
--	Parms:PMLoadID
--*************************************************************

CREATE PROC dbo.cfpPigTransportLoads_All
	@PMLoadID as char(6)
AS
Select * 
From
cfvPigTransportLoads
WHERE PMLoadID like @PMLoadID
ORDER BY PMLoadID

GO
GRANT CONTROL
    ON OBJECT::[dbo].[cfpPigTransportLoads_All] TO [MSDSL]
    AS [dbo];

