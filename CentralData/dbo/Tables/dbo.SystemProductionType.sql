CREATE TABLE [dbo].[SystemProductionType] (
    [SystemProductionTypeID] INT           NOT NULL,
    [BioSecuritySystemID]    INT           NULL,
    [PigProductionTypeID]    INT           NOT NULL,
    [EffectiveDate]          SMALLDATETIME NOT NULL,
    CONSTRAINT [PK_SystemProductionType] PRIMARY KEY CLUSTERED ([SystemProductionTypeID] ASC, [EffectiveDate] ASC) WITH (FILLFACTOR = 90)
);

