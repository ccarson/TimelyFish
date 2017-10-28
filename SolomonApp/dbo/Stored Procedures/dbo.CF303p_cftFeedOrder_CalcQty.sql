Create Procedure CF303p_cftFeedOrder_CalcQty @parm1 varchar (10), @parm2 varchar (10), 
	@parm3 smalldatetime, @parm4 varchar (10) as 
    Select o.StageOrd, Sum(Case When o.Reversal = 1 Then -1 Else 1 End * o.CnvFactOrd * 
	Case When o.Status = s.StatusCplt Then o.QtyDel Else o.QtyOrd End), 
	Count(Case When o.Reversal = 1 Then -1 Else 1 End * o.OrdNbr), 
	Sum(Case When o.Reversal = 1 Then -1 Else 1 End * o.PGQty) 
	from cftFeedOrder o Join cftFOSetUp s on 1 = 1 
	Where o.PigGroupId = @parm1 and o.OrdNbr <> @parm2 and o.DateOrd <= @parm3 and o.OrdType <> s.StatusCxl
	and o.RoomNbr = @parm4
	Group by o.StageOrd Order by o.StageOrd Desc

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF303p_cftFeedOrder_CalcQty] TO [MSDSL]
    AS [dbo];

