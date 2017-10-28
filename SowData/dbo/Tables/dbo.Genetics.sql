CREATE TABLE [dbo].[Genetics] (
    [GeneticLine]  VARCHAR (20) NOT NULL,
    [PCEquivalent] VARCHAR (20) NULL,
    CONSTRAINT [PK_Genetics] PRIMARY KEY CLUSTERED ([GeneticLine] ASC) WITH (FILLFACTOR = 90)
);

