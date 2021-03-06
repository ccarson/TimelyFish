﻿CREATE TABLE [dbo].[ED810Split] (
    [BoxRef]         CHAR (10)     CONSTRAINT [DF_ED810Split_BoxRef] DEFAULT (' ') NOT NULL,
    [CpnyID]         CHAR (10)     CONSTRAINT [DF_ED810Split_CpnyID] DEFAULT (' ') NOT NULL,
    [Crtd_DateTime]  SMALLDATETIME CONSTRAINT [DF_ED810Split_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [Crtd_Prog]      CHAR (8)      CONSTRAINT [DF_ED810Split_Crtd_Prog] DEFAULT (' ') NOT NULL,
    [Crtd_User]      CHAR (10)     CONSTRAINT [DF_ED810Split_Crtd_User] DEFAULT (' ') NOT NULL,
    [EDIInvID]       CHAR (10)     CONSTRAINT [DF_ED810Split_EDIInvID] DEFAULT (' ') NOT NULL,
    [ExpirDate]      SMALLDATETIME CONSTRAINT [DF_ED810Split_ExpirDate] DEFAULT ('01/01/1900') NOT NULL,
    [LineID]         INT           CONSTRAINT [DF_ED810Split_LineID] DEFAULT ((0)) NOT NULL,
    [LineNbr]        SMALLINT      CONSTRAINT [DF_ED810Split_LineNbr] DEFAULT ((0)) NOT NULL,
    [LotSerNbr]      CHAR (25)     CONSTRAINT [DF_ED810Split_LotSerNbr] DEFAULT (' ') NOT NULL,
    [Lupd_DateTime]  SMALLDATETIME CONSTRAINT [DF_ED810Split_Lupd_DateTime] DEFAULT ('01/01/1900') NOT NULL,
    [Lupd_Prog]      CHAR (8)      CONSTRAINT [DF_ED810Split_Lupd_Prog] DEFAULT (' ') NOT NULL,
    [Lupd_User]      CHAR (10)     CONSTRAINT [DF_ED810Split_Lupd_User] DEFAULT (' ') NOT NULL,
    [QtyInvoiced]    FLOAT (53)    CONSTRAINT [DF_ED810Split_QtyInvoiced] DEFAULT ((0)) NOT NULL,
    [QtyInvoicedUOM] CHAR (6)      CONSTRAINT [DF_ED810Split_QtyInvoicedUOM] DEFAULT (' ') NOT NULL,
    [S4Future01]     CHAR (30)     CONSTRAINT [DF_ED810Split_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02]     CHAR (30)     CONSTRAINT [DF_ED810Split_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03]     FLOAT (53)    CONSTRAINT [DF_ED810Split_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04]     FLOAT (53)    CONSTRAINT [DF_ED810Split_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05]     FLOAT (53)    CONSTRAINT [DF_ED810Split_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06]     FLOAT (53)    CONSTRAINT [DF_ED810Split_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07]     SMALLDATETIME CONSTRAINT [DF_ED810Split_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]     SMALLDATETIME CONSTRAINT [DF_ED810Split_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]     INT           CONSTRAINT [DF_ED810Split_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10]     INT           CONSTRAINT [DF_ED810Split_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11]     CHAR (10)     CONSTRAINT [DF_ED810Split_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12]     CHAR (10)     CONSTRAINT [DF_ED810Split_S4Future12] DEFAULT (' ') NOT NULL,
    [ShipToSite]     CHAR (10)     CONSTRAINT [DF_ED810Split_ShipToSite] DEFAULT (' ') NOT NULL,
    [User1]          CHAR (30)     CONSTRAINT [DF_ED810Split_User1] DEFAULT (' ') NOT NULL,
    [User10]         SMALLDATETIME CONSTRAINT [DF_ED810Split_User10] DEFAULT ('01/01/1900') NOT NULL,
    [User2]          CHAR (30)     CONSTRAINT [DF_ED810Split_User2] DEFAULT (' ') NOT NULL,
    [User3]          CHAR (30)     CONSTRAINT [DF_ED810Split_User3] DEFAULT (' ') NOT NULL,
    [User4]          CHAR (30)     CONSTRAINT [DF_ED810Split_User4] DEFAULT (' ') NOT NULL,
    [User5]          FLOAT (53)    CONSTRAINT [DF_ED810Split_User5] DEFAULT ((0)) NOT NULL,
    [User6]          FLOAT (53)    CONSTRAINT [DF_ED810Split_User6] DEFAULT ((0)) NOT NULL,
    [User7]          CHAR (10)     CONSTRAINT [DF_ED810Split_User7] DEFAULT (' ') NOT NULL,
    [User8]          CHAR (10)     CONSTRAINT [DF_ED810Split_User8] DEFAULT (' ') NOT NULL,
    [User9]          SMALLDATETIME CONSTRAINT [DF_ED810Split_User9] DEFAULT ('01/01/1900') NOT NULL,
    [WhseLoc]        CHAR (10)     CONSTRAINT [DF_ED810Split_WhseLoc] DEFAULT (' ') NOT NULL,
    [tstamp]         ROWVERSION    NOT NULL,
    CONSTRAINT [ED810Split0] PRIMARY KEY CLUSTERED ([CpnyID] ASC, [EDIInvID] ASC, [LineID] ASC, [LineNbr] ASC) WITH (FILLFACTOR = 90)
);

