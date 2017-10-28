CREATE TABLE [dbo].[cft_BARN_CONTRACT_TYPE] (
    [ContractTypeID]          INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ContractTypeDescription] VARCHAR (50) NULL,
    [CreatedDateTime]         DATETIME     CONSTRAINT [DF_cft_BARN_CONTRACT_TYPE_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]               VARCHAR (50) NOT NULL,
    [UpdatedDateTime]         DATETIME     NULL,
    [UpdatedBy]               VARCHAR (50) NULL,
    CONSTRAINT [PK_cft_BARN_CONTRACT_TYPE] PRIMARY KEY CLUSTERED ([ContractTypeID] ASC) WITH (FILLFACTOR = 90)
);

