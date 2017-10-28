CREATE TABLE [dbo].[cft_COMPETITOR] (
    [CompetitorID]    SMALLINT     IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Name]            VARCHAR (50) NOT NULL,
    [FeedMillID]      CHAR (10)    NOT NULL,
    [ShowOnReport]    BIT          NOT NULL,
    [Inactive]        BIT          NOT NULL,
    [CreatedDateTime] DATETIME     CONSTRAINT [DF_cft_COMPETITOR_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]       VARCHAR (50) NOT NULL,
    [UpdatedDateTime] DATETIME     NULL,
    [UpdatedBy]       VARCHAR (50) NULL,
    [Index]           BIT          NULL,
    [UseInAverage]    BIT          NULL,
    CONSTRAINT [PK_cft_COMPETITOR] PRIMARY KEY CLUSTERED ([CompetitorID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_cft_COMPETITOR_cft_FEED_MILL] FOREIGN KEY ([FeedMillID]) REFERENCES [dbo].[cft_FEED_MILL] ([FeedMillID])
);

