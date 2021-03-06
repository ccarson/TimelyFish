﻿CREATE TABLE [dbo].[cftPigSaleBatch] (
    [AmtBaseSale]     FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [AmtCheck]        FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [AmtDefer]        FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [AmtGradePrem]    FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [AmtInsect]       FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [AmtInsur]        FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [AmtNPPC]         FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [AmtOther]        FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [AmtScale]        FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [AmtSortLoss]     FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [AmtTruck]        FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [AmtTruckAllow]   FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [BasePrice]       FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [ChkPaidNbr]      CHAR (10)     NULL,
    [ClassCode]       CHAR (3)      NULL,
    [Crtd_DateTime]   SMALLDATETIME DEFAULT (getdate()) NULL,
    [Crtd_Prog]       CHAR (8)      NULL,
    [Crtd_User]       CHAR (10)     DEFAULT (left(suser_sname(),(10))) NULL,
    [DefectHead1]     SMALLINT      NULL,
    [DefectHead2]     SMALLINT      NULL,
    [DefectHead3]     SMALLINT      NULL,
    [DefectHead4]     SMALLINT      NULL,
    [DefectHead5]     SMALLINT      NULL,
    [DefectReason1]   CHAR (30)     NULL,
    [DefectReason2]   CHAR (30)     NULL,
    [DefectReason3]   CHAR (30)     NULL,
    [DefectReason4]   CHAR (30)     NULL,
    [DefectReason5]   CHAR (30)     NULL,
    [DelvCarcWgt]     FLOAT (53)    NULL,
    [DelvLiveWgt]     FLOAT (53)    NULL,
    [DepositDate]     SMALLDATETIME NULL,
    [HeadCondemned]   SMALLINT      NULL,
    [HeadCount]       SMALLINT      NULL,
    [HeadDIY]         SMALLINT      NULL,
    [HeadDOA]         SMALLINT      NULL,
    [HeadEuth]        SMALLINT      NULL,
    [HeadPaid]        SMALLINT      NULL,
    [HeadReceived]    SMALLINT      NULL,
    [KillDate]        SMALLDATETIME NULL,
    [Lupd_DateTime]   SMALLDATETIME NULL,
    [Lupd_Prog]       CHAR (8)      NULL,
    [Lupd_User]       CHAR (10)     NULL,
    [PigGroupID]      CHAR (10)     NULL,
    [PigSaleID]       INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [PMLoadID]        CHAR (6)      NULL,
    [Processed]       SMALLINT      DEFAULT ((0)) NOT NULL,
    [SaleDate]        SMALLDATETIME NULL,
    [SalesBasis]      CHAR (2)      NULL,
    [SaleTypeID]      CHAR (2)      NULL,
    [SiteContactID]   CHAR (6)      NULL,
    [SiteID]          CHAR (4)      NULL,
    [SummaryFileName] CHAR (30)     NULL,
    [TattooNbr]       CHAR (6)      NULL,
    [tstamp]          ROWVERSION    NULL,
    CONSTRAINT [cftPigSaleBatch0] PRIMARY KEY CLUSTERED ([PigSaleID] ASC) WITH (FILLFACTOR = 90)
);

