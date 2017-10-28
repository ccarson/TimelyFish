 Create Procedure POReturn_VendID_AP_PV3 @parm1 varchar ( 15), @parm2 varchar ( 10) As
        Select distinct r.* From POReceipt r
		inner join potran t on t.rcptnbr = r.rcptnbr
		where
				r.Rlsed = 1
                And r.VouchStage <> 'F'
				And r.RcptType = 'X'
                AND r.VendID LIKE @parm1
                And r.RcptNbr LIKE @parm2
        Order By r.VendID, r.RcptNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POReturn_VendID_AP_PV3] TO [MSDSL]
    AS [dbo];

