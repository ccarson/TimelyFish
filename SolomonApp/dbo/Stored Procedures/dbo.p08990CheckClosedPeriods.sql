 CREATE PROCEDURE p08990CheckClosedPeriods AS

SELECT d.*
  FROM ARDOC d LEFT JOIN vp_08400_AllAdjD v
                 ON d.custid = v.custid
                AND d.refnbr = v.adjdrefnbr
                AND d.doctype = v.adjddoctype
 WHERE d.PerClosed <>
       CASE WHEN d.PerPost > ISNULL(v.PerClosed,' ')
              THEN d.PerPost
            ELSE
              v.PerClosed
       END
   AND d.PerClosed <> ' '
   AND d.DocType in ('IN','DM','FI','NC','SC','RP','NS','CS', 'AD')



GO
GRANT CONTROL
    ON OBJECT::[dbo].[p08990CheckClosedPeriods] TO [MSDSL]
    AS [dbo];

