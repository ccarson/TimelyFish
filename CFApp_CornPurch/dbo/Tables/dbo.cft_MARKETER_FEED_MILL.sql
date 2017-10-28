CREATE TABLE [dbo].[cft_MARKETER_FEED_MILL] (
    [MarketerFeedMillID] INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [MarketerID]         TINYINT      NOT NULL,
    [FeedMillID]         CHAR (10)    NOT NULL,
    [CreatedDateTime]    DATETIME     CONSTRAINT [DF_cft_MARKETER_FEED_MILL_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]          VARCHAR (50) NOT NULL,
    [UpdatedDateTime]    DATETIME     NULL,
    [UpdatedBy]          VARCHAR (50) NULL,
    CONSTRAINT [PK_cft_MARKETER_FEED_MILL] PRIMARY KEY CLUSTERED ([MarketerFeedMillID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_cft_MARKETER_FEED_MILL_cft_FEED_MILL] FOREIGN KEY ([FeedMillID]) REFERENCES [dbo].[cft_FEED_MILL] ([FeedMillID]),
    CONSTRAINT [FK_cft_MARKETER_FEED_MILL_cft_MARKETER] FOREIGN KEY ([MarketerID]) REFERENCES [dbo].[cft_MARKETER] ([MarketerID])
);

