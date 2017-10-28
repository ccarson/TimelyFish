
-- ==================================================================
-- Author:		Doran Dahle
-- Create date: 06/03/2015
-- Description:	CENTRAL DATA - Inserts a Contact Relationship 
-- ==================================================================
CREATE PROCEDURE [dbo].[cfp_CD_CONTACT_RELATIONSHIP_INSERT]
(
	@ParentContactID	int,
	@ChildContactID		int,
	@RelationshipID		int,
	@CreatedBy			varchar(50)
)
AS
BEGIN
	SET NOCOUNT ON;

INSERT INTO [$(CentralData)].[dbo].[cftRelationshipAssignment]
           ([ParentContactID]
           ,[ChildContactID]
           ,[cftRelationshipID]
           ,[EffectiveDate]
           ,[Crtd_dateTime]
           ,[Crtd_User])
     VALUES
           (@ParentContactID
           ,@ChildContactID
           ,@RelationshipID
           ,getdate()
           ,getdate()
           ,@CreatedBy)

END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CD_CONTACT_RELATIONSHIP_INSERT] TO [db_sp_exec]
    AS [dbo];

