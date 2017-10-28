CREATE TABLE [dbo].[cftTruckWash] (
    [Code]          CHAR (10)     NOT NULL,
    [ContactID]     CHAR (10)     NOT NULL,
    [CpnyID]        CHAR (10)     NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [MileageRate]   FLOAT (53)    NOT NULL,
    [StdLoadCharge] FLOAT (53)    NOT NULL,
    [Sub]           CHAR (24)     NOT NULL,
    [tstamp]        ROWVERSION    NULL,
    CONSTRAINT [cftTruckWash0] PRIMARY KEY CLUSTERED ([ContactID] ASC) WITH (FILLFACTOR = 90)
);

