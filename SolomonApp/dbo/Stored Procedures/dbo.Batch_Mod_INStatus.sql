 /****** Object:  Stored Procedure dbo.Batch_Mod_INStatus    Script Date: 4/7/98 12:38:58 PM ******/
Create Proc Batch_Mod_INStatus @parm1 varchar ( 2) as
       Select * from Batch, Currncy
           Where Batch.CuryId = Currncy.CuryId
             and Module   =   @parm1
             and Batch.Status   IN ('B', 'S', 'I')
           order by Module, BatNbr


