 /****** Object:  Stored Procedure dbo.POReceipt_PONbr_Rlsd    Script Date: 4/16/98 7:50:26 PM ******/
Create Procedure POReceipt_PONbr_Rlsd @parm1 varchar ( 10) As
        Select distinct POReceipt.* From POReceipt
        inner join potran on potran.rcptnbr = poreceipt.ponbr
                Where
                potran.PONbr = @parm1
                And POReceipt.Rlsed = 1
                And POReceipt.CreateAD = 0
                And Poreceipt.VouchStage <> 'F'
        Order By POReceipt.PONbr, POReceipt.RcptNbr


