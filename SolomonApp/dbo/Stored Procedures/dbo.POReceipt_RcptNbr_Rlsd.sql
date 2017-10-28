 /****** Object:  Stored Procedure dbo.POReceipt_RcptNbr_Rlsd    Script Date: 2/28/02 6:30:41 PM ******/
Create Procedure POReceipt_RcptNbr_Rlsd @parm1 varchar ( 10) As
        Select * From POReceipt Where
                POReceipt.RcptNbr = @parm1
                And POReceipt.Rlsed = 1
                And POReceipt.CreateAD = 0
                And Poreceipt.VouchStage <> 'F'


