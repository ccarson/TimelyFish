--*************************************************************
--	Purpose:Updates EstStartDate for specific pig group id
--		
--	Author: Charity Anderson
--	Date: 3/24/2005
--	Usage: Transportation Module	 
--	Parms: PigGroupID, NewDate, User,Prog
--*************************************************************

CREATE PROC dbo.pXT100UpdatePGStart
	(@parm1 as varchar(10),@parm2 as smalldatetime,
	 @parm3 as varchar(10), @parm4 as varchar(8))
AS
DECLARE @Days as smallint
Set @Days=(Select EstDays from cftPigProdPhase pp 
			JOIN cftPigGroup pg on pg.PigProdPhaseID=pp.PigProdPhaseID
			where pg.PigGroupID=@parm1)
Update cftPigGroup 
Set EstStartDate=@parm2, 
	Lupd_User=@parm3,
	Lupd_Prog=@parm4,
	Lupd_DateTime=GetDate()
Where PigGroupID=@parm1

If @Days>0 
	BEGIN Update cftPigGroup set EstCloseDate=@parm2+@Days 
		 	WHERE PigGroupID=@parm1
	END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pXT100UpdatePGStart] TO [SOLOMON]
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT100UpdatePGStart] TO [MSDSL]
    AS [dbo];

