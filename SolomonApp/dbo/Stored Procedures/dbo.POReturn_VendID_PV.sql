 /****** Object:  Stored Procedure dbo.POReturn_VendID_PV    Script Date: 11/24/99 7:50:26 PM ******/
Create Procedure POReturn_VendID_PV @parm1 varchar ( 15), @parm2 varchar ( 10) As
        Select distinct r.* From POReceipt r
	inner join potran t on t.rcptnbr = r.rcptnbr
        Where
		r.VendID = @parm1
                And r.Rlsed = 1
                And r.VouchStage <> 'F'
		And r.RcptType = 'X'
                And r.RcptNbr LIKE @parm2
        Order By r.VendID, r.RcptNbr


