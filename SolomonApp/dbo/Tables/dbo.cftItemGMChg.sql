CREATE TABLE [dbo].[cftItemGMChg] (
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [GMChg]         FLOAT (53)    NOT NULL,
    [InvtID]        CHAR (30)     NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [MillID]        CHAR (6)      NOT NULL,
    [tstamp]        ROWVERSION    NULL,
    CONSTRAINT [cftItemGMChg0] PRIMARY KEY CLUSTERED ([InvtID] ASC, [MillID] ASC) WITH (FILLFACTOR = 90)
);

