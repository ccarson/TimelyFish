 Create Procedure POReceipt_VendID_AP_PV2 @parm1 varchar ( 15), @parm2 varchar ( 10) As
        Select r.* From POReceipt r
				where
				r.Rlsed = 1
                And r.VouchStage <> 'F'
				And r.RcptType <> 'X'
                AND r.VendID LIKE @parm1
                And r.RcptNbr LIKE @parm2
				 Order By r.VendID, r.RcptNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POReceipt_VendID_AP_PV2] TO [MSDSL]
    AS [dbo];

