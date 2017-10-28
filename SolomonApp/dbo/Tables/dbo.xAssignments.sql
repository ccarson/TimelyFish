CREATE TABLE [dbo].[xAssignments] (
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [CtrctNbr]      CHAR (10)     NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [PayPct]        FLOAT (53)    NOT NULL,
    [User1]         CHAR (30)     NOT NULL,
    [User2]         CHAR (10)     NOT NULL,
    [User3]         FLOAT (53)    NOT NULL,
    [User4]         SMALLDATETIME NOT NULL,
    [VendId]        CHAR (15)     NOT NULL,
    [tstamp]        ROWVERSION    NULL,
    CONSTRAINT [xAssignments0] PRIMARY KEY CLUSTERED ([CtrctNbr] ASC, [VendId] ASC) WITH (FILLFACTOR = 90)
);

