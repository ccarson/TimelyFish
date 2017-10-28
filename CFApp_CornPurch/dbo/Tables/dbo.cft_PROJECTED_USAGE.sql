CREATE TABLE [dbo].[cft_PROJECTED_USAGE] (
    [ProjectedUsageID] INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Year]             INT          NOT NULL,
    [Month]            INT          NOT NULL,
    [ProjectedUsage]   DECIMAL (10) NOT NULL,
    [FeedMillID]       CHAR (10)    NOT NULL,
    [CreatedDateTime]  DATETIME     CONSTRAINT [DF_cft_PROJECTED_USAGE_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]        VARCHAR (50) NOT NULL,
    [UpdatedDateTime]  DATETIME     NULL,
    [UpdatedBy]        VARCHAR (50) NULL,
    CONSTRAINT [PK_cft_PROJECTED_USAGE] PRIMARY KEY CLUSTERED ([ProjectedUsageID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_cft_PROJECTED_USAGE_cft_FEED_MILL] FOREIGN KEY ([FeedMillID]) REFERENCES [dbo].[cft_FEED_MILL] ([FeedMillID])
);

