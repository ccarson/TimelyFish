-- =============================================
-- Author:		Matt Brandt
-- Create date: 10/11/2010
-- Description:	This function determines the Marketing Service Manager assigned to a site for a given date.
-- The function returns the Marketing Service Manager's ID as an INT
-- , SolomonApp's ContactID will also need to be CAST as an INT to lookup the name.
-- =============================================
CREATE FUNCTION dbo.cffn_GET_SITE_MARKETING_MANAGER 
(
	@SiteContactID Int
	, @EffectiveDate Smalldatetime 
)
Returns Int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @MarketingManagerID Int

	-- Add the T-SQL statements to compute the return value here
	SELECT @MarketingManagerID = 
	(Select Top 1 MktMgrContactID
	From [$(SolomonApp)].dbo.cftMktMgrAssign
	Where SiteContactID = @SiteContactID
		And @EffectiveDate >= EffectiveDate 
	Order By EffectiveDate Desc)

	-- Return the result of the function
	RETURN @MarketingManagerID

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cffn_GET_SITE_MARKETING_MANAGER] TO [db_sp_exec]
    AS [dbo];

