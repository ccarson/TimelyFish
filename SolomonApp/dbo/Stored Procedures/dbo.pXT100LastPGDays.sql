--*************************************************************
--	Purpose:Calculates the PigDays for the previous group
--		based on Site,Barn,Room, and RefDate
--	Author: Charity Anderson
--	Date: 6/27/2005
--	Usage: Transportation Module	 
--	Parms: SiteContactID,BarnNbr,RoomNbr,RefDate
--*************************************************************

CREATE PROC dbo.pXT100LastPGDays
	(@parm1 as varchar(10),@parm2 as varchar(10),
	 @parm3 as varchar(10), @parm4 as smalldatetime)
AS
DECLARE @EstStartDate as smalldatetime
SET @EstStartDate=(Select TOP 1 EstStartDate 
	from cftPigGroup pg
	LEFT JOIN cftPigGroupRoom pr on pg.PigGroupID=pr.PigGroupID

	WHERE SiteContactID=@parm1 and BarnNbr=@parm2 and 
		(pr.RoomNbr = @parm3 or pr.RoomNbr is null)
		and EstStartDate<DateAdd(d,-14,@parm4)
		ORDER BY EstStartDate DESC)
Select DateDiff(d,@EstStartDate,@parm4) as Test

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pXT100LastPGDays] TO [SOLOMON]
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT100LastPGDays] TO [MSDSL]
    AS [dbo];

