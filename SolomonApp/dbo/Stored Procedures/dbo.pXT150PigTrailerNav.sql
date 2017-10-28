--*************************************************************
--	Purpose:DBNav for PigTrailer Records	
--		
--	Author: Charity Anderson
--	Date: 3/28/2005
--	Usage: Pig Trailer Maintenance 
--	Parms: PigTrailerID
--*************************************************************

CREATE PROC dbo.pXT150PigTrailerNav
	(@parm1 as varchar(3))
AS
Select * from cftPigTrailer where PigTrailerID like @parm1
order by PigTrailerID

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pXT150PigTrailerNav] TO [SOLOMON]
    AS [dbo];

