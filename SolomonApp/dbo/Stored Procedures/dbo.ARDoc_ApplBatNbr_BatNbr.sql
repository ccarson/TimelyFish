 /****** Object:  Stored Procedure dbo.ARDoc_ApplBatNbr_BatNbr    Script Date: 4/7/98 12:30:32 PM ******/
Create Procedure ARDoc_ApplBatNbr_BatNbr @parm1 varchar ( 10), @parm2 varchar ( 10) as
    Select * from ARDoc where
        (BatNbr = @parm1 or ApplBatNbr = @parm2)
        order by ApplBatNbr, ApplBatSeq, BatNbr, BatSeq


