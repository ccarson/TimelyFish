-- =========================================================
-- Author:		Brian Cesafsky
-- Create date: 06/25/2008
-- Description:	Returns medications by type
-- =========================================================
CREATE PROCEDURE [dbo].[cfp_MEDICATION_BY_TYPE_SELECT]
(
	@MedicationTypeID		bit
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT MedicationID
		,MedicationTypeID
	    ,Name
		,Description
		,WaterMedication
FROM dbo.cft_MEDICATION (NOLOCK)
WHERE MedicationTypeID = @MedicationTypeID
Order By Name
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_MEDICATION_BY_TYPE_SELECT] TO [db_sp_exec]
    AS [dbo];

