-- ===========================================================================
-- Author:		Brian Cesafsky
-- Create date: 11/14/2008
-- Description:	CENTRAL DATA - Returns all phone information using the phone #
-- ===========================================================================
CREATE PROCEDURE [dbo].[cfp_CD_PHONE_SELECT_BY_PHONE_NUMBER]
(
	@PhoneNumber		varchar(10)
)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT PhoneID
		,PhoneNbr
		,Extension
		,SpeedDial
	FROM [$(CentralData)].dbo.Phone (NOLOCK)
	WHERE PhoneNbr = @PhoneNumber

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CD_PHONE_SELECT_BY_PHONE_NUMBER] TO [db_sp_exec]
    AS [dbo];

