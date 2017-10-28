CREATE TABLE [dbo].[SummerSiteCareContract] (
    [SummerSiteCareContractID] INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [SiteContactID]            INT           NOT NULL,
    [ContractorContactID]      INT           NOT NULL,
    [ContractYear]             INT           NOT NULL,
    [ContractAmount]           FLOAT (53)    NULL,
    [Equipment]                VARCHAR (200) NULL,
    [Notes]                    VARCHAR (200) NULL,
    CONSTRAINT [PK_SummerSiteCare] PRIMARY KEY CLUSTERED ([SiteContactID] ASC, [ContractorContactID] ASC, [ContractYear] ASC) WITH (FILLFACTOR = 90)
);

