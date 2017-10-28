 /****** Object:  Stored Procedure dbo.POReceipt_PONbr_AP_PV    Script Date: 11/24/99 7:50:26 PM ******/
Create Procedure POReceipt_PONbr_AP_PV @parm1 varchar ( 10), @parm2 varchar ( 10) As
        Select distinct r.* From POReceipt r
	inner join potran t on t.rcptnbr = r.rcptnbr
	where
                t.PONbr = @parm1
                And r.Rlsed = 1
                And r.VouchStage <> 'F'
		And r.RcptType <> 'X'
                And r.RcptNbr LIKE @parm2
        Order By r.PONbr, r.RcptNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POReceipt_PONbr_AP_PV] TO [MSDSL]
    AS [dbo];

