CREATE TABLE [dbo].[Customer] (
    [ContactID]      INT          NOT NULL,
    [CustomerNumber] VARCHAR (10) NOT NULL,
    CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED ([ContactID] ASC) WITH (FILLFACTOR = 90)
);

