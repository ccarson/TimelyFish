 CREATE PROCEDURE WOPJPTDRol_PJAcct
   @Project    varchar( 16 )

AS
   SELECT      *
   FROM     PJPTDRol LEFT JOIN PJAcct
         ON PJPTDROL.Acct = PJAcct.Acct
   WHERE    PJPTDRol.Project = @Project
   ORDER BY    PJPTDRol.Project, PJPTDRol.Acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOPJPTDRol_PJAcct] TO [MSDSL]
    AS [dbo];

