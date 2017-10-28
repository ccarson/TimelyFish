 CREATE PROCEDURE WOHeader_MfgPrj_PS_All
   @ProcStage  varchar( 1 ),
   @WONbr      varchar( 16 )
AS
   SELECT      *
   FROM        WOHeader
   WHERE       (ProcStage = ' ' or ProcStage = @ProcStage) and
               WONbr LIKE @WONbr
   ORDER BY    WONbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOHeader_MfgPrj_PS_All] TO [MSDSL]
    AS [dbo];

