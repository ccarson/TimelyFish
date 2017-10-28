CREATE TABLE [dbo].[BioSecuritySystem] (
    [BioSecuritySystemID] INT           NOT NULL,
    [PigSystemID]         INT           NOT NULL,
    [EffectiveDate]       SMALLDATETIME NOT NULL,
    [BioSecurityID]       INT           NULL,
    CONSTRAINT [PK_BioSecuritySystem] PRIMARY KEY CLUSTERED ([BioSecuritySystemID] ASC, [EffectiveDate] ASC) WITH (FILLFACTOR = 90)
);

