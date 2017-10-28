CREATE TABLE [dbo].[cftInvtPayLean] (
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [InvtID]        CHAR (30)     CONSTRAINT [DF_cftInvPayLean_InvtID] DEFAULT (' ') NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [tstamp]        ROWVERSION    NULL,
    CONSTRAINT [cftInvtPayLean0] PRIMARY KEY CLUSTERED ([InvtID] ASC) WITH (FILLFACTOR = 90)
);

