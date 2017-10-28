CREATE TABLE [dbo].[cft_FEED_MILL_SITE_DIRECTIONS] (
    [SiteDirectionsID] INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ContactID]        INT            NOT NULL,
    [FeedMillID]       CHAR (10)      NOT NULL,
    [RoadRestrictions] BIT            NULL,
    [Active]           BIT            NULL,
    [Directions]       VARCHAR (4000) NULL,
    [CreatedBy]        VARCHAR (50)   NOT NULL,
    [CreatedDateTime]  DATETIME       NOT NULL,
    [UpdatedBy]        VARCHAR (50)   NULL,
    [UpdatedDateTime]  DATETIME       NULL,
    CONSTRAINT [PK_cft_FEED_MILL_SITE_DIRECTIONS] PRIMARY KEY CLUSTERED ([SiteDirectionsID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [IX_cft_FEED_MILL_SITE_DIRECTIONS_FeedMillID_ContactID]
    ON [dbo].[cft_FEED_MILL_SITE_DIRECTIONS]([FeedMillID] ASC, [ContactID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [IX_cft_FEED_MILL_SITE_DIRECTIONS_RoadRestrictions]
    ON [dbo].[cft_FEED_MILL_SITE_DIRECTIONS]([RoadRestrictions] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [IX_cft_FEED_MILL_SITE_DIRECTIONS_Active]
    ON [dbo].[cft_FEED_MILL_SITE_DIRECTIONS]([Active] ASC) WITH (FILLFACTOR = 90);

