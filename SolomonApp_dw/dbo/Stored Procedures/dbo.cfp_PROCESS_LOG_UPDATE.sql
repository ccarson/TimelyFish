CREATE PROCEDURE [dbo].[cfp_PROCESS_LOG_UPDATE]
(	@ProcessLogID bigint)
AS

update  dbo.cft_PROCESS_LOG
set ProcessEnd = getdate()
where ProcessLogID = @ProcessLogID
