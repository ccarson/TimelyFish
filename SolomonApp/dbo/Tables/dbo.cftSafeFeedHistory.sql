CREATE TABLE [dbo].[cftSafeFeedHistory] (
    [cftSafeFeedHistoryID] INT       IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [BinInv]               SMALLINT  NOT NULL,
    [BinNbr]               CHAR (6)  NOT NULL,
    [CallDate]             CHAR (8)  NOT NULL,
    [CallTime]             CHAR (5)  NOT NULL,
    [Company]              CHAR (2)  NOT NULL,
    [Crtd_DateTime]        DATETIME  CONSTRAINT [DF_cftSafeFeedHistory_Crtd_DateTime] DEFAULT (getdate()) NOT NULL,
    [DateReq]              CHAR (8)  NOT NULL,
    [Manager]              CHAR (10) NOT NULL,
    [OrdType]              CHAR (2)  NULL,
    [Phase]                SMALLINT  NOT NULL,
    [PigGroupID]           CHAR (10) NOT NULL,
    [QtyOrd]               INT       NOT NULL,
    [SDRefNo]              CHAR (6)  NOT NULL,
    [SiteID]               CHAR (4)  NOT NULL,
    [SiteRoom]             CHAR (10) NOT NULL,
    [Statusflg]            CHAR (1)  NOT NULL,
    [SysDate]              CHAR (8)  NOT NULL,
    CONSTRAINT [cftSafeFeedHistory0] PRIMARY KEY CLUSTERED ([cftSafeFeedHistoryID] ASC) WITH (FILLFACTOR = 90)
);

