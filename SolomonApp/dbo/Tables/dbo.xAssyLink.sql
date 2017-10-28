CREATE TABLE [dbo].[xAssyLink] (
    [AsyNbr]        CHAR (10)     NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [CtrctNbr]      CHAR (10)     NOT NULL,
    [KeyFld]        CHAR (10)     NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [PayDate]       SMALLDATETIME NOT NULL,
    [PayDateAct]    SMALLDATETIME NOT NULL,
    [RefNbr]        CHAR (10)     NOT NULL,
    [User1]         CHAR (30)     NOT NULL,
    [User2]         CHAR (10)     NOT NULL,
    [User3]         FLOAT (53)    NOT NULL,
    [User4]         SMALLDATETIME NOT NULL,
    [VendId]        CHAR (15)     NOT NULL,
    [VPct]          FLOAT (53)    NOT NULL,
    [tstamp]        ROWVERSION    NULL,
    CONSTRAINT [xAssyLink0] PRIMARY KEY CLUSTERED ([AsyNbr] ASC, [KeyFld] ASC, [VendId] ASC) WITH (FILLFACTOR = 90)
);

