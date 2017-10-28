CREATE TABLE [dbo].[ProductionTypeProductionPhase] (
    [ProductionTypeProductionPhaseID] INT           NOT NULL,
    [SystemProductionTypeID]          INT           NULL,
    [PigProductionPhaseID]            INT           NOT NULL,
    [EffectiveDate]                   SMALLDATETIME NOT NULL,
    CONSTRAINT [PK_ProductionTypeProductionPhase] PRIMARY KEY CLUSTERED ([ProductionTypeProductionPhaseID] ASC, [EffectiveDate] ASC) WITH (FILLFACTOR = 90)
);

