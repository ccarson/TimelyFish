-- =============================================
-- Author:		Dave Killion
-- Create date: 10/29/2007
-- Description:	Returns a list of truckers
-- =============================================
CREATE PROCEDURE dbo.cfp_TRANSPORTATION_TRUCKER_SELECT
	-- Add the parameters for the stored procedure here
	@RoleTypeID1 int
	,@RoleTypeID2 int
	,@RoleTypeID3 int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
Select
	c.ContactName
	,c.ContactID

from [$(SolomonApp)].dbo.cftContact c (nolock)
JOIN	[$(SolomonApp)].dbo.vXT100Contact v (nolock) on c.ContactID=v.ContactID
where  (v.RoleTypeID in (@RoleTypeID1,@RoleTypeID2,@RoleTYpeID3)) 

order by c.ContactName
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_TRANSPORTATION_TRUCKER_SELECT] TO [db_sp_exec]
    AS [dbo];

