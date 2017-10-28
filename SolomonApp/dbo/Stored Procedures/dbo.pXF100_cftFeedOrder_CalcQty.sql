Create Procedure pXF100_cftFeedOrder_CalcQty @parm1 varchar (10), @parm2 varchar (10), 
	@parm3 smalldatetime, @parm4 varchar (10) as 
    Select o.StageOrd, Sum(Case When o.Reversal = 1 Then -1 Else 1 End * 
	Case When o.Status = s.StatusCplt Then o.CnvFactDel * o.QtyDel Else o.CnvFactOrd * o.QtyOrd End), 
	Sum(Case When o.Reversal = 1 Then -1 Else 1 End), 
	Sum(Case When o.Reversal = 1 Then -1 Else 1 End * o.PGQty) 
	from cftFeedOrder o Join cftFOSetUp s on 1 = 1 
	Where o.PigGroupId = @parm1 and o.OrdNbr <> @parm2 and o.DateOrd <= @parm3 and o.Status <> s.StatusCxl
	and o.RoomNbr = @parm4
	Group by o.StageOrd Order by o.StageOrd Desc

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF100_cftFeedOrder_CalcQty] TO [MSDSL]
    AS [dbo];

