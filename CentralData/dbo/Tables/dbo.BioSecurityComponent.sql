CREATE TABLE [dbo].[BioSecurityComponent] (
    [ID]            INT           NOT NULL,
    [Description]   VARCHAR (50)  NOT NULL,
    [Precedence]    INT           NOT NULL,
    [EffectiveDate] SMALLDATETIME NOT NULL,
    [ComponentType] VARCHAR (20)  NOT NULL,
    CONSTRAINT [PK_PigSystem] PRIMARY KEY CLUSTERED ([ID] ASC, [EffectiveDate] ASC, [ComponentType] ASC) WITH (FILLFACTOR = 90)
);

