CREATE TABLE [dbo].[ManureValueAgreement] (
    [ManureValueAgreementID] INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [OperatorContactID]      INT           NOT NULL,
    [SiteContactID]          INT           NOT NULL,
    [SiteID]                 VARCHAR (4)   NULL,
    [StartSeason]            INT           NOT NULL,
    [StartYear]              INT           NOT NULL,
    [ExpirationSeason]       INT           NOT NULL,
    [ExpirationYear]         INT           NOT NULL,
    [Comment]                VARCHAR (100) NULL,
    CONSTRAINT [PK_ManureValueAgreement] PRIMARY KEY CLUSTERED ([ManureValueAgreementID] ASC) WITH (FILLFACTOR = 90)
);

