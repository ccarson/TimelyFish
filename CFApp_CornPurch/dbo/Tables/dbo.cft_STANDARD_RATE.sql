CREATE TABLE [dbo].[cft_STANDARD_RATE] (
    [CommissionRateID]     INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [CommissionRateTypeID] INT          NOT NULL,
    [FeedMillID]           CHAR (10)    NOT NULL,
    [EffectiveDateFrom]    DATETIME     NOT NULL,
    [EffectiveDateTo]      DATETIME     NULL,
    [Active]               BIT          NOT NULL,
    [CreatedDateTime]      DATETIME     CONSTRAINT [DF_cft_COMMISSION_RATE_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]            VARCHAR (50) NOT NULL,
    [UpdatedDateTime]      DATETIME     NULL,
    [UpdatedBy]            VARCHAR (50) NULL,
    [PromotionID]          INT          NULL,
    CONSTRAINT [PK_cft_COMMISSION_RATE] PRIMARY KEY CLUSTERED ([CommissionRateID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_cft_STANDARD_RATE_cft_COMMISSION_RATE_TYPE] FOREIGN KEY ([CommissionRateTypeID]) REFERENCES [dbo].[cft_COMMISSION_RATE_TYPE] ([CommissionRateTypeID]),
    CONSTRAINT [FK_cft_STANDARD_RATE_cft_FEED_MILL] FOREIGN KEY ([FeedMillID]) REFERENCES [dbo].[cft_FEED_MILL] ([FeedMillID]),
    CONSTRAINT [FK_cft_STANDARD_RATE_cft_PROMOTION_RATE] FOREIGN KEY ([PromotionID]) REFERENCES [dbo].[cft_PROMOTION_RATE] ([PromotionID])
);

