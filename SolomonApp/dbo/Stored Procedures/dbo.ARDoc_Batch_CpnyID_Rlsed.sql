 Create Procedure ARDoc_Batch_CpnyID_Rlsed @parm1 varchar ( 15), @parm2 varchar ( 10)
As
SELECT * FROM ARDoc, Currncy, Batch
 WHERE ARDoc.CuryId = Currncy.CuryId AND
       batch.batnbr = ardoc.batnbr AND
       (batch.module = 'AR' OR (ARDoc.Crtd_prog = 'BIREG' AND Batch.Module = 'BI')) AND
       ARDoc.CustId = @parm1 AND
       ARDoc.CpnyID = @parm2 AND
       ARDoc.Rlsed = 1
 ORDER BY CustId, DocDate DESC



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARDoc_Batch_CpnyID_Rlsed] TO [MSDSL]
    AS [dbo];

