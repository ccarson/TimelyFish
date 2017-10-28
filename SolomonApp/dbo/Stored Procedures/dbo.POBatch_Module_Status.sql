 /****** Object:  Stored Procedure dbo.POBatch_Module_Status    Script Date: 4/16/98 7:50:25 PM ******/
Create Procedure POBatch_Module_Status As
Select * from Batch, Currncy
        where Batch.CuryID = Currncy.CuryID and
              Batch.Module  = 'PO'and
              Batch.Status IN ('I', 'S', 'B')
Order by Batch.Module, Batch.BatNbr, Batch.Status


