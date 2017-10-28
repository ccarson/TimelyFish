 CREATE PROCEDURE WOPJChargD_UnReleased
   @Project    varchar( 16 )

AS
   SELECT      *
   FROM        PJChargD LEFT JOIN PJChargH
               ON PJChargD.Batch_ID = PJChargH.Batch_ID
   WHERE       PJChargD.Project = @Project
   ORDER BY    PJChargD.Project, PJChargD.PJT_Entity, PJChargD.Batch_ID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOPJChargD_UnReleased] TO [MSDSL]
    AS [dbo];

