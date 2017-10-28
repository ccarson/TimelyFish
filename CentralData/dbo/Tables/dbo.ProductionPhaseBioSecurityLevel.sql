CREATE TABLE [dbo].[ProductionPhaseBioSecurityLevel] (
    [ProductionPhaseBioSecurityLevelID] INT           NOT NULL,
    [ProductionTypeProductionPhaseID]   INT           NULL,
    [Description]                       VARCHAR (100) NOT NULL,
    [Precedence]                        INT           NOT NULL,
    [EffectiveDate]                     SMALLDATETIME NOT NULL,
    CONSTRAINT [PK_ProductionPhaseBioSecurityLevel] PRIMARY KEY CLUSTERED ([ProductionPhaseBioSecurityLevelID] ASC, [EffectiveDate] ASC) WITH (FILLFACTOR = 90)
);

