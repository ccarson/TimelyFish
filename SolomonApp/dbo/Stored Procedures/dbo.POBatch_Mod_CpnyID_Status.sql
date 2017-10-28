 /****** Object:  Stored Procedure dbo.POBatch_Mod_CpnyID_Status    Script Date: 4/16/98 7:50:25 PM ******/
Create Procedure POBatch_Mod_CpnyID_Status @parm1 varchar (10) As
Select * from Batch, Currncy
        where Batch.CuryID = Currncy.CuryID and
                Batch.CpnyID Like @parm1 and
                Batch.Module  = 'PO'and
                Batch.Status IN ('I', 'S', 'B')
Order by Batch.Module, Batch.BatNbr, Batch.Status


