﻿CREATE TABLE [dbo].[PO04740_WRK] (
    [AdditionalDemand]    FLOAT (53)    CONSTRAINT [DF_PO04740_WRK_AdditionalDemand] DEFAULT ((0)) NOT NULL,
    [CpnyID]              CHAR (10)     CONSTRAINT [DF_PO04740_WRK_CpnyID] DEFAULT (' ') NOT NULL,
    [Crtd_DateTime]       SMALLDATETIME CONSTRAINT [DF_PO04740_WRK_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [Crtd_Prog]           CHAR (8)      CONSTRAINT [DF_PO04740_WRK_Crtd_Prog] DEFAULT (' ') NOT NULL,
    [Crtd_User]           CHAR (10)     CONSTRAINT [DF_PO04740_WRK_Crtd_User] DEFAULT (' ') NOT NULL,
    [DailyAvgDemand]      FLOAT (53)    CONSTRAINT [DF_PO04740_WRK_DailyAvgDemand] DEFAULT ((0)) NOT NULL,
    [InvtDescr]           CHAR (60)     CONSTRAINT [DF_PO04740_WRK_InvtDescr] DEFAULT (' ') NOT NULL,
    [InvtID]              CHAR (30)     CONSTRAINT [DF_PO04740_WRK_InvtID] DEFAULT (' ') NOT NULL,
    [LeadTime]            FLOAT (53)    CONSTRAINT [DF_PO04740_WRK_LeadTime] DEFAULT ((0)) NOT NULL,
    [LUpd_DateTime]       SMALLDATETIME CONSTRAINT [DF_PO04740_WRK_LUpd_DateTime] DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_Prog]           CHAR (8)      CONSTRAINT [DF_PO04740_WRK_LUpd_Prog] DEFAULT (' ') NOT NULL,
    [LUpd_User]           CHAR (10)     CONSTRAINT [DF_PO04740_WRK_LUpd_User] DEFAULT (' ') NOT NULL,
    [NoteID]              INT           CONSTRAINT [DF_PO04740_WRK_NoteID] DEFAULT ((0)) NOT NULL,
    [OrderQty]            FLOAT (53)    CONSTRAINT [DF_PO04740_WRK_OrderQty] DEFAULT ((0)) NOT NULL,
    [OrderQtyValue]       FLOAT (53)    CONSTRAINT [DF_PO04740_WRK_OrderQtyValue] DEFAULT ((0)) NOT NULL,
    [PrimVendID]          CHAR (15)     CONSTRAINT [DF_PO04740_WRK_PrimVendID] DEFAULT (' ') NOT NULL,
    [PrimVendName]        CHAR (60)     CONSTRAINT [DF_PO04740_WRK_PrimVendName] DEFAULT (' ') NOT NULL,
    [QtyAvailAtLeadTime]  FLOAT (53)    CONSTRAINT [DF_PO04740_WRK_QtyAvailAtLeadTime] DEFAULT ((0)) NOT NULL,
    [QtyShort]            FLOAT (53)    CONSTRAINT [DF_PO04740_WRK_QtyShort] DEFAULT ((0)) NOT NULL,
    [ReorderPoint]        FLOAT (53)    CONSTRAINT [DF_PO04740_WRK_ReorderPoint] DEFAULT ((0)) NOT NULL,
    [RI_ID]               SMALLINT      CONSTRAINT [DF_PO04740_WRK_RI_ID] DEFAULT ((0)) NOT NULL,
    [S4Future01]          CHAR (30)     CONSTRAINT [DF_PO04740_WRK_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02]          CHAR (30)     CONSTRAINT [DF_PO04740_WRK_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03]          FLOAT (53)    CONSTRAINT [DF_PO04740_WRK_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04]          FLOAT (53)    CONSTRAINT [DF_PO04740_WRK_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05]          FLOAT (53)    CONSTRAINT [DF_PO04740_WRK_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06]          FLOAT (53)    CONSTRAINT [DF_PO04740_WRK_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07]          SMALLDATETIME CONSTRAINT [DF_PO04740_WRK_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]          SMALLDATETIME CONSTRAINT [DF_PO04740_WRK_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]          INT           CONSTRAINT [DF_PO04740_WRK_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10]          INT           CONSTRAINT [DF_PO04740_WRK_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11]          CHAR (10)     CONSTRAINT [DF_PO04740_WRK_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12]          CHAR (10)     CONSTRAINT [DF_PO04740_WRK_S4Future12] DEFAULT (' ') NOT NULL,
    [SafetyStk]           FLOAT (53)    CONSTRAINT [DF_PO04740_WRK_SafetyStk] DEFAULT ((0)) NOT NULL,
    [SiteID]              CHAR (10)     CONSTRAINT [DF_PO04740_WRK_SiteID] DEFAULT (' ') NOT NULL,
    [SuggestedOrderQty]   FLOAT (53)    CONSTRAINT [DF_PO04740_WRK_SuggestedOrderQty] DEFAULT ((0)) NOT NULL,
    [SuggestedOrderValue] FLOAT (53)    CONSTRAINT [DF_PO04740_WRK_SuggestedOrderValue] DEFAULT ((0)) NOT NULL,
    [UnitCost]            FLOAT (53)    CONSTRAINT [DF_PO04740_WRK_UnitCost] DEFAULT ((0)) NOT NULL,
    [User1]               CHAR (30)     CONSTRAINT [DF_PO04740_WRK_User1] DEFAULT (' ') NOT NULL,
    [User2]               CHAR (30)     CONSTRAINT [DF_PO04740_WRK_User2] DEFAULT (' ') NOT NULL,
    [User3]               FLOAT (53)    CONSTRAINT [DF_PO04740_WRK_User3] DEFAULT ((0)) NOT NULL,
    [User4]               FLOAT (53)    CONSTRAINT [DF_PO04740_WRK_User4] DEFAULT ((0)) NOT NULL,
    [User5]               CHAR (10)     CONSTRAINT [DF_PO04740_WRK_User5] DEFAULT (' ') NOT NULL,
    [User6]               CHAR (10)     CONSTRAINT [DF_PO04740_WRK_User6] DEFAULT (' ') NOT NULL,
    [User7]               SMALLDATETIME CONSTRAINT [DF_PO04740_WRK_User7] DEFAULT ('01/01/1900') NOT NULL,
    [User8]               SMALLDATETIME CONSTRAINT [DF_PO04740_WRK_User8] DEFAULT ('01/01/1900') NOT NULL,
    [tstamp]              ROWVERSION    NOT NULL,
    CONSTRAINT [PO04740_WRK0] PRIMARY KEY CLUSTERED ([RI_ID] ASC, [InvtID] ASC, [SiteID] ASC) WITH (FILLFACTOR = 90)
);
