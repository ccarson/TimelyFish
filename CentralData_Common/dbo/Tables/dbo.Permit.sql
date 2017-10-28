CREATE TABLE [dbo].[Permit] (
    [PermitID]               INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [PermitTypeID]           INT           NOT NULL,
    [PermitNbr]              VARCHAR (50)  NULL,
    [SiteContactID]          INT           NOT NULL,
    [AnimalUnits]            INT           NULL,
    [AnimalHead]             INT           NULL,
    [PrimaryStockingDensity] SMALLINT      CONSTRAINT [DF_Permit_PrimaryStockingDensity] DEFAULT (0) NULL,
    [IssueDate]              SMALLDATETIME NOT NULL,
    [ExpirationDate]         SMALLDATETIME NULL,
    [PermitLength]           INT           NULL,
    [PermitLengthUOM]        VARCHAR (50)  NULL,
    [RenewalLeadDays]        INT           NOT NULL,
    [Comment]                VARCHAR (50)  NULL,
    [OriginalIssueDate]      SMALLDATETIME NULL,
    CONSTRAINT [PK_Permit] PRIMARY KEY CLUSTERED ([PermitID] ASC) WITH (FILLFACTOR = 90)
);
