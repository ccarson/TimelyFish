CREATE TABLE [dbo].[SitePigFlow] (
    [SitePigFlowID]     INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [EffectiveDate]     SMALLDATETIME NOT NULL,
    [ContactID]         INT           NOT NULL,
    [PigFlowID]         INT           NULL,
    [ProductionPhaseID] INT           NULL,
    [SiteOrderCode]     SMALLINT      NULL,
    CONSTRAINT [PK_SitePigFlow] PRIMARY KEY CLUSTERED ([SitePigFlowID] ASC) WITH (FILLFACTOR = 90)
);

