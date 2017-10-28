CREATE TABLE [dbo].[cft_CONTRACT_MARKETER] (
    [ContractID]      INT            NOT NULL,
    [MarketerID]      TINYINT        NOT NULL,
    [CreatedDateTime] DATETIME       CONSTRAINT [DF_cft_CONTRACT_MARKETER_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]       VARCHAR (50)   NOT NULL,
    [UpdatedDateTime] DATETIME       NULL,
    [UpdatedBy]       VARCHAR (50)   NULL,
    [Value]           DECIMAL (5, 2) NOT NULL,
    CONSTRAINT [PK_cft_CONTRACT_MARKETER] PRIMARY KEY CLUSTERED ([ContractID] ASC, [MarketerID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_cft_CONTRACT_MARKETER_cft_CONTRACT] FOREIGN KEY ([ContractID]) REFERENCES [dbo].[cft_CONTRACT] ([ContractID]),
    CONSTRAINT [FK_cft_CONTRACT_MARKETER_cft_MARKETER] FOREIGN KEY ([MarketerID]) REFERENCES [dbo].[cft_MARKETER] ([MarketerID])
);

