 /****** Object:  Stored Procedure dbo.ARDoc_ApplBatNbr_RefNbr    Script Date: 4/7/98 12:30:32 PM ******/
Create Procedure ARDoc_ApplBatNbr_RefNbr @parm1 varchar ( 10), @parm2 varchar ( 10) as
    Select * from ARDoc where ApplBatNbr = @parm1
        and DocType IN ('PA','CM')
        and RefNbr like @parm2
        order by ApplBatNbr, ApplBatSeq


