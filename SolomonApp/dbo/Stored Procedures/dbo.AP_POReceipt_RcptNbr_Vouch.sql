 /****** Object:  Stored Procedure dbo.AP_POReceipt_RcptNbr_Vouch    Script Date: 4/16/98 7:50:26 PM ******/
Create Procedure AP_POReceipt_RcptNbr_Vouch @parm1 varchar ( 10) As
        Select * From POReceipt Where
                POReceipt.RcptNbr = @parm1
                And POReceipt.Rlsed = 1
                And VouchStage <> 'F'


