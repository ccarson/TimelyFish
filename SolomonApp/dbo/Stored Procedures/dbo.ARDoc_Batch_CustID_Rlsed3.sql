 Create Procedure ARDoc_Batch_CustID_Rlsed3 @parm1 varchar ( 15), @parm2 varchar(47), @parm3 varchar(7), @parm4 varchar(1)
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
SELECT * FROM ARDoc, Currncy, Batch
 WHERE ARDoc.CuryId = Currncy.CuryId AND
       batch.batnbr = ardoc.batnbr AND
       (batch.module = 'AR' OR (ARDoc.Crtd_prog = 'BIREG' AND Batch.Module = 'BI')) AND
       ARDoc.CustId = @parm1 AND
       ARDoc.curyDocBal <> 0 AND
       ARDoc.Rlsed = 1  AND
       ARDoc.cpnyid IN

             (SELECT Cpnyid
                FROM vs_share_usercpny
               WHERE userid = @parm2
                 AND scrn = @parm3
                 AND seclevel >= @parm4)
 ORDER BY CustId DESC, DocDate DESC



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARDoc_Batch_CustID_Rlsed3] TO [MSDSL]
    AS [dbo];

