CREATE TABLE [dbo].[cft_PACKER_FIXED_COST] (
    [FixedCostID]     INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ContactID]       INT             NOT NULL,
    [FromEffectDate]  DATETIME        CONSTRAINT [DF_cft_PACKER_FIXED_COST_FromEffectDate] DEFAULT (convert(varchar,getdate(),101)) NULL,
    [ToEffectDate]    DATETIME        CONSTRAINT [DF_cft_PACKER_FIXED_COST_ToEffectDate] DEFAULT ('1/1/3000') NULL,
    [PigWeightID]     INT             NOT NULL,
    [FixedCost]       DECIMAL (10, 4) NOT NULL,
    [CreatedDateTime] DATETIME        CONSTRAINT [DF_cft_PACKER_FIXED_COST_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]       VARCHAR (50)    NOT NULL,
    [UpdatedDateTime] DATETIME        NULL,
    [UpdatedBy]       VARCHAR (50)    NULL,
    CONSTRAINT [PK_PACKER_FIXED_COST] PRIMARY KEY CLUSTERED ([FixedCostID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_cft_PACKER_FIXED_COST_cft_PIG_WEIGHT] FOREIGN KEY ([PigWeightID]) REFERENCES [dbo].[cft_PIG_WEIGHT] ([PigWeightID]),
    CONSTRAINT [IX_cft_PACKER_FIXED_COST_Contact_ToEffect_Weight] UNIQUE NONCLUSTERED ([ContactID] ASC, [ToEffectDate] ASC, [PigWeightID] ASC) WITH (FILLFACTOR = 90)
);

