
CREATE Procedure [dbo].[pp_0876QP] @RI_ID SMALLINT

AS

--Quick Print AR Invoice pre-process. Used instead of 0976010.exe for quick printing to improve performance.

DECLARE @CpnyID varchar(10)
DECLARE @RI_WHERE varchar(1024)

Begin Tran 
Begin
	Select @CpnyID = RptRuntime.CpnyID, @RI_WHERE = RptRuntime.RI_WHERE from RptRuntime where RptRuntime.RI_ID = @RI_ID
	Exec ARPrtQueueCreate @RI_ID, @CpnyID, @RI_WHERE
	Update RptRuntime Set RI_WHERE = '{ARPrintQueue.RI_ID} = ' + Convert(varchar, @RI_ID) where RptRuntime.RI_ID = @RI_ID
End
Commit Tran

