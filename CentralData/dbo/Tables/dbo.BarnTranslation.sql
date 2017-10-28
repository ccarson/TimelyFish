CREATE TABLE [dbo].[BarnTranslation] (
    [BarnNbr]         VARCHAR (6) NOT NULL,
    [BarnTranslation] VARCHAR (6) NULL,
    CONSTRAINT [PK_BarnTranslation] PRIMARY KEY CLUSTERED ([BarnNbr] ASC) WITH (FILLFACTOR = 90)
);

