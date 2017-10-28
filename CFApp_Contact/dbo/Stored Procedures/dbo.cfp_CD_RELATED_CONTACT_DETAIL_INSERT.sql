
-- ==============================================================================
-- Author:		DDahle
-- Create date: 09/08/2015
-- Description:	CENTRAL DATA - Inserts a related contact Detail record
-- ==============================================================================
CREATE PROCEDURE [dbo].[cfp_CD_RELATED_CONTACT_DETAIL_INSERT]
(	
	@RelatedContactDetailID int out
	 ,@RelatedContactID int
	,@RelatedContactRelationshipTypeID int
	,@Comments varchar(50)
	,@AccountNbr varchar(25)
)
AS
BEGIN
	SET NOCOUNT ON;

INSERT INTO [$(CentralData)].[dbo].[RelatedContactDetail]
           ([RelatedContactID]
           ,[RelatedContactRelationshipTypeID]
           ,[Comments]
           ,[AccountNbr])
     VALUES
           (@RelatedContactID
           ,@RelatedContactRelationshipTypeID
           ,@Comments
           ,@AccountNbr)
	set @RelatedContactDetailID = @@identity
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CD_RELATED_CONTACT_DETAIL_INSERT] TO [db_sp_exec]
    AS [dbo];

