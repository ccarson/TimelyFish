CREATE TABLE [dbo].[cft_PIG_DISTRIBUTION] (
    [PigDistributionID]      INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [LiveWeight]             DECIMAL (10, 4) NOT NULL,
    [TopLoadMultiplier]      DECIMAL (10, 4) NULL,
    [CloseoutLoadMultiplier] DECIMAL (10, 4) NOT NULL,
    [CreatedDateTime]        DATETIME        CONSTRAINT [DF_cft_PIG_DISTRIBUTION_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]              VARCHAR (50)    NOT NULL,
    [UpdatedDateTime]        DATETIME        NULL,
    [UpdatedBy]              VARCHAR (50)    NULL,
    CONSTRAINT [PK_PIG_DISTRIBUTION] PRIMARY KEY CLUSTERED ([PigDistributionID] ASC) WITH (FILLFACTOR = 90)
);

