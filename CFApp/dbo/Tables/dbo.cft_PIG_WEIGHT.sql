CREATE TABLE [dbo].[cft_PIG_WEIGHT] (
    [PigWeightID]     INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [LowWeight]       INT          NOT NULL,
    [HighWeight]      INT          NOT NULL,
    [CreatedDateTime] DATETIME     CONSTRAINT [DF_cft_PIG_WEIGHT_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]       VARCHAR (50) NOT NULL,
    [UpdatedDateTime] DATETIME     NULL,
    [UpdatedBy]       VARCHAR (50) NULL,
    CONSTRAINT [PK_PIG_WEIGHT] PRIMARY KEY CLUSTERED ([PigWeightID] ASC) WITH (FILLFACTOR = 90)
);

