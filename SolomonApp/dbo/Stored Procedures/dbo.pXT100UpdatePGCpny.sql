--*************************************************************
--	Purpose:Updates EstInventory for specific pig group id
--		
--	Author: Charity Anderson
--	Date: 6/1/2005
--	Usage: Transportation Module	 
--	Parms: PigGroupID, NewInv, User,Prog
--*************************************************************

CREATE PROC dbo.pXT100UpdatePGCpny
	(@parm1 as varchar(10),@parm2 as varchar(3),
	 @parm3 as varchar(10), @parm4 as varchar(8))
AS
Update cftPigGroup 
Set CpnyID=@parm2, 
	Lupd_User=@parm3,
	Lupd_Prog=@parm4,
	Lupd_DateTime=GetDate()
Where PigGroupID=@parm1

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pXT100UpdatePGCpny] TO [SOLOMON]
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT100UpdatePGCpny] TO [MSDSL]
    AS [dbo];

