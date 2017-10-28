CREATE TABLE [dbo].[xDamageDisc] (
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [DmgAdj]        FLOAT (53)    NOT NULL,
    [DmgDisc]       FLOAT (53)    NOT NULL,
    [DmgKey]        CHAR (2)      NOT NULL,
    [DmgPct]        FLOAT (53)    NOT NULL,
    [KeyFld]        CHAR (5)      NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [User1]         CHAR (30)     NOT NULL,
    [User2]         CHAR (10)     NOT NULL,
    [User3]         FLOAT (53)    NOT NULL,
    [User4]         SMALLDATETIME NOT NULL,
    [tstamp]        ROWVERSION    NULL,
    CONSTRAINT [xDamageDisc0] PRIMARY KEY CLUSTERED ([DmgKey] ASC, [KeyFld] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [xDamageDisc1]
    ON [dbo].[xDamageDisc]([DmgKey] ASC, [DmgPct] ASC) WITH (FILLFACTOR = 90);

