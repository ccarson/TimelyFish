 CREATE PROCEDURE WOHeader_Mfg_PS_CpnyID
   @CpnyID	varchar( 10 ),
   @ProcStage  	varchar( 1 ),
   @WONbr      	varchar( 16 )
AS
   SELECT       *
   FROM         WOHeader
   WHERE        WOType IN ('M','R')
                and CpnyID = @CpnyID
                and ProcStage LIKE @ProcStage
                and WONbr LIKE @WONbr
				and Status <> 'H'
   ORDER BY     WONbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOHeader_Mfg_PS_CpnyID] TO [MSDSL]
    AS [dbo];

