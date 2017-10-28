 /****** Object:  Stored Procedure dbo.APBatch_Module_Status    Script Date: 4/7/98 12:19:54 PM ******/
Create Procedure APBatch_Module_Status As
Select * from Batch, Currncy where Module  = 'AP'
and Batch.Status IN ('I', 'S', 'B')
and Batch.CuryID = Currncy.CuryID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[APBatch_Module_Status] TO [MSDSL]
    AS [dbo];

