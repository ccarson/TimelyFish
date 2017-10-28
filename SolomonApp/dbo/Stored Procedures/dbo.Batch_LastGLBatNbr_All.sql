 /****** Object:  Stored Procedure dbo.Batch_LastGLBatNbr_All    Script Date: 4/7/98 12:38:58 PM ******/
Create Proc  Batch_LastGLBatNbr_All as
Select * from Batch
where Module  =  'GL'
order by Module DESC, BatNbr DESC



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Batch_LastGLBatNbr_All] TO [MSDSL]
    AS [dbo];

