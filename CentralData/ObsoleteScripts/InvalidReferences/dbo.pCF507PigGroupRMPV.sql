--*************************************************************
--	Purpose:PV for PigGroup Room
--	Author: Charity Anderson
--	Date: 9/10/2004
--	Usage: PigTransportRecord app 
--	Parms:ProjectID,BarnNbr,RoomNbr
--*************************************************************

CREATE PROC dbo.pCF507PigGroupRMPV
	@parm1 as varchar(16),
	@parm2 as varchar(6),
	@parm3 as varchar(10)
AS

Select r.* from cftPigGroupRoom r 
Left Join cftPigGroup  p on p.PigGroupId = r.PigGroupId 
JOIN cftPGStatus ps on p.PGStatusID=ps.PGStatusID
Where ProjectID = @parm1 and BarnNbr = @parm2 and 
RoomNbr like @parm3
and ps.status_transport='A'
Order by r.RoomNbr

