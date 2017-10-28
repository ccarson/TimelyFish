-- =============================================
-- Author:		Brian Cesafsky
-- Create date: 07/01/2009
-- Description:	Returns all Facility Types
-- =============================================
CREATE PROCEDURE [dbo].[cfp_FACILITY_TYPE_SELECT]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT FacilityTypeID
	  ,FacilityTypeDescription
FROM dbo.cft_FACILITY_TYPE (NOLOCK)
Order By FacilityTypeDescription
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_FACILITY_TYPE_SELECT] TO [db_sp_exec]
    AS [dbo];

