CREATE TABLE [dbo].[cft_PACKER_CONTRACT] (
    [ContractID]               INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ContactID]                INT              NOT NULL,
    [ContractFromDate]         DATETIME         NULL,
    [ContractToDate]           DATETIME         NULL,
    [Inactive]                 BIT              NULL,
    [PriceAllowance]           DECIMAL (10, 4)  NULL,
    [CutOutOverage]            DECIMAL (10, 4)  NULL,
    [LeanFormulaXValue]        DECIMAL (12, 10) NULL,
    [LeanFormulaX2Value]       DECIMAL (12, 10) NULL,
    [LeanFormulaX3Value]       DECIMAL (12, 10) NULL,
    [LeanFormulaConstantValue] DECIMAL (12, 10) NULL,
    [CreatedDateTime]          DATETIME         CONSTRAINT [DF_cft_PACKER_CONTRACT_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]                VARCHAR (50)     NOT NULL,
    [UpdatedDateTime]          DATETIME         NULL,
    [UpdatedBy]                VARCHAR (50)     NULL,
    CONSTRAINT [PK_PACKER_CONTRACT] PRIMARY KEY CLUSTERED ([ContractID] ASC) WITH (FILLFACTOR = 90)
);

