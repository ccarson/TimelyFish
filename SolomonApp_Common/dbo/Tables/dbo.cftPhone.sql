CREATE TABLE [dbo].[cftPhone] (
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [Extension]     CHAR (10)     NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [PhoneID]       CHAR (6)      NOT NULL,
    [PhoneNbr]      CHAR (10)     NOT NULL,
    [SpeedDial]     CHAR (6)      NOT NULL,
    [tstamp]        ROWVERSION    NULL,
    CONSTRAINT [cftPhone0] PRIMARY KEY CLUSTERED ([PhoneID] ASC) WITH (FILLFACTOR = 90)
);

