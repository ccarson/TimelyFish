CREATE TABLE [dbo].[cft_SITE_FEED_REPRESENTATIVE] (
    [SiteContactID]                         INT NOT NULL,
    [FeedRepresentativeContactID]           INT NOT NULL,
    [SolomonAppSiteContactID]               AS  (CONVERT([varchar](6),replicate('0',(6)-len([SiteContactID]))+CONVERT([varchar],[SiteContactID],0),0)),
    [SolomonAppFeedRepresentativeContactID] AS  (CONVERT([varchar](6),replicate('0',(6)-len([FeedRepresentativeContactID]))+CONVERT([varchar],[FeedRepresentativeContactID],0),0)),
    CONSTRAINT [PK_cft_SITE_FEED_REPRESENTATIVE] PRIMARY KEY CLUSTERED ([SiteContactID] ASC, [FeedRepresentativeContactID] ASC) WITH (FILLFACTOR = 90)
);

