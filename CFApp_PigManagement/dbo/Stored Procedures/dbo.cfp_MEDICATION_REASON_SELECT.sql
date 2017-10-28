-- =========================================================
-- Author:		Brian Cesafsky
-- Create date: 06/25/2008
-- Description:	Returns medication reasons
-- =========================================================
CREATE PROCEDURE [dbo].[cfp_MEDICATION_REASON_SELECT]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT MedicationReasonID
		,MedicationReason
FROM dbo.cft_MEDICATION_REASON (NOLOCK)
Order By MedicationReason
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_MEDICATION_REASON_SELECT] TO [db_sp_exec]
    AS [dbo];

