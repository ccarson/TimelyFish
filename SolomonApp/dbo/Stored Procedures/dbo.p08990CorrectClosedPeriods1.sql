 CREATE PROCEDURE p08990CorrectClosedPeriods1 AS

UPDATE d
   SET d.Perclosed =
       CASE WHEN d.PerPost > ISNULL(v.PerClosed,' ')
              THEN d.PerPost
            ELSE
              v.PerClosed
       END
  FROM ARDOC d LEFT JOIN vp_08400_AllAdjG v
                 ON d.custid = v.custid
                AND d.refnbr = v.adjgrefnbr
                AND d.doctype = v.adjgdoctype
 WHERE d.PerClosed <>
       CASE WHEN d.PerPost > ISNULL(v.PerClosed,' ')
              THEN d.PerPost
            ELSE
              v.PerClosed
       END
   AND d.PerClosed <> ' '
   AND d.DocType in ('PA','PP','CM','SB', 'RA')



GO
GRANT CONTROL
    ON OBJECT::[dbo].[p08990CorrectClosedPeriods1] TO [MSDSL]
    AS [dbo];

