﻿CREATE TABLE [dbo].[SOShipTax] (
    [CpnyID]               CHAR (10)     CONSTRAINT [DF_SOShipTax_CpnyID] DEFAULT (' ') NOT NULL,
    [Crtd_DateTime]        SMALLDATETIME CONSTRAINT [DF_SOShipTax_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [Crtd_Prog]            CHAR (8)      CONSTRAINT [DF_SOShipTax_Crtd_Prog] DEFAULT (' ') NOT NULL,
    [Crtd_User]            CHAR (10)     CONSTRAINT [DF_SOShipTax_Crtd_User] DEFAULT (' ') NOT NULL,
    [CuryFrtTax]           FLOAT (53)    CONSTRAINT [DF_SOShipTax_CuryFrtTax] DEFAULT ((0)) NOT NULL,
    [CuryFrtTxbl]          FLOAT (53)    CONSTRAINT [DF_SOShipTax_CuryFrtTxbl] DEFAULT ((0)) NOT NULL,
    [CuryMerchTax]         FLOAT (53)    CONSTRAINT [DF_SOShipTax_CuryMerchTax] DEFAULT ((0)) NOT NULL,
    [CuryMerchTxbl]        FLOAT (53)    CONSTRAINT [DF_SOShipTax_CuryMerchTxbl] DEFAULT ((0)) NOT NULL,
    [CuryMerchTxblLessTax] FLOAT (53)    CONSTRAINT [DF_SOShipTax_CuryMerchTxblLessTax] DEFAULT ((0)) NOT NULL,
    [CuryMiscTax]          FLOAT (53)    CONSTRAINT [DF_SOShipTax_CuryMiscTax] DEFAULT ((0)) NOT NULL,
    [CuryMiscTxbl]         FLOAT (53)    CONSTRAINT [DF_SOShipTax_CuryMiscTxbl] DEFAULT ((0)) NOT NULL,
    [CuryTotTax]           FLOAT (53)    CONSTRAINT [DF_SOShipTax_CuryTotTax] DEFAULT ((0)) NOT NULL,
    [CuryTotTxbl]          FLOAT (53)    CONSTRAINT [DF_SOShipTax_CuryTotTxbl] DEFAULT ((0)) NOT NULL,
    [FrtTax]               FLOAT (53)    CONSTRAINT [DF_SOShipTax_FrtTax] DEFAULT ((0)) NOT NULL,
    [FrtTxbl]              FLOAT (53)    CONSTRAINT [DF_SOShipTax_FrtTxbl] DEFAULT ((0)) NOT NULL,
    [LUpd_DateTime]        SMALLDATETIME CONSTRAINT [DF_SOShipTax_LUpd_DateTime] DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_Prog]            CHAR (8)      CONSTRAINT [DF_SOShipTax_LUpd_Prog] DEFAULT (' ') NOT NULL,
    [LUpd_User]            CHAR (10)     CONSTRAINT [DF_SOShipTax_LUpd_User] DEFAULT (' ') NOT NULL,
    [MerchTax]             FLOAT (53)    CONSTRAINT [DF_SOShipTax_MerchTax] DEFAULT ((0)) NOT NULL,
    [MerchTxbl]            FLOAT (53)    CONSTRAINT [DF_SOShipTax_MerchTxbl] DEFAULT ((0)) NOT NULL,
    [MerchTxblLessTax]     FLOAT (53)    CONSTRAINT [DF_SOShipTax_MerchTxblLessTax] DEFAULT ((0)) NOT NULL,
    [MiscTax]              FLOAT (53)    CONSTRAINT [DF_SOShipTax_MiscTax] DEFAULT ((0)) NOT NULL,
    [MiscTxbl]             FLOAT (53)    CONSTRAINT [DF_SOShipTax_MiscTxbl] DEFAULT ((0)) NOT NULL,
    [NoteID]               INT           CONSTRAINT [DF_SOShipTax_NoteID] DEFAULT ((0)) NOT NULL,
    [S4Future01]           CHAR (30)     CONSTRAINT [DF_SOShipTax_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02]           CHAR (30)     CONSTRAINT [DF_SOShipTax_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03]           FLOAT (53)    CONSTRAINT [DF_SOShipTax_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04]           FLOAT (53)    CONSTRAINT [DF_SOShipTax_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05]           FLOAT (53)    CONSTRAINT [DF_SOShipTax_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06]           FLOAT (53)    CONSTRAINT [DF_SOShipTax_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07]           SMALLDATETIME CONSTRAINT [DF_SOShipTax_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]           SMALLDATETIME CONSTRAINT [DF_SOShipTax_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]           INT           CONSTRAINT [DF_SOShipTax_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10]           INT           CONSTRAINT [DF_SOShipTax_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11]           CHAR (10)     CONSTRAINT [DF_SOShipTax_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12]           CHAR (10)     CONSTRAINT [DF_SOShipTax_S4Future12] DEFAULT (' ') NOT NULL,
    [ShipperID]            CHAR (15)     CONSTRAINT [DF_SOShipTax_ShipperID] DEFAULT (' ') NOT NULL,
    [ShowTaxOnOrderTotal]  SMALLINT      CONSTRAINT [DF_SOShipTax_ShowTaxOnOrderTotal] DEFAULT ((0)) NOT NULL,
    [TaxCat]               CHAR (10)     CONSTRAINT [DF_SOShipTax_TaxCat] DEFAULT (' ') NOT NULL,
    [TaxID]                CHAR (10)     CONSTRAINT [DF_SOShipTax_TaxID] DEFAULT (' ') NOT NULL,
    [TaxRate]              FLOAT (53)    CONSTRAINT [DF_SOShipTax_TaxRate] DEFAULT ((0)) NOT NULL,
    [TotTax]               FLOAT (53)    CONSTRAINT [DF_SOShipTax_TotTax] DEFAULT ((0)) NOT NULL,
    [TotTxbl]              FLOAT (53)    CONSTRAINT [DF_SOShipTax_TotTxbl] DEFAULT ((0)) NOT NULL,
    [User1]                CHAR (30)     CONSTRAINT [DF_SOShipTax_User1] DEFAULT (' ') NOT NULL,
    [User10]               SMALLDATETIME CONSTRAINT [DF_SOShipTax_User10] DEFAULT ('01/01/1900') NOT NULL,
    [User2]                CHAR (30)     CONSTRAINT [DF_SOShipTax_User2] DEFAULT (' ') NOT NULL,
    [User3]                CHAR (30)     CONSTRAINT [DF_SOShipTax_User3] DEFAULT (' ') NOT NULL,
    [User4]                CHAR (30)     CONSTRAINT [DF_SOShipTax_User4] DEFAULT (' ') NOT NULL,
    [User5]                FLOAT (53)    CONSTRAINT [DF_SOShipTax_User5] DEFAULT ((0)) NOT NULL,
    [User6]                FLOAT (53)    CONSTRAINT [DF_SOShipTax_User6] DEFAULT ((0)) NOT NULL,
    [User7]                CHAR (10)     CONSTRAINT [DF_SOShipTax_User7] DEFAULT (' ') NOT NULL,
    [User8]                CHAR (10)     CONSTRAINT [DF_SOShipTax_User8] DEFAULT (' ') NOT NULL,
    [User9]                SMALLDATETIME CONSTRAINT [DF_SOShipTax_User9] DEFAULT ('01/01/1900') NOT NULL,
    [tstamp]               ROWVERSION    NOT NULL,
    CONSTRAINT [SOShipTax0] PRIMARY KEY CLUSTERED ([CpnyID] ASC, [ShipperID] ASC, [TaxID] ASC, [TaxCat] ASC) WITH (FILLFACTOR = 90)
);
