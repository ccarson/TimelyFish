CREATE TABLE [dbo].[SiteBioSecurity] (
    [SiteBioSecurityID]                 INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [EffectiveDate]                     SMALLDATETIME NOT NULL,
    [ContactID]                         INT           NOT NULL,
    [ProductionPhaseBioSecurityLevelID] INT           NULL,
    CONSTRAINT [PK_SiteBioSecurity] PRIMARY KEY CLUSTERED ([SiteBioSecurityID] ASC, [EffectiveDate] ASC) WITH (FILLFACTOR = 90)
);

