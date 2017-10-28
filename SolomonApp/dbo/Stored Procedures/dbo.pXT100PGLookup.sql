--*************************************************************
--	Purpose:Lookup for available pig groups
--		
--	Author: Charity Anderson
--	Date: 2/8/2005
--	Usage: FlowBoardModule 
--	Parms: Date, nDays , SubType, SrcDest, System
--*************************************************************

CREATE PROC dbo.pXT100PGLookup
	(@parm1 as smalldatetime,
	 @parm2 as smallint,
	 @parm3 as varchar(2),
	 @parm4 as varchar(6),
	 @parm5 as varchar(2))
AS
DECLARE @ProdPhase varchar(3), @NbrDays smallint
IF @parm4='Source'
BEGIN
SET @ProdPhase=(Select Top 1 SrcProdPhaseID from cftPigTranSys where TranTypeID=@parm3) 
SET @NbrDays=(Select EstDays from cftPigProdPhase where PigProdPhaseID=@ProdPhase)
IF @ProdPhase in ('ISO','TEF','NSG','FIN','WTF')
	BEGIN
	Select pg.*,pr.RoomNbr,s.Status_Transport
	from cftPigGroup pg WITH (NOLOCK) 
	LEFT JOIN cftPigGroupRoom pr WITH (NOLOCK) on pg.PigGroupID=pr.PigGroupID
	JOIN cftPGStatus s WITH (NOLOCK) on pg.PGStatusID=s.PGStatusID
	and s.status_transport='A' and pg.PigProdPhaseID=@ProdPhase
 	and pg.EstStartDate<@parm1
	order by pg.Description
	END
ELSE
	BEGIN
	Select pg.*,pr.RoomNbr,s.Status_Transport
	from cftPigGroup pg WITH (NOLOCK) 
	LEFT JOIN cftPigGroupRoom pr WITH (NOLOCK) on pg.PigGroupID=pr.PigGroupID
	JOIN cftPGStatus s WITH (NOLOCK) on pg.PGStatusID=s.PGStatusID
	and EstCloseDate between DateAdd(d,-1*@parm2,@parm1) and DateAdd(d,@parm2,@parm1)
	and pg.EstStartDate<@parm1
	and s.status_transport='A' and pg.PigProdPhaseID=@ProdPhase
	order by pg.Description
	END
END
ELSE
BEGIN
SET @ProdPhase=(Select Top 1 DestProdPhaseID from cftPigTranSys where TranTypeID=@parm3) 
SET @NbrDays=(Select EstDays from cftPigProdPhase where PigProdPhaseID=@ProdPhase)
IF @ProdPhase in ('ISO','TEF','NSG','FIN','WTF')
	BEGIN
	Select pg.*,pr.RoomNbr,s.Status_Transport
	from cftPigGroup pg WITH (NOLOCK) 
	LEFT JOIN cftPigGroupRoom pr WITH (NOLOCK) on pg.PigGroupID=pr.PigGroupID
	JOIN cftPGStatus s WITH (NOLOCK) on pg.PGStatusID=s.PGStatusID
	and s.status_transport='A' and pg.PigProdPhaseID=@ProdPhase
	and pg.EstCloseDate>@parm1
	order by pg.Description
	END
ELSE
	BEGIN
	Select pg.*,pr.RoomNbr,s.Status_Transport
	from cftPigGroup pg WITH (NOLOCK) 
	LEFT JOIN cftPigGroupRoom pr WITH (NOLOCK) on pg.PigGroupID=pr.PigGroupID
	JOIN cftPGStatus s WITH (NOLOCK) on pg.PGStatusID=s.PGStatusID
	and EstStartDate between DateAdd(d,-1*@parm2,@parm1) and DateAdd(d,@parm2,@parm1)
	and s.status_transport='A' and pg.PigProdPhaseID=@ProdPhase
	order by pg.Description
	END
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pXT100PGLookup] TO [SOLOMON]
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT100PGLookup] TO [MSDSL]
    AS [dbo];

