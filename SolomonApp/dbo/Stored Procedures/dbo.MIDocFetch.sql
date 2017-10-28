 CREATE PROCEDURE MIDocFetch @parm1 VARCHAR(21) AS

SELECT d.*
  FROM WrkRelease w JOIN ArDoc d
                      ON w.batnbr = d.batnbr
WHERE w.UserAddress = @Parm1 AND w.Module = 'AR'
  AND d.rlsed = 1
  AND d.doctype = 'IN'
  AND EXISTS
        (SELECT 'Terms Exist'
           FROM DocTerms dt
          WHERE dt.DocType = 'IN'
            AND dt.RefNbr = d.RefNbr)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[MIDocFetch] TO [MSDSL]
    AS [dbo];

