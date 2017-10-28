
-- ==============================================================================
-- Author:		DDahle
-- Create date: 09/08/2015
-- Description:	CENTRAL DATA - Inserts a related contact
-- ==============================================================================
CREATE PROCEDURE [dbo].[cfp_CD_RELATED_CONTACT_INSERT]
( 
	@RelatedContactID int OUT
	,@ContactID	int
	,@RelatedID int
	,@SummaryOfDetail varchar(200)
)
AS
BEGIN
	SET NOCOUNT ON;

INSERT INTO [$(CentralData)].[dbo].[RelatedContact]
           ([RelatedID]
           ,[ContactID]
           ,[SummaryOfDetail])
     VALUES
           (@RelatedID
           ,@ContactID
           ,@SummaryOfDetail)
	set @RelatedContactID = @@identity
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CD_RELATED_CONTACT_INSERT] TO [db_sp_exec]
    AS [dbo];

