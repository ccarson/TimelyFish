CREATE TABLE [dbo].[xMoistureDisc] (
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [KeyFld]        CHAR (5)      NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [MstDisc]       FLOAT (53)    NOT NULL,
    [MstKey]        CHAR (2)      NOT NULL,
    [MstPct]        FLOAT (53)    NOT NULL,
    [User1]         CHAR (30)     NOT NULL,
    [User2]         CHAR (10)     NOT NULL,
    [User3]         FLOAT (53)    NOT NULL,
    [User4]         SMALLDATETIME NOT NULL,
    [tstamp]        ROWVERSION    NULL,
    CONSTRAINT [xMoistureDisc0] PRIMARY KEY CLUSTERED ([MstKey] ASC, [KeyFld] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [xMoistureDisc1]
    ON [dbo].[xMoistureDisc]([MstKey] ASC, [MstPct] ASC) WITH (FILLFACTOR = 90);

