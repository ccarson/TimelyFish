CREATE TABLE [dbo].[Document] (
    [DocID]   CHAR (40)     NOT NULL,
    [DocType] CHAR (1)      NOT NULL,
    [User1]   CHAR (30)     NOT NULL,
    [User2]   CHAR (30)     NOT NULL,
    [User3]   FLOAT (53)    NOT NULL,
    [User4]   FLOAT (53)    NOT NULL,
    [User5]   CHAR (10)     NOT NULL,
    [User6]   CHAR (10)     NOT NULL,
    [User7]   SMALLDATETIME NOT NULL,
    [User8]   SMALLDATETIME NOT NULL,
    [DocText] TEXT          NOT NULL,
    [tstamp]  ROWVERSION    NOT NULL,
    CONSTRAINT [Document0] PRIMARY KEY CLUSTERED ([DocType] ASC, [DocID] ASC) WITH (FILLFACTOR = 90)
);

