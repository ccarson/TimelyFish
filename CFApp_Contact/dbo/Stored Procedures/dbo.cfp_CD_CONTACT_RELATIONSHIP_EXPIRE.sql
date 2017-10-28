
-- ==================================================================
-- Author:		Doran Dahle
-- Create date: 06/24/2015
-- Description:	CENTRAL DATA - Expires a Contact Relationship 
-- ==================================================================
Create PROCEDURE [dbo].[cfp_CD_CONTACT_RELATIONSHIP_EXPIRE]
(
	@ChildContactID		int,
	@RelationshipID		int,
	@UpdatedBy			varchar(50)
)
AS
BEGIN
	SET NOCOUNT ON;

UPDATE [$(CentralData)].[dbo].[cftRelationshipAssignment]
   SET 
       [Lupd_dateTime] = getdate()
      ,[Lupd_User] = @UpdatedBy
      ,[EndDate] = getdate()
 WHERE [ChildContactID] = @ChildContactID AND
       [cftRelationshipID] = @RelationshipID

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CD_CONTACT_RELATIONSHIP_EXPIRE] TO [db_sp_exec]
    AS [dbo];

