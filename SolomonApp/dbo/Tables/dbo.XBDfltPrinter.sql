CREATE TABLE [dbo].[XBDfltPrinter] (
    [Acct]         VARCHAR (10)  NOT NULL,
    [CpnyID]       VARCHAR (10)  NOT NULL,
    [ComputerName] VARCHAR (25)  NOT NULL,
    [PrinterName]  VARCHAR (255) NOT NULL,
    [PrinterPort]  VARCHAR (255) NOT NULL,
    [SubAcct]      VARCHAR (24)  NOT NULL,
    [User1]        CHAR (40)     NOT NULL,
    [User2]        CHAR (40)     NOT NULL,
    [User3]        CHAR (15)     NOT NULL,
    [User4]        CHAR (10)     NOT NULL,
    [User5]        FLOAT (53)    NOT NULL,
    [User6]        FLOAT (53)    NOT NULL,
    [User7]        SMALLDATETIME NOT NULL,
    [User8]        SMALLDATETIME NOT NULL,
    [tstamp]       ROWVERSION    NOT NULL,
    CONSTRAINT [XBDfltPrinter0] PRIMARY KEY CLUSTERED ([CpnyID] ASC, [Acct] ASC, [SubAcct] ASC, [ComputerName] ASC) WITH (FILLFACTOR = 90)
);

