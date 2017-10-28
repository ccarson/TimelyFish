CREATE TABLE [dbo].[cft_PROMOTION_RATE] (
    [PromotionID]         INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [FeedMillID]          CHAR (10)    NOT NULL,
    [Active]              BIT          NOT NULL,
    [DateEstablishedFrom] DATETIME     NOT NULL,
    [DateEstablishedTo]   DATETIME     NOT NULL,
    [DeliveryDateFrom]    DATETIME     NOT NULL,
    [DeliveryDateTo]      DATETIME     NOT NULL,
    [CreatedDateTime]     DATETIME     CONSTRAINT [DF_cft_PROMOTION_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]           VARCHAR (50) NOT NULL,
    [UpdatedDateTime]     DATETIME     NULL,
    [UpdatedBy]           VARCHAR (50) NULL,
    CONSTRAINT [PK_cft_PROMOTION] PRIMARY KEY CLUSTERED ([PromotionID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_cft_PROMOTION_cft_FEED_MILL] FOREIGN KEY ([FeedMillID]) REFERENCES [dbo].[cft_FEED_MILL] ([FeedMillID])
);

