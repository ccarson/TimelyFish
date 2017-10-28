 /****** Object:  Stored Procedure dbo.Get_Batch_Total    Script Date: 4/7/98 12:30:33 PM ******/
Create Procedure Get_Batch_Total @parm1 varchar ( 10) as
        SELECT CuryCrTot from Batch WHERE
        Batch.BatNbr = @parm1
	AND Batch.Module = 'AR'



