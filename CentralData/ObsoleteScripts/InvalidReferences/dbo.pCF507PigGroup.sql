--*************************************************************
--	Purpose:Returns PigGroup
--	Author: Charity Anderson
--	Date: 9/10/2004
--	Usage: PigTransportRecord app 
--	Parms:ProjectID,BarnNbr,RoomNbr
--*************************************************************

CREATE PROC dbo.pCF507PigGroup
	@parm1 as varchar(16),
	@parm2 as varchar(6),
	@parm3 as varchar(10)
AS

Select p.* from cftPigGroup p 
Left Join cftPigGroupRoom r on p.PigGroupId = r.PigGroupId 
JOIN cftPGStatus ps on p.PGStatusID=ps.PGStatusID
Where ProjectID = @parm1 and BarnNbr = @parm2 and (RoomNbr = @parm3 or RoomNbr Is Null)
and ps.status_transport='A'
Order by p.PigGroupId

