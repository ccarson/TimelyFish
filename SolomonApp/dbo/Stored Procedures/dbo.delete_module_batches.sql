 /****** Object:  Stored Procedure dbo.delete_module_batches    Script Date: 4/7/98 12:38:59 PM ******/
Create Proc delete_module_batches @parm1 varchar ( 2), @parm2 varchar ( 6), @parm3 varchar ( 6) As
       Delete batch From Batch
           where Batch.Module = @parm1
             and STATUS IN ('V', 'C', 'D', 'P')
             and PerPost < @parm2

             and PerPost < @parm3



GO
GRANT CONTROL
    ON OBJECT::[dbo].[delete_module_batches] TO [MSDSL]
    AS [dbo];

