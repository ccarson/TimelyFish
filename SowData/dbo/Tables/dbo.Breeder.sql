CREATE TABLE [dbo].[Breeder] (
    [BreederID] VARCHAR (5)  NOT NULL,
    [Name]      VARCHAR (30) NULL,
    [PCSynonym] VARCHAR (3)  NULL,
    CONSTRAINT [PK_Breeder] PRIMARY KEY CLUSTERED ([BreederID] ASC) WITH (FILLFACTOR = 90)
);

