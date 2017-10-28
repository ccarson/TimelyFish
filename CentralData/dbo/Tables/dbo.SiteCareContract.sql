CREATE TABLE [dbo].[SiteCareContract] (
    [SiteCareContractID]  INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [SiteCareTypeID]      INT           NULL,
    [SiteContactID]       INT           NULL,
    [ContractorContactID] INT           NULL,
    [ContractAmount]      FLOAT (53)    NULL,
    [Equipment]           VARCHAR (200) NULL,
    [Notes]               VARCHAR (200) NULL,
    [EffectiveDate]       DATETIME      NULL,
    [StatusTypeID]        INT           CONSTRAINT [DF_SiteCareContract_StatusTypeID] DEFAULT (1) NOT NULL,
    CONSTRAINT [PK_SiteCareContract] PRIMARY KEY CLUSTERED ([SiteCareContractID] ASC) WITH (FILLFACTOR = 90)
);

