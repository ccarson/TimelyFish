 /****** Object:  Stored Procedure dbo.CABatch_Module_Status    Script Date: 4/7/98 12:49:20 PM ******/
Create Procedure CABatch_Module_Status @parm1 varchar(10) As
Select * from Batch, Currncy
where Batch.CuryId = Currncy.CuryId
and Module  = 'CA'
and Batch.CpnyID like @parm1
and Batch.Status IN ('I', 'S', 'B')
Order by CpnyID, Module, BatNbr, Batch.Status



GO
GRANT CONTROL
    ON OBJECT::[dbo].[CABatch_Module_Status] TO [MSDSL]
    AS [dbo];

