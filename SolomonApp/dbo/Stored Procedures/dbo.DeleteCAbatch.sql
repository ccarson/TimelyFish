 /****** Object:  Stored Procedure dbo.DeleteCAbatch    Script Date: 4/7/98 12:49:20 PM ******/
Create Procedure DeleteCAbatch @parm1 varchar ( 6), @parm2 varchar ( 6) As
select * from Batch Where
batch.Module = 'CA' and
Batch.Status in ('V', 'C', 'P') and
Batch.PerPost <= @parm1 and
Batch.PerPost <= @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DeleteCAbatch] TO [MSDSL]
    AS [dbo];

