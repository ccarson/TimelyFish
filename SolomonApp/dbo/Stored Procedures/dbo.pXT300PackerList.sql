
--*************************************************************
--	Purpose:List of Packers for Schedule Report
--		
--	Author: Charity Anderson
--	Date: 4/13/2005
--	Usage: Transportation Module	 
--	Parms: StartDate, EndDate, CpnyID
--*************************************************************

CREATE PROC dbo.pXT300PackerList
	(@parm1 as smalldatetime, @parm2 as smalldatetime, @parm3 as varchar(3))

AS
IF @Parm3='' BEGIN SET @Parm3='%' END
Select 'ALL' as ContactID,'<ALL>' as PackerName ,'' as TranschedMethTypeID
UNION
Select Distinct c.ContactID, rtrim(c.ContactName) as PackerName,c.TranSchedMethTypeID
FROM 
cftPM pm 
JOIN cftPacker p on pm.DestContactID=p.ContactID
JOIN cftContact c on p.ContactID=c.ContactID
where pm.MovementDate between @parm1 and @parm2 and pm.PMSystemID like @parm3
and (pm.Highlight <> 255 and pm.Highlight <> -65536)
--and pm.PMSystemID='01'


Order by PackerName


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT300PackerList] TO [MSDSL]
    AS [dbo];

