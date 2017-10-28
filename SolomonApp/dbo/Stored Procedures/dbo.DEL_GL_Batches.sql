 /****** Object:  Stored Procedure dbo.DEL_GL_Batches    Script Date: 4/7/98 12:38:58 PM ******/
Create Proc  DEL_GL_Batches @parm1 varchar ( 6), @parm2 varchar ( 6) as
       Delete batch from Batch
           where Batch.Module  =  'GL'
             and Batch.Status  in ('V', 'D', 'P')
             and Batch.PerPost <= @parm1
             and Batch.PerEnt  <  @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DEL_GL_Batches] TO [MSDSL]
    AS [dbo];

