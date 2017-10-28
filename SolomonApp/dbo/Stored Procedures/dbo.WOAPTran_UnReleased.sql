 CREATE PROCEDURE WOAPTran_UnReleased
   @PerPost    varchar( 6 )

AS
   SELECT      *
   FROM        APTran
   WHERE       PerPost = @PerPost and
               PC_Status = '1'
   ORDER BY    PerPost, Rlsed, CostType



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOAPTran_UnReleased] TO [MSDSL]
    AS [dbo];

