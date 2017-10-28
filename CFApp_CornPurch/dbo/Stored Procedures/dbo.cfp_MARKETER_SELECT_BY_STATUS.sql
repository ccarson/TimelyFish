-- ===================================================================
-- Author:		Brian Cesafsky
-- Create date: 06/10/2008
-- Description:	Returns all marketers by status (active or inactive)
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_MARKETER_SELECT_BY_STATUS]
(
	@Active		bit
)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT MarketerID
		,FirstName
		,MiddleInitial
		,LastName
		,EmployeeID
		,MarketerStatusID
		,isnull (FirstName + ' ' + isnull (MiddleInitial,'') + ' ' + isnull (LastName,''),'') as Name	
	FROM dbo.cft_MARKETER (NOLOCK)
	WHERE MarketerStatusID = 1
	--WHERE Active = @Active
	ORDER BY Name
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_MARKETER_SELECT_BY_STATUS] TO [db_sp_exec]
    AS [dbo];

