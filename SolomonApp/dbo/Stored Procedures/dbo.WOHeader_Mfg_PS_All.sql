 CREATE PROCEDURE WOHeader_Mfg_PS_All
   @ProcStage  	varchar( 1 ),
   @WONbr      	varchar( 16 )
AS
   SELECT       *
   FROM         WOHeader
   WHERE        WOType IN ('M','R')
                and ProcStage LIKE @ProcStage
                and WONbr LIKE @WONbr
   ORDER BY     WONbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOHeader_Mfg_PS_All] TO [MSDSL]
    AS [dbo];

