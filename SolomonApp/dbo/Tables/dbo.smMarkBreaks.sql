CREATE TABLE [dbo].[smMarkBreaks] (
    [Crtd_DateTime]    SMALLDATETIME NOT NULL,
    [Crtd_Prog]        CHAR (8)      NOT NULL,
    [Crtd_User]        CHAR (10)     NOT NULL,
    [LineNbr]          SMALLINT      NOT NULL,
    [Lupd_DateTime]    SMALLDATETIME NOT NULL,
    [Lupd_Prog]        CHAR (8)      NOT NULL,
    [Lupd_User]        CHAR (10)     NOT NULL,
    [MarkupBreakFrom]  FLOAT (53)    NOT NULL,
    [MarkupBreakId]    CHAR (10)     NOT NULL,
    [MarkupBreakLimit] FLOAT (53)    NOT NULL,
    [MarkupBreakMult]  FLOAT (53)    NOT NULL,
    [User1]            CHAR (30)     NOT NULL,
    [User2]            CHAR (30)     NOT NULL,
    [User3]            FLOAT (53)    NOT NULL,
    [User4]            FLOAT (53)    NOT NULL,
    [User5]            CHAR (10)     NOT NULL,
    [User6]            CHAR (10)     NOT NULL,
    [User7]            SMALLDATETIME NOT NULL,
    [User8]            SMALLDATETIME NOT NULL,
    [tstamp]           ROWVERSION    NOT NULL,
    CONSTRAINT [smMarkBreaks0] PRIMARY KEY CLUSTERED ([MarkupBreakId] ASC, [LineNbr] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [smMarkBreaks1]
    ON [dbo].[smMarkBreaks]([MarkupBreakId] ASC, [MarkupBreakFrom] ASC, [LineNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smMarkBreaks2]
    ON [dbo].[smMarkBreaks]([MarkupBreakId] ASC, [MarkupBreakLimit] ASC) WITH (FILLFACTOR = 90);

