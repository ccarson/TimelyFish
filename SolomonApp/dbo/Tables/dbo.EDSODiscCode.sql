CREATE TABLE [dbo].[EDSODiscCode] (
    [Code]          CHAR (15)     NOT NULL,
    [CpnyID]        CHAR (10)     NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [Description]   CHAR (30)     NOT NULL,
    [DiscountID]    CHAR (1)      NOT NULL,
    [LUpd_DateTime] SMALLDATETIME NOT NULL,
    [LUpd_Prog]     CHAR (8)      NOT NULL,
    [LUpd_User]     CHAR (10)     NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [EDSODiscCode0] PRIMARY KEY CLUSTERED ([CpnyID] ASC, [DiscountID] ASC) WITH (FILLFACTOR = 90)
);

