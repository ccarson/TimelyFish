CREATE TABLE [dbo].[cft_CONTRACT_TYPE] (
    [ContractTypeID]       TINYINT        IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Name]                 VARCHAR (50)   NOT NULL,
    [ContractTypeStatusID] TINYINT        NOT NULL,
    [Template]             IMAGE          NULL,
    [TemplateFields]       VARCHAR (2000) NULL,
    [TemplateFileName]     VARCHAR (256)  NULL,
    [PriceLater]           BIT            NOT NULL,
    [CreatedDateTime]      DATETIME       CONSTRAINT [DF_cft_CONTRACT_TYPE_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]            VARCHAR (50)   NOT NULL,
    [UpdatedDateTime]      DATETIME       NULL,
    [UpdatedBy]            VARCHAR (50)   NULL,
    [DeferredPayment]      BIT            NOT NULL,
    [CRM]                  BIT            CONSTRAINT [DF_cft_CONTRACT_TYPE_CRM] DEFAULT (0) NOT NULL,
    CONSTRAINT [PK_cft_CONTRACT_TYPE] PRIMARY KEY CLUSTERED ([ContractTypeID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_cft_CONTRACT_TYPE_cft_CONTRACT_TYPE_STATUS] FOREIGN KEY ([ContractTypeStatusID]) REFERENCES [dbo].[cft_CONTRACT_TYPE_STATUS] ([ContractTypeStatusID])
);

