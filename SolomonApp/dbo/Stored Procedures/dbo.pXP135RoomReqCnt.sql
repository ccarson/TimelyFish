--*************************************************************
--	Purpose:Defines RoomNbr requirement
--	Author: Charity Anderson
--	Date: 9/9/2004
--	Usage: PigTransportRecord app 
--	Parms:ProjectID,BarnNbr
--*************************************************************

CREATE PROC dbo.pXP135RoomReqCnt
	@parm1 as varchar(16),
	@parm2 as varchar(6)
AS
Select Count(r.PigGroupID) as PigGroupCount from 
cftPigGroup pg JOIN 
cftPigGroupRoom r on pg.PigGroupID=r.PigGroupID
JOIN cftPGStatus ps on pg.PGStatusID=ps.PGStatusID
where ps.status_transport='A' and 
pg.ProjectID=@parm1 and pg.BarnNbr=@parm2

 
GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXP135RoomReqCnt] TO [MSDSL]
    AS [dbo];

