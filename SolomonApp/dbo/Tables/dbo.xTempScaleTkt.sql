CREATE TABLE [dbo].[xTempScaleTkt] (
    [NetWgt] FLOAT (53)    NOT NULL,
    [Status] CHAR (1)      NOT NULL,
    [TktNbr] CHAR (10)     NOT NULL,
    [VendId] CHAR (15)     NOT NULL,
    [WgtIn]  FLOAT (53)    NOT NULL,
    [WgtOut] FLOAT (53)    NOT NULL,
    [WIDate] SMALLDATETIME NOT NULL,
    [WODate] SMALLDATETIME NOT NULL,
    [tstamp] ROWVERSION    NULL,
    CONSTRAINT [xTempScaleTkt0] PRIMARY KEY CLUSTERED ([TktNbr] ASC) WITH (FILLFACTOR = 90)
);

