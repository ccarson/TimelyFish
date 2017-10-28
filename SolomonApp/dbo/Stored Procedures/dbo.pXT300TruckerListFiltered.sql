
--*************************************************************
--	Purpose:List of Filtered Truckers for Schedule Report
--		
--	Author: Charity Anderson
--	Date: 4/13/2005
--	Usage: Transportation Module	 
--	Parms: StartDate, EndDate, CpnyID,System
--*************************************************************
/*
===============================================================================
Change Log:
Date        Who         Change
----------- ----------- -------------------------------------------------------
1/20/2016  Doran Dahle  Changed Trucker Name to Short Name
===============================================================================
*/
CREATE PROC [dbo].[pXT300TruckerListFiltered]
	(@parm1 as smalldatetime, @parm2 as smalldatetime, @parm3 as varchar(3),
	@parm4 as varchar(2))

AS
IF @Parm3='' BEGIN SET @Parm3='%' END
Select Distinct c.ContactID, rtrim(c.ShortName) as TruckerName,c.TranSchedMethTypeID
FROM 
cftPM pm 
JOIN cftContact c on pm.TruckerContactID=c.ContactID
where pm.MovementDate between @parm1 and @parm2 and pm.PMSystemID like @parm4
and pm.PMSystemID like @parm4 
and (pm.Highlight <> 255 and pm.Highlight <> -65536)
--and pm.PMSystemID='01'
Order by TruckerName


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT300TruckerListFiltered] TO [MSDSL]
    AS [dbo];

