﻿CREATE TABLE [dbo].[BCSetup] (
    [AllowBackOrders]    SMALLINT      CONSTRAINT [DF_BCSetup_AllowBackOrders] DEFAULT ((0)) NOT NULL,
    [AllowCreditMemos]   SMALLINT      CONSTRAINT [DF_BCSetup_AllowCreditMemos] DEFAULT ((0)) NOT NULL,
    [AllowDebitMemos]    SMALLINT      CONSTRAINT [DF_BCSetup_AllowDebitMemos] DEFAULT ((0)) NOT NULL,
    [AllowImport]        SMALLINT      CONSTRAINT [DF_BCSetup_AllowImport] DEFAULT ((0)) NOT NULL,
    [AllowReceipts]      SMALLINT      CONSTRAINT [DF_BCSetup_AllowReceipts] DEFAULT ((0)) NOT NULL,
    [BatchHandling]      SMALLINT      CONSTRAINT [DF_BCSetup_BatchHandling] DEFAULT ((0)) NOT NULL,
    [Crtd_DateTime]      SMALLDATETIME CONSTRAINT [DF_BCSetup_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [Crtd_Prog]          CHAR (8)      CONSTRAINT [DF_BCSetup_Crtd_Prog] DEFAULT (' ') NOT NULL,
    [Crtd_User]          CHAR (10)     CONSTRAINT [DF_BCSetup_Crtd_User] DEFAULT (' ') NOT NULL,
    [DefaultFreight]     SMALLINT      CONSTRAINT [DF_BCSetup_DefaultFreight] DEFAULT ((0)) NOT NULL,
    [DefaultQty]         FLOAT (53)    CONSTRAINT [DF_BCSetup_DefaultQty] DEFAULT ((0)) NOT NULL,
    [DefaultSite]        CHAR (6)      CONSTRAINT [DF_BCSetup_DefaultSite] DEFAULT (' ') NOT NULL,
    [DefaultWhseLoc]     SMALLINT      CONSTRAINT [DF_BCSetup_DefaultWhseLoc] DEFAULT ((0)) NOT NULL,
    [EnterUnitOfMeasure] SMALLINT      CONSTRAINT [DF_BCSetup_EnterUnitOfMeasure] DEFAULT ((0)) NOT NULL,
    [Errors]             SMALLINT      CONSTRAINT [DF_BCSetup_Errors] DEFAULT ((0)) NOT NULL,
    [Freight]            FLOAT (53)    CONSTRAINT [DF_BCSetup_Freight] DEFAULT ((0)) NOT NULL,
    [ImportMode]         SMALLINT      CONSTRAINT [DF_BCSetup_ImportMode] DEFAULT ((0)) NOT NULL,
    [LogInfo]            SMALLINT      CONSTRAINT [DF_BCSetup_LogInfo] DEFAULT ((0)) NOT NULL,
    [LUpd_DateTime]      SMALLDATETIME CONSTRAINT [DF_BCSetup_LUpd_DateTime] DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_Prog]          CHAR (8)      CONSTRAINT [DF_BCSetup_LUpd_Prog] DEFAULT (' ') NOT NULL,
    [LUpd_User]          CHAR (10)     CONSTRAINT [DF_BCSetup_LUpd_User] DEFAULT (' ') NOT NULL,
    [MoveFromSite]       CHAR (6)      CONSTRAINT [DF_BCSetup_MoveFromSite] DEFAULT (' ') NOT NULL,
    [MoveToSite]         CHAR (6)      CONSTRAINT [DF_BCSetup_MoveToSite] DEFAULT (' ') NOT NULL,
    [MultiSite]          SMALLINT      CONSTRAINT [DF_BCSetup_MultiSite] DEFAULT ((0)) NOT NULL,
    [PODefaultSite]      SMALLINT      CONSTRAINT [DF_BCSetup_PODefaultSite] DEFAULT ((0)) NOT NULL,
    [PreventAdds]        SMALLINT      CONSTRAINT [DF_BCSetup_PreventAdds] DEFAULT ((0)) NOT NULL,
    [RunAppl]            SMALLINT      CONSTRAINT [DF_BCSetup_RunAppl] DEFAULT ((0)) NOT NULL,
    [S4Future01]         CHAR (30)     CONSTRAINT [DF_BCSetup_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02]         CHAR (30)     CONSTRAINT [DF_BCSetup_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03]         FLOAT (53)    CONSTRAINT [DF_BCSetup_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04]         FLOAT (53)    CONSTRAINT [DF_BCSetup_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05]         FLOAT (53)    CONSTRAINT [DF_BCSetup_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06]         FLOAT (53)    CONSTRAINT [DF_BCSetup_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07]         SMALLDATETIME CONSTRAINT [DF_BCSetup_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]         SMALLDATETIME CONSTRAINT [DF_BCSetup_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]         INT           CONSTRAINT [DF_BCSetup_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10]         INT           CONSTRAINT [DF_BCSetup_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11]         CHAR (10)     CONSTRAINT [DF_BCSetup_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12]         CHAR (10)     CONSTRAINT [DF_BCSetup_S4Future12] DEFAULT (' ') NOT NULL,
    [ScanEach]           SMALLINT      CONSTRAINT [DF_BCSetup_ScanEach] DEFAULT ((0)) NOT NULL,
    [SetupID]            CHAR (1)      CONSTRAINT [DF_BCSetup_SetupID] DEFAULT (' ') NOT NULL,
    [SHAccumQtys]        SMALLINT      CONSTRAINT [DF_BCSetup_SHAccumQtys] DEFAULT ((0)) NOT NULL,
    [SHAllowBackOrds]    SMALLINT      CONSTRAINT [DF_BCSetup_SHAllowBackOrds] DEFAULT ((0)) NOT NULL,
    [SHAllowDebitMemos]  SMALLINT      CONSTRAINT [DF_BCSetup_SHAllowDebitMemos] DEFAULT ((0)) NOT NULL,
    [SHAllowOverShip]    SMALLINT      CONSTRAINT [DF_BCSetup_SHAllowOverShip] DEFAULT ((0)) NOT NULL,
    [SHAllowReturns]     SMALLINT      CONSTRAINT [DF_BCSetup_SHAllowReturns] DEFAULT ((0)) NOT NULL,
    [SHDefaultSite]      SMALLINT      CONSTRAINT [DF_BCSetup_SHDefaultSite] DEFAULT ((0)) NOT NULL,
    [SHPromptFreight]    SMALLINT      CONSTRAINT [DF_BCSetup_SHPromptFreight] DEFAULT ((0)) NOT NULL,
    [SHPromptMisc]       SMALLINT      CONSTRAINT [DF_BCSetup_SHPromptMisc] DEFAULT ((0)) NOT NULL,
    [SHPromptUofM]       SMALLINT      CONSTRAINT [DF_BCSetup_SHPromptUofM] DEFAULT ((0)) NOT NULL,
    [SHScanEach]         SMALLINT      CONSTRAINT [DF_BCSetup_SHScanEach] DEFAULT ((0)) NOT NULL,
    [SHSubs]             SMALLINT      CONSTRAINT [DF_BCSetup_SHSubs] DEFAULT ((0)) NOT NULL,
    [SHValidateItem]     SMALLINT      CONSTRAINT [DF_BCSetup_SHValidateItem] DEFAULT ((0)) NOT NULL,
    [UseDefaultQty]      SMALLINT      CONSTRAINT [DF_BCSetup_UseDefaultQty] DEFAULT ((0)) NOT NULL,
    [UseDefaultSite]     SMALLINT      CONSTRAINT [DF_BCSetup_UseDefaultSite] DEFAULT ((0)) NOT NULL,
    [User1]              CHAR (30)     CONSTRAINT [DF_BCSetup_User1] DEFAULT (' ') NOT NULL,
    [User2]              CHAR (30)     CONSTRAINT [DF_BCSetup_User2] DEFAULT (' ') NOT NULL,
    [User3]              FLOAT (53)    CONSTRAINT [DF_BCSetup_User3] DEFAULT ((0)) NOT NULL,
    [User4]              FLOAT (53)    CONSTRAINT [DF_BCSetup_User4] DEFAULT ((0)) NOT NULL,
    [User5]              CHAR (10)     CONSTRAINT [DF_BCSetup_User5] DEFAULT (' ') NOT NULL,
    [User6]              CHAR (10)     CONSTRAINT [DF_BCSetup_User6] DEFAULT (' ') NOT NULL,
    [User7]              SMALLDATETIME CONSTRAINT [DF_BCSetup_User7] DEFAULT ('01/01/1900') NOT NULL,
    [User8]              SMALLDATETIME CONSTRAINT [DF_BCSetup_User8] DEFAULT ('01/01/1900') NOT NULL,
    [UseReceiver]        SMALLINT      CONSTRAINT [DF_BCSetup_UseReceiver] DEFAULT ((0)) NOT NULL,
    [UseShipper]         SMALLINT      CONSTRAINT [DF_BCSetup_UseShipper] DEFAULT ((0)) NOT NULL,
    [ValidateItems]      SMALLINT      CONSTRAINT [DF_BCSetup_ValidateItems] DEFAULT ((0)) NOT NULL,
    [tstamp]             ROWVERSION    NOT NULL,
    CONSTRAINT [BCSetup0] PRIMARY KEY CLUSTERED ([SetupID] ASC) WITH (FILLFACTOR = 90)
);
