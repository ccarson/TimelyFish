
-- ==============================================================================
-- Author:		Nick Honetschlager
-- Create date: 02/17/2016
-- Description:	Based on Brian Cesafsky's stored procedure by the same name in 
--				CentralData from 06/07/2010.
--				CENTRAL DATA - Returns contact information for a related contact
-- ==============================================================================
CREATE PROCEDURE [dbo].[cfp_CD_RELATED_CONTACT_SELECT_BY_RELATIONSHIP_TYPE]
(
	@ContactID								int
	,@RelatedContactRelationshipTypeID		int
)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT ContactSource.ContactName ContactName
		,ContactRelated.ContactName RelatedContactName
		,ContactRelated.EMailAddress RelatedEMailAddress
		,ContactRelated.TranSchedMethodTypeID RelatedTranSchedMethodTypeID
		,RelatedContact.ContactID
		,RelatedContact.RelatedID
		,RelatedContactDetail.RelatedContactRelationshipTypeID
		,RelatedContactDetail.Comments
	FROM CentralData.dbo.RelatedContact RelatedContact (NOLOCK)
	LEFT JOIN CentralData.dbo.RelatedContactDetail RelatedContactDetail (NOLOCK)
		ON RelatedContact.RelatedContactID = RelatedContactDetail.RelatedContactID
	LEFT JOIN CentralData.dbo.Contact ContactSource (NOLOCK) 
		ON ContactSource.contactid = RelatedContact.ContactID
	LEFT JOIN CentralData.dbo.Contact ContactRelated (NOLOCK) 
		ON ContactRelated.contactid = RelatedContact.RelatedID
	WHERE RelatedContactRelationshipTypeID = @RelatedContactRelationshipTypeID 
	AND RelatedContact.ContactID = @ContactID

END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[cfp_CD_RELATED_CONTACT_SELECT_BY_RELATIONSHIP_TYPE] TO [MSDSL]
    AS [dbo];

