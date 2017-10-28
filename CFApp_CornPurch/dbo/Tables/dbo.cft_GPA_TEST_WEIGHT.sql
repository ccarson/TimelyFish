CREATE TABLE [dbo].[cft_GPA_TEST_WEIGHT] (
    [GPATestWeightID]   INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [FeedMillID]        CHAR (10)    NOT NULL,
    [EffectiveDateFrom] DATETIME     NOT NULL,
    [EffectiveDateTo]   DATETIME     NULL,
    [Default]           BIT          NOT NULL,
    [Active]            BIT          NOT NULL,
    [CreatedDateTime]   DATETIME     CONSTRAINT [DF_cft_GPA_TEST_WEIGHT_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]         VARCHAR (50) NOT NULL,
    [UpdatedDateTime]   DATETIME     NULL,
    [UpdatedBy]         VARCHAR (50) NULL,
    CONSTRAINT [PK_cft_GPA_TEST_WEIGHT] PRIMARY KEY CLUSTERED ([GPATestWeightID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_cft_GPA_TEST_WEIGHT_cft_FEED_MILL] FOREIGN KEY ([FeedMillID]) REFERENCES [dbo].[cft_FEED_MILL] ([FeedMillID])
);

