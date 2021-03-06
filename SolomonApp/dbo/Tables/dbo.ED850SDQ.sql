﻿CREATE TABLE [dbo].[ED850SDQ] (
    [CpnyID]        CHAR (10)     CONSTRAINT [DF_ED850SDQ_CpnyID] DEFAULT (' ') NOT NULL,
    [Crtd_DateTime] SMALLDATETIME CONSTRAINT [DF_ED850SDQ_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [Crtd_Prog]     CHAR (8)      CONSTRAINT [DF_ED850SDQ_Crtd_Prog] DEFAULT (' ') NOT NULL,
    [Crtd_User]     CHAR (10)     CONSTRAINT [DF_ED850SDQ_Crtd_User] DEFAULT (' ') NOT NULL,
    [DiscTaken]     SMALLINT      CONSTRAINT [DF_ED850SDQ_DiscTaken] DEFAULT ((0)) NOT NULL,
    [EDIPOID]       CHAR (10)     CONSTRAINT [DF_ED850SDQ_EDIPOID] DEFAULT (' ') NOT NULL,
    [IDCodeQual]    CHAR (3)      CONSTRAINT [DF_ED850SDQ_IDCodeQual] DEFAULT (' ') NOT NULL,
    [LineID]        INT           CONSTRAINT [DF_ED850SDQ_LineID] DEFAULT ((0)) NOT NULL,
    [LineNbr]       SMALLINT      CONSTRAINT [DF_ED850SDQ_LineNbr] DEFAULT ((0)) NOT NULL,
    [Lupd_DateTime] SMALLDATETIME CONSTRAINT [DF_ED850SDQ_Lupd_DateTime] DEFAULT ('01/01/1900') NOT NULL,
    [Lupd_Prog]     CHAR (8)      CONSTRAINT [DF_ED850SDQ_Lupd_Prog] DEFAULT (' ') NOT NULL,
    [Lupd_User]     CHAR (10)     CONSTRAINT [DF_ED850SDQ_Lupd_User] DEFAULT (' ') NOT NULL,
    [Qty]           FLOAT (53)    CONSTRAINT [DF_ED850SDQ_Qty] DEFAULT ((0)) NOT NULL,
    [S4Future01]    CHAR (30)     CONSTRAINT [DF_ED850SDQ_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02]    CHAR (30)     CONSTRAINT [DF_ED850SDQ_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03]    FLOAT (53)    CONSTRAINT [DF_ED850SDQ_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04]    FLOAT (53)    CONSTRAINT [DF_ED850SDQ_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05]    FLOAT (53)    CONSTRAINT [DF_ED850SDQ_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06]    FLOAT (53)    CONSTRAINT [DF_ED850SDQ_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07]    SMALLDATETIME CONSTRAINT [DF_ED850SDQ_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]    SMALLDATETIME CONSTRAINT [DF_ED850SDQ_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]    INT           CONSTRAINT [DF_ED850SDQ_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10]    INT           CONSTRAINT [DF_ED850SDQ_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11]    CHAR (10)     CONSTRAINT [DF_ED850SDQ_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12]    CHAR (10)     CONSTRAINT [DF_ED850SDQ_S4Future12] DEFAULT (' ') NOT NULL,
    [SolShipToID]   CHAR (10)     CONSTRAINT [DF_ED850SDQ_SolShipToID] DEFAULT (' ') NOT NULL,
    [StoreNbr]      CHAR (17)     CONSTRAINT [DF_ED850SDQ_StoreNbr] DEFAULT (' ') NOT NULL,
    [UOM]           CHAR (6)      CONSTRAINT [DF_ED850SDQ_UOM] DEFAULT (' ') NOT NULL,
    [User1]         CHAR (30)     CONSTRAINT [DF_ED850SDQ_User1] DEFAULT (' ') NOT NULL,
    [User10]        SMALLDATETIME CONSTRAINT [DF_ED850SDQ_User10] DEFAULT ('01/01/1900') NOT NULL,
    [User2]         CHAR (30)     CONSTRAINT [DF_ED850SDQ_User2] DEFAULT (' ') NOT NULL,
    [User3]         CHAR (30)     CONSTRAINT [DF_ED850SDQ_User3] DEFAULT (' ') NOT NULL,
    [User4]         CHAR (30)     CONSTRAINT [DF_ED850SDQ_User4] DEFAULT (' ') NOT NULL,
    [User5]         FLOAT (53)    CONSTRAINT [DF_ED850SDQ_User5] DEFAULT ((0)) NOT NULL,
    [User6]         FLOAT (53)    CONSTRAINT [DF_ED850SDQ_User6] DEFAULT ((0)) NOT NULL,
    [User7]         CHAR (10)     CONSTRAINT [DF_ED850SDQ_User7] DEFAULT (' ') NOT NULL,
    [User8]         CHAR (10)     CONSTRAINT [DF_ED850SDQ_User8] DEFAULT (' ') NOT NULL,
    [User9]         SMALLDATETIME CONSTRAINT [DF_ED850SDQ_User9] DEFAULT ('01/01/1900') NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [ED850SDQ0] PRIMARY KEY CLUSTERED ([CpnyID] ASC, [EDIPOID] ASC, [LineID] ASC, [LineNbr] ASC) WITH (FILLFACTOR = 90)
);

