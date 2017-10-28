 /****** Object:  Stored Procedure dbo.ARDoc_ApplBatNbr    Script Date: 4/7/98 12:30:32 PM ******/
Create Procedure ARDoc_ApplBatNbr @parm1 varchar ( 10) as
    Select * from ARDoc where
        ApplBatNbr = @parm1
        order by ApplBatNbr, ApplBatSeq


