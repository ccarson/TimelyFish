 CREATE PROCEDURE WOGLTran_UnReleased
   @PerPost    varchar( 6 )

AS
   SELECT      *
   FROM        GLTran
   WHERE       Module = 'GL' and
               PerPost = @PerPost and
               PC_Status = '1'
   ORDER BY    Module, PerPost, Rlsed, TranType



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOGLTran_UnReleased] TO [MSDSL]
    AS [dbo];

