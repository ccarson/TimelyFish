--*************************************************************
--	Purpose:Defines RoomNbr requirement
--	Author: Charity Anderson
--	Date: 9/9/2004
--	Usage: PigTransportRecord app 
--	Parms:ProjectID,BarnNbr,TranDate
--*************************************************************

CREATE PROC dbo.pCF507RoomReq
	@parm1 as varchar(16),
	@parm2 as varchar(6),
	@parm3 as smalldatetime
AS
Select Count(*) as PigGroupCount from 
cftPigGroup pg JOIN 
cftPGStatus ps on pg.PGStatusID=ps.PGStatusID
LEFT JOIN cftPigGroupRoom r on r.PigGroupID=pg.PigGroupID
where ps.status_transport='A' 
and @parm3 between pg.EstStartDate and pg.EstCloseDate
and 
pg.ProjectID=@parm1 and pg.BarnNbr=@parm2


 