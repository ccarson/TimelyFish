----------------------------------------------------------------------------------------
--	Purpose: 
--	Author: Timothy Jones
--	Date: 9/1/2005
--	Program Usage: XF120
--	Parms: 
----------------------------------------------------------------------------------------
CREATE PROCEDURE pXF120cftFeedOrder_CalcQty 
	@parm1 varchar (10), 
	@parm2 varchar (10), 
	@parm3 smalldatetime, 
	@parm4 varchar (10) 
	AS 
    	SELECT o.StageOrd, Sum(Case When o.Reversal = 1 Then -1 Else 1 End * 
	Case When o.Status = s.StatusCplt Then o.CnvFactDel * o.QtyDel Else o.CnvFactOrd * o.QtyOrd End), 
	Sum(Case When o.Reversal = 1 Then -1 Else 1 End), 
	Sum(Case When o.Reversal = 1 Then -1 Else 1 End * o.PGQty) 
	FROM cftFeedOrder o 
	JOIN cftFOSetUp s ON 1 = 1 
	WHERE o.PigGroupId = @parm1 
	AND o.OrdNbr <> @parm2 
	AND o.DateOrd <= @parm3 
	AND o.Status <> s.StatusCxl
	and o.RoomNbr = @parm4
	GROUP BY o.StageOrd 
	ORDER BY o.StageOrd DESC

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF120cftFeedOrder_CalcQty] TO [MSDSL]
    AS [dbo];

