 Create Procedure ARDoc_Batch_CpnyID_Rlsed2x @parm1 varchar ( 15), @parm2 varchar ( 10), @parm3 varchar (6)
As
  SELECT * FROM ARDoc, Currncy, Batch
   WHERE ARDoc.CuryId = Currncy.CuryId AND
         batch.batnbr = ardoc.batnbr AND
         (batch.module = 'AR' OR (ARDoc.Crtd_prog = 'BIREG' AND Batch.Module = 'BI')) AND
         ARDoc.CustId = @parm1 AND
         ARDoc.CpnyID = @parm2 AND
         (ARDoc.curyDocBal <> 0 OR ARDoc.CurrentNbr = 1 OR ARDoc.PerPost = @parm3) AND
         ARDoc.Rlsed = 1
   ORDER BY CustId, DocDate DESC



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARDoc_Batch_CpnyID_Rlsed2x] TO [MSDSL]
    AS [dbo];

