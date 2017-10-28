CREATE TABLE [dbo].[cft_PACKER_SORT_LOSS] (
    [SortLossID]      INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ContactID]       INT             NOT NULL,
    [FromEffectDate]  DATETIME        CONSTRAINT [DF_cft_PACKER_SORT_LOSS_FromEffectDate] DEFAULT (convert(varchar,getdate(),101)) NULL,
    [ToEffectDate]    DATETIME        CONSTRAINT [DF_cft_PACKER_SORT_LOSS_ToEffectDate] DEFAULT ('1/1/3000') NULL,
    [PigWeightID]     INT             NOT NULL,
    [SortLoss]        DECIMAL (10, 4) NOT NULL,
    [SortLossType]    VARCHAR (10)    NOT NULL,
    [CreatedDateTime] DATETIME        CONSTRAINT [DF_cft_PACKER_SORT_LOSS_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]       VARCHAR (50)    NOT NULL,
    [UpdatedDateTime] DATETIME        NULL,
    [UpdatedBy]       VARCHAR (50)    NULL,
    CONSTRAINT [PK_PACKER_SORT_LOSS] PRIMARY KEY CLUSTERED ([SortLossID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_cft_PACKER_SORT_LOSS_cft_PIG_WEIGHT] FOREIGN KEY ([PigWeightID]) REFERENCES [dbo].[cft_PIG_WEIGHT] ([PigWeightID]),
    CONSTRAINT [IX_cft_PACKER_SORT_LOSS_Contact_ToEffect_Weight] UNIQUE NONCLUSTERED ([ContactID] ASC, [ToEffectDate] ASC, [PigWeightID] ASC) WITH (FILLFACTOR = 90)
);

