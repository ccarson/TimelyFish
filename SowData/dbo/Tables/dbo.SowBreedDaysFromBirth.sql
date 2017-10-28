CREATE TABLE [dbo].[SowBreedDaysFromBirth] (
    [EffectiveDate] SMALLDATETIME NOT NULL,
    [NbrDays]       INT           NOT NULL,
    CONSTRAINT [PK_SowBreedDaysFromBirth] PRIMARY KEY CLUSTERED ([EffectiveDate] ASC) WITH (FILLFACTOR = 90)
);

