 Create Procedure NoBatchReport @parm1 varchar (10) as
   Select * from Batch where
      batch.batnbr =  @parm1 and
      batch.EditScrnNbr = '08030' and
      batch.CuryCtrlTot = 0 and
      batch.module = 'AR'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[NoBatchReport] TO [MSDSL]
    AS [dbo];

