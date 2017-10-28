
--*************************************************************
--	Purpose:List of Truckers for Schedule Report
--		
--	Author: Charity Anderson
--	Date: 4/13/2005
--	Usage: Transportation Module	 
--	Parms: StartDate, EndDate, CpnyID
--*************************************************************
-- 1/21/2016  ddahle  		 Changed Driver name to ShortName
CREATE PROC [dbo].[pXT300TruckerList]
	(@parm1 as smalldatetime, @parm2 as smalldatetime, @parm3 as varchar(3))

AS
IF @Parm3='' BEGIN SET @Parm3='%' END
Select 'ALL' as ContactID,'<ALL>' as TruckerName ,'' as TranschedMethTypeID
UNION
Select Distinct c.ContactID, rtrim(c.ShortName) as TruckerName,c.TranSchedMethTypeID
FROM 
cftPM pm 
JOIN cftContact c on pm.TruckerContactID=c.ContactID
where pm.MovementDate between @parm1 and @parm2 and pm.PMSystemID like @parm3
and (pm.Highlight <> 255 and pm.Highlight <> -65536)
--and pm.PMSystemID='01'


Order by TruckerName


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT300TruckerList] TO [MSDSL]
    AS [dbo];

