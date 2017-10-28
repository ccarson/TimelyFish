
CREATE VIEW dbo.cfv_SITE_FEED_REPRESENTATIVE
AS

SELECT
	sfr.SiteContactID
,	sfr.SolomonAppSiteContactID
,	sfr.FeedRepresentativeContactID
,	sfr.SolomonAppFeedRepresentativeContactID
,	SiteContact.ContactName SiteName
,	RepContact.ContactName FeedRepresentativeName
FROM [$(SolomonApp)].dbo.cft_SITE_FEED_REPRESENTATIVE sfr (NOLOCK)
LEFT JOIN [$(CentralData)].dbo.Contact SiteContact (NOLOCK)
	ON SiteContact.ContactID = sfr.SiteContactID
LEFT JOIN [$(CentralData)].dbo.Contact RepContact (NOLOCK)
	ON RepContact.ContactID = sfr.FeedRepresentativeContactID