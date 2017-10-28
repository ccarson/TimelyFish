CREATE TABLE [dbo].[xMarionPrices] (
    [Comptr]        CHAR (10)     NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [MPDate]        SMALLDATETIME NOT NULL,
    [Price]         FLOAT (53)    NOT NULL,
    [User1]         CHAR (30)     NOT NULL,
    [User2]         CHAR (10)     NOT NULL,
    [User3]         FLOAT (53)    NOT NULL,
    [User4]         SMALLDATETIME NOT NULL,
    [tstamp]        ROWVERSION    NULL,
    CONSTRAINT [xMarionPrices0] PRIMARY KEY CLUSTERED ([MPDate] ASC, [Comptr] ASC) WITH (FILLFACTOR = 90)
);

