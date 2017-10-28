CREATE TABLE [dbo].[xTstWgtDisc] (
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [KeyFld]        CHAR (5)      NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [TWDisc]        FLOAT (53)    NOT NULL,
    [TWKey]         CHAR (2)      NOT NULL,
    [User1]         CHAR (30)     NOT NULL,
    [User2]         CHAR (10)     NOT NULL,
    [User3]         FLOAT (53)    NOT NULL,
    [User4]         SMALLDATETIME NOT NULL,
    [Wgt]           FLOAT (53)    NOT NULL,
    [tstamp]        ROWVERSION    NULL,
    CONSTRAINT [xTstWgtDisc0] PRIMARY KEY CLUSTERED ([TWKey] ASC, [KeyFld] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [xTstWgtDisc1]
    ON [dbo].[xTstWgtDisc]([TWKey] ASC, [Wgt] ASC) WITH (FILLFACTOR = 90);

