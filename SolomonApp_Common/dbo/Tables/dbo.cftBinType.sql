CREATE TABLE [dbo].[cftBinType] (
    [BinCapacity]    FLOAT (53)    NOT NULL,
    [BinTypeID]      CHAR (3)      NOT NULL,
    [ConeConversion] FLOAT (53)    NOT NULL,
    [Crtd_DateTime]  SMALLDATETIME NOT NULL,
    [Crtd_Prog]      CHAR (8)      NOT NULL,
    [Crtd_User]      CHAR (10)     NOT NULL,
    [Description]    CHAR (30)     NOT NULL,
    [Lupd_DateTime]  SMALLDATETIME NOT NULL,
    [Lupd_Prog]      CHAR (8)      NOT NULL,
    [Lupd_User]      CHAR (10)     NOT NULL,
    [RingConversion] FLOAT (53)    NOT NULL,
    [tstamp]         ROWVERSION    NOT NULL,
    CONSTRAINT [cftBinType0] PRIMARY KEY CLUSTERED ([BinTypeID] ASC) WITH (FILLFACTOR = 90)
);

