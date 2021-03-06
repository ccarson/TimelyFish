﻿CREATE TABLE [dbo].[POSetup] (
    [AddAlternateID]     CHAR (1)      CONSTRAINT [DF_POSetup_AddAlternateID] DEFAULT (' ') NOT NULL,
    [AdminLeadTime]      SMALLINT      CONSTRAINT [DF_POSetup_AdminLeadTime] DEFAULT ((0)) NOT NULL,
    [APAccrAcct]         CHAR (10)     CONSTRAINT [DF_POSetup_APAccrAcct] DEFAULT (' ') NOT NULL,
    [APAccrSub]          CHAR (24)     CONSTRAINT [DF_POSetup_APAccrSub] DEFAULT (' ') NOT NULL,
    [AutoRef]            SMALLINT      CONSTRAINT [DF_POSetup_AutoRef] DEFAULT ((0)) NOT NULL,
    [BillAddr1]          CHAR (60)     CONSTRAINT [DF_POSetup_BillAddr1] DEFAULT (' ') NOT NULL,
    [BillAddr2]          CHAR (60)     CONSTRAINT [DF_POSetup_BillAddr2] DEFAULT (' ') NOT NULL,
    [BillAttn]           CHAR (30)     CONSTRAINT [DF_POSetup_BillAttn] DEFAULT (' ') NOT NULL,
    [BillCity]           CHAR (30)     CONSTRAINT [DF_POSetup_BillCity] DEFAULT (' ') NOT NULL,
    [BillCountry]        CHAR (3)      CONSTRAINT [DF_POSetup_BillCountry] DEFAULT (' ') NOT NULL,
    [BillEmail]          CHAR (80)     CONSTRAINT [DF_POSetup_BillEmail] DEFAULT (' ') NOT NULL,
    [BillFax]            CHAR (30)     CONSTRAINT [DF_POSetup_BillFax] DEFAULT (' ') NOT NULL,
    [BillName]           CHAR (60)     CONSTRAINT [DF_POSetup_BillName] DEFAULT (' ') NOT NULL,
    [BillPhone]          CHAR (30)     CONSTRAINT [DF_POSetup_BillPhone] DEFAULT (' ') NOT NULL,
    [BillState]          CHAR (3)      CONSTRAINT [DF_POSetup_BillState] DEFAULT (' ') NOT NULL,
    [BillZip]            CHAR (10)     CONSTRAINT [DF_POSetup_BillZip] DEFAULT (' ') NOT NULL,
    [CreateAD]           SMALLINT      CONSTRAINT [DF_POSetup_CreateAD] DEFAULT ((0)) NOT NULL,
    [Crtd_DateTime]      SMALLDATETIME CONSTRAINT [DF_POSetup_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [Crtd_Prog]          CHAR (8)      CONSTRAINT [DF_POSetup_Crtd_Prog] DEFAULT (' ') NOT NULL,
    [Crtd_User]          CHAR (10)     CONSTRAINT [DF_POSetup_Crtd_User] DEFAULT (' ') NOT NULL,
    [DecPlPrcCst]        SMALLINT      CONSTRAINT [DF_POSetup_DecPlPrcCst] DEFAULT ((0)) NOT NULL,
    [DecPlQty]           SMALLINT      CONSTRAINT [DF_POSetup_DecPlQty] DEFAULT ((0)) NOT NULL,
    [DefaultAltIDType]   CHAR (1)      CONSTRAINT [DF_POSetup_DefaultAltIDType] DEFAULT (' ') NOT NULL,
    [DemandPeriods]      SMALLINT      CONSTRAINT [DF_POSetup_DemandPeriods] DEFAULT ((0)) NOT NULL,
    [DfltLstUnitCost]    CHAR (1)      CONSTRAINT [DF_POSetup_DfltLstUnitCost] DEFAULT (' ') NOT NULL,
    [DfltRcptUnitFromIN] SMALLINT      CONSTRAINT [DF_POSetup_DfltRcptUnitFromIN] DEFAULT ((0)) NOT NULL,
    [FrtAcct]            CHAR (10)     CONSTRAINT [DF_POSetup_FrtAcct] DEFAULT (' ') NOT NULL,
    [FrtSub]             CHAR (24)     CONSTRAINT [DF_POSetup_FrtSub] DEFAULT (' ') NOT NULL,
    [HotPrintPO]         SMALLINT      CONSTRAINT [DF_POSetup_HotPrintPO] DEFAULT ((0)) NOT NULL,
    [INAvail]            SMALLINT      CONSTRAINT [DF_POSetup_INAvail] DEFAULT ((0)) NOT NULL,
    [Init]               SMALLINT      CONSTRAINT [DF_POSetup_Init] DEFAULT ((0)) NOT NULL,
    [InvtCarryingCost]   FLOAT (53)    CONSTRAINT [DF_POSetup_InvtCarryingCost] DEFAULT ((0)) NOT NULL,
    [LastBatNbr]         CHAR (10)     CONSTRAINT [DF_POSetup_LastBatNbr] DEFAULT (' ') NOT NULL,
    [LastPONbr]          CHAR (10)     CONSTRAINT [DF_POSetup_LastPONbr] DEFAULT (' ') NOT NULL,
    [LastRcptNbr]        CHAR (10)     CONSTRAINT [DF_POSetup_LastRcptNbr] DEFAULT (' ') NOT NULL,
    [LUpd_DateTime]      SMALLDATETIME CONSTRAINT [DF_POSetup_LUpd_DateTime] DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_Prog]          CHAR (8)      CONSTRAINT [DF_POSetup_LUpd_Prog] DEFAULT (' ') NOT NULL,
    [LUpd_User]          CHAR (10)     CONSTRAINT [DF_POSetup_LUpd_User] DEFAULT (' ') NOT NULL,
    [MultPOAllowed]      SMALLINT      CONSTRAINT [DF_POSetup_MultPOAllowed] DEFAULT ((0)) NOT NULL,
    [NonInvtAcct]        CHAR (10)     CONSTRAINT [DF_POSetup_NonInvtAcct] DEFAULT (' ') NOT NULL,
    [NonInvtSub]         CHAR (24)     CONSTRAINT [DF_POSetup_NonInvtSub] DEFAULT (' ') NOT NULL,
    [NoteID]             INT           CONSTRAINT [DF_POSetup_NoteID] DEFAULT ((0)) NOT NULL,
    [PCAvail]            SMALLINT      CONSTRAINT [DF_POSetup_PCAvail] DEFAULT ((0)) NOT NULL,
    [PerRetTran]         SMALLINT      CONSTRAINT [DF_POSetup_PerRetTran] DEFAULT ((0)) NOT NULL,
    [PMAvail]            SMALLINT      CONSTRAINT [DF_POSetup_PMAvail] DEFAULT ((0)) NOT NULL,
    [PPVAcct]            CHAR (10)     CONSTRAINT [DF_POSetup_PPVAcct] DEFAULT (' ') NOT NULL,
    [PPVSub]             CHAR (24)     CONSTRAINT [DF_POSetup_PPVSub] DEFAULT (' ') NOT NULL,
    [PrtAddr]            SMALLINT      CONSTRAINT [DF_POSetup_PrtAddr] DEFAULT ((0)) NOT NULL,
    [PrtSite]            SMALLINT      CONSTRAINT [DF_POSetup_PrtSite] DEFAULT ((0)) NOT NULL,
    [ReopenPO]           SMALLINT      CONSTRAINT [DF_POSetup_ReopenPO] DEFAULT ((0)) NOT NULL,
    [S4Future01]         CHAR (30)     CONSTRAINT [DF_POSetup_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02]         CHAR (30)     CONSTRAINT [DF_POSetup_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03]         FLOAT (53)    CONSTRAINT [DF_POSetup_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04]         FLOAT (53)    CONSTRAINT [DF_POSetup_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05]         FLOAT (53)    CONSTRAINT [DF_POSetup_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06]         FLOAT (53)    CONSTRAINT [DF_POSetup_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07]         SMALLDATETIME CONSTRAINT [DF_POSetup_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]         SMALLDATETIME CONSTRAINT [DF_POSetup_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]         INT           CONSTRAINT [DF_POSetup_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10]         INT           CONSTRAINT [DF_POSetup_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11]         CHAR (10)     CONSTRAINT [DF_POSetup_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12]         CHAR (10)     CONSTRAINT [DF_POSetup_S4Future12] DEFAULT (' ') NOT NULL,
    [SetupCost]          FLOAT (53)    CONSTRAINT [DF_POSetup_SetupCost] DEFAULT ((0)) NOT NULL,
    [SetupID]            CHAR (2)      CONSTRAINT [DF_POSetup_SetupID] DEFAULT (' ') NOT NULL,
    [ShipAddr1]          CHAR (60)     CONSTRAINT [DF_POSetup_ShipAddr1] DEFAULT (' ') NOT NULL,
    [ShipAddr2]          CHAR (60)     CONSTRAINT [DF_POSetup_ShipAddr2] DEFAULT (' ') NOT NULL,
    [ShipAttn]           CHAR (30)     CONSTRAINT [DF_POSetup_ShipAttn] DEFAULT (' ') NOT NULL,
    [ShipCity]           CHAR (30)     CONSTRAINT [DF_POSetup_ShipCity] DEFAULT (' ') NOT NULL,
    [ShipCountry]        CHAR (3)      CONSTRAINT [DF_POSetup_ShipCountry] DEFAULT (' ') NOT NULL,
    [ShipEmail]          CHAR (80)     CONSTRAINT [DF_POSetup_ShipEmail] DEFAULT (' ') NOT NULL,
    [ShipFax]            CHAR (30)     CONSTRAINT [DF_POSetup_ShipFax] DEFAULT (' ') NOT NULL,
    [ShipName]           CHAR (60)     CONSTRAINT [DF_POSetup_ShipName] DEFAULT (' ') NOT NULL,
    [ShipPhone]          CHAR (30)     CONSTRAINT [DF_POSetup_ShipPhone] DEFAULT (' ') NOT NULL,
    [ShipState]          CHAR (3)      CONSTRAINT [DF_POSetup_ShipState] DEFAULT (' ') NOT NULL,
    [ShipZip]            CHAR (10)     CONSTRAINT [DF_POSetup_ShipZip] DEFAULT (' ') NOT NULL,
    [TaxFlg]             SMALLINT      CONSTRAINT [DF_POSetup_TaxFlg] DEFAULT ((0)) NOT NULL,
    [TranDescFlg]        CHAR (1)      CONSTRAINT [DF_POSetup_TranDescFlg] DEFAULT (' ') NOT NULL,
    [User1]              CHAR (30)     CONSTRAINT [DF_POSetup_User1] DEFAULT (' ') NOT NULL,
    [User2]              CHAR (30)     CONSTRAINT [DF_POSetup_User2] DEFAULT (' ') NOT NULL,
    [User3]              FLOAT (53)    CONSTRAINT [DF_POSetup_User3] DEFAULT ((0)) NOT NULL,
    [User4]              FLOAT (53)    CONSTRAINT [DF_POSetup_User4] DEFAULT ((0)) NOT NULL,
    [User5]              CHAR (10)     CONSTRAINT [DF_POSetup_User5] DEFAULT (' ') NOT NULL,
    [User6]              CHAR (10)     CONSTRAINT [DF_POSetup_User6] DEFAULT (' ') NOT NULL,
    [User7]              SMALLDATETIME CONSTRAINT [DF_POSetup_User7] DEFAULT ('01/01/1900') NOT NULL,
    [User8]              SMALLDATETIME CONSTRAINT [DF_POSetup_User8] DEFAULT ('01/01/1900') NOT NULL,
    [Vouchering]         SMALLINT      CONSTRAINT [DF_POSetup_Vouchering] DEFAULT ((0)) NOT NULL,
    [VouchQtyErr]        CHAR (1)      CONSTRAINT [DF_POSetup_VouchQtyErr] DEFAULT (' ') NOT NULL,
    [tstamp]             ROWVERSION    NOT NULL,
    CONSTRAINT [POSetup0] PRIMARY KEY CLUSTERED ([SetupID] ASC) WITH (FILLFACTOR = 90)
);

