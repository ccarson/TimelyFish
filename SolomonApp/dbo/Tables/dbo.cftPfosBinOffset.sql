CREATE TABLE [dbo].[cftPfosBinOffset] (
    [ContactName]   CHAR (50)     NULL,
    [crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [crtd_User]     CHAR (20)     NOT NULL,
    [EmptyBinNbr]   CHAR (10)     NOT NULL,
    [EndInventory]  FLOAT (53)    NOT NULL,
    [Event_DT]      SMALLDATETIME NOT NULL,
    [IDBinOffset]   INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NULL,
    [Lupd_Prog]     CHAR (8)      NULL,
    [Lupd_User]     CHAR (20)     NULL,
    [newInventory]  FLOAT (53)    NULL,
    [NextBinNbr]    CHAR (10)     NOT NULL,
    [Offset]        FLOAT (53)    NULL,
    [PigGroupID]    CHAR (10)     NOT NULL,
    [Statusflg]     CHAR (1)      NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [cftPfosBinOffset0] PRIMARY KEY CLUSTERED ([IDBinOffset] ASC) WITH (FILLFACTOR = 100)
);

