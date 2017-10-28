CREATE TABLE [dbo].[EDMiscCharge] (
    [Code]          CHAR (10)     NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [Description]   CHAR (30)     NOT NULL,
    [LUpd_DateTime] SMALLDATETIME NOT NULL,
    [LUpd_Prog]     CHAR (8)      NOT NULL,
    [LUpd_User]     CHAR (10)     NOT NULL,
    [MiscChrgID]    CHAR (10)     NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [EDMiscCharge0] PRIMARY KEY CLUSTERED ([MiscChrgID] ASC, [Code] ASC) WITH (FILLFACTOR = 90)
);

