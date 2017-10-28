CREATE TABLE [dbo].[SowBreeder] (
    [BreederID]   VARCHAR (3)  NOT NULL,
    [BreederName] VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_SowBreeder] PRIMARY KEY CLUSTERED ([BreederID] ASC) WITH (FILLFACTOR = 90)
);

