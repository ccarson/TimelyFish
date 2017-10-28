--*************************************************************
--	Purpose:Returns PigGroup
--	Author: Charity Anderson
--	Date: 9/10/2004
--	Usage: PigTransportRecord app 
--	Parms:ProjectID,BarnNbr,TranDate
--*************************************************************

CREATE PROC dbo.pXP135PigGroup
	@parm1 as varchar(16),
	@parm2 as varchar(6),
	@parm3 as smalldatetime
AS

	Select p.*,r.* from cftPigGroup p 
	JOIN cftPGStatus ps on p.PGStatusID=ps.PGStatusID
	Left Join cftPigGroupRoom r on p.PigGroupId = r.PigGroupId 
	Where ProjectID = @parm1 and BarnNbr = @parm2 
	and ps.status_transport='A'
	and @parm3 between p.EstStartDate and p.EstCloseDate
	Order by p.PigGroupId
 

 
GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXP135PigGroup] TO [MSDSL]
    AS [dbo];

