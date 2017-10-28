CREATE TABLE [dbo].[cft_FEED_MILL_ROAD_RESTRICTIONS] (
    [FeedMillID]       CHAR (10)    NOT NULL,
    [RoadRestrictions] BIT          NOT NULL,
    [UpdatedBy]        VARCHAR (50) NULL,
    [UpdatedDateTime]  DATETIME     NULL,
    CONSTRAINT [PK_cft_FEED_MILL_ROAD_RESTRICTIONS] PRIMARY KEY CLUSTERED ([FeedMillID] ASC) WITH (FILLFACTOR = 90)
);

