--*************************************************************
--	Purpose:Updates the status to Pending for specific pig group id
--		
--	Author: Charity Anderson
--	Date: 3/10/2006
--	Usage: Transportation Module	 
--	Parms: PigGroupID, User,Prog
--*************************************************************

CREATE PROC dbo.pXT100UpdatePGSetPending
	(@parm1 as varchar(10),
	 @parm3 as varchar(10), @parm4 as varchar(8))
AS
DECLARE @FeedOrder as varchar(10)
SET @FeedOrder=(Select TOP 1 OrdNbr from cftFeedOrder where PigGroupID=@parm1)
IF @FeedOrder is null
BEGIN
BEGIN TRANSACTION
Update cftPigGroup 
Set PGStatusID='P', 
	Lupd_User=@parm3,
	Lupd_Prog=@parm4,
	Lupd_DateTime=GetDate()
Where PigGroupID=@parm1

Insert into cftPGStatHist
(Crtd_DateTime, Crtd_Prog, Crtd_User, Lupd_DateTime, Lupd_Prog,Lupd_User, PigGroupID, PGStatusID, StatusDate)
Select
GetDate(),@parm4, @parm3,GetDate(),@parm4, @parm3, @parm1,'P',GetDate()
COMMIT WORK
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pXT100UpdatePGSetPending] TO [SOLOMON]
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT100UpdatePGSetPending] TO [MSDSL]
    AS [dbo];

