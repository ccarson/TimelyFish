 /****** Object:  Stored Procedure dbo.DeleteAPBatch    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure DeleteAPBatch @parm1 varchar ( 6), @parm2 varchar ( 6) As
Delete batch from Batch Where
Module = 'AP' and
Status in ('V', 'C', 'P', 'D') and
PerPost <= @parm1 and
PerPost <= @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DeleteAPBatch] TO [MSDSL]
    AS [dbo];

