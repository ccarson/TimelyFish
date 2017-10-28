CREATE TABLE [dbo].[cft_CONTACT_CELL_PHONE_PROVIDER] (
    [CarrierID]                 INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [CarrierName]               VARCHAR (50) NOT NULL,
    [CarrierTextMessageAddress] VARCHAR (50) NOT NULL,
    [CreatedDateTime]           DATETIME     CONSTRAINT [DF_cft_CONTACT_CELL_PHONE_PROVIDER_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]                 VARCHAR (50) NOT NULL,
    [UpdatedDateTime]           DATETIME     NULL,
    [UpdatedBy]                 VARCHAR (50) NULL,
    CONSTRAINT [PK_CONTACT_CELL_PHONE_PROVIDER] PRIMARY KEY CLUSTERED ([CarrierID] ASC) WITH (FILLFACTOR = 90)
);

