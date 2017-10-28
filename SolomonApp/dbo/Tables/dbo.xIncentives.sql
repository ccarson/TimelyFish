CREATE TABLE [dbo].[xIncentives] (
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [GPDiff]        FLOAT (53)    NOT NULL,
    [GPInct]        FLOAT (53)    NOT NULL,
    [KeyFld]        CHAR (5)      NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [NPDiff]        FLOAT (53)    NOT NULL,
    [NPInct]        FLOAT (53)    NOT NULL,
    [User1]         CHAR (30)     NOT NULL,
    [User2]         CHAR (10)     NOT NULL,
    [User3]         FLOAT (53)    NOT NULL,
    [User4]         SMALLDATETIME NOT NULL,
    [tstamp]        ROWVERSION    NULL,
    CONSTRAINT [xIncentives0] PRIMARY KEY CLUSTERED ([KeyFld] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [xIncentives1]
    ON [dbo].[xIncentives]([GPDiff] ASC, [NPDiff] ASC) WITH (FILLFACTOR = 90);

