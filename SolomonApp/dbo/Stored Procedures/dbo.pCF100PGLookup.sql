
--*************************************************************
--	Purpose:Lookup for available pig groups
--		
--	Author: Charity Anderson
--	Date: 2/8/2005
--	Usage: FlowBoardModule 
--	Parms: Date, nDays , SubType, SrcDest, System
--*************************************************************

CREATE PROC dbo.pCF100PGLookup
	(@parm1 as smalldatetime,
	 @parm2 as smallint,
	 @parm3 as varchar(2),
	 @parm4 as varchar(6),
	 @parm5 as varchar(2))
AS
IF @parm4='Source'
BEGIN
Select pg.*,pr.RoomNbr
from cftPigGroup pg
LEFT JOIN cftPigGroupRoom pr on pg.PigGroupID=pr.PigGroupID
LEFT JOIN cftPGStatus s on pg.PGStatusID=s.PGStatusID
JOIN
(Select * from cftPigTranSys where TranTypeID=@parm3 and PigSystemID=@parm5) st
on st.SrcProdPhaseID=pg.PigProdPhaseID
and EstCloseDate between DateAdd(d,-1*@parm2,@parm1) and DateAdd(d,@parm2,@parm1)
order by pg.Description
END
ELSE
BEGIN
Select pg.*,pr.RoomNbr
from cftPigGroup pg
LEFT JOIN cftPigGroupRoom pr on pg.PigGroupID=pr.PigGroupID
LEFT JOIN cftPGStatus s on pg.PGStatusID=s.PGStatusID
JOIN
(Select * from cftPigTranSys where TranTypeID=@parm3 and PigSystemID=@parm5) st
on st.DestProdPhaseID=pg.PigProdPhaseID
and EstStartDate between DateAdd(d,-1*@parm2,@parm1) and DateAdd(d,@parm2,@parm1)
order by pg.Description
END


 