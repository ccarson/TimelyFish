﻿CREATE TABLE [dbo].[Book] (
    [ActionFlag]           CHAR (1)      CONSTRAINT [DF_Book_ActionFlag] DEFAULT (' ') NOT NULL,
    [BookCntr]             SMALLINT      CONSTRAINT [DF_Book_BookCntr] DEFAULT ((0)) NOT NULL,
    [BookCommCost]         FLOAT (53)    CONSTRAINT [DF_Book_BookCommCost] DEFAULT ((0)) NOT NULL,
    [BookCost]             FLOAT (53)    CONSTRAINT [DF_Book_BookCost] DEFAULT ((0)) NOT NULL,
    [BookSls]              FLOAT (53)    CONSTRAINT [DF_Book_BookSls] DEFAULT ((0)) NOT NULL,
    [ChargeType]           CHAR (1)      CONSTRAINT [DF_Book_ChargeType] DEFAULT (' ') NOT NULL,
    [CommCost]             FLOAT (53)    CONSTRAINT [DF_Book_CommCost] DEFAULT ((0)) NOT NULL,
    [CommPct]              FLOAT (53)    CONSTRAINT [DF_Book_CommPct] DEFAULT ((0)) NOT NULL,
    [CommStmntID]          CHAR (10)     CONSTRAINT [DF_Book_CommStmntID] DEFAULT (' ') NOT NULL,
    [ContractNbr]          CHAR (10)     CONSTRAINT [DF_Book_ContractNbr] DEFAULT (' ') NOT NULL,
    [Cost]                 FLOAT (53)    CONSTRAINT [DF_Book_Cost] DEFAULT ((0)) NOT NULL,
    [CpnyID]               CHAR (10)     CONSTRAINT [DF_Book_CpnyID] DEFAULT (' ') NOT NULL,
    [CreditPct]            FLOAT (53)    CONSTRAINT [DF_Book_CreditPct] DEFAULT ((0)) NOT NULL,
    [Crtd_DateTime]        SMALLDATETIME CONSTRAINT [DF_Book_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [Crtd_Prog]            CHAR (8)      CONSTRAINT [DF_Book_Crtd_Prog] DEFAULT (' ') NOT NULL,
    [Crtd_User]            CHAR (10)     CONSTRAINT [DF_Book_Crtd_User] DEFAULT (' ') NOT NULL,
    [CuryEffDate]          SMALLDATETIME CONSTRAINT [DF_Book_CuryEffDate] DEFAULT ('01/01/1900') NOT NULL,
    [CuryID]               CHAR (4)      CONSTRAINT [DF_Book_CuryID] DEFAULT (' ') NOT NULL,
    [CuryMultDiv]          CHAR (1)      CONSTRAINT [DF_Book_CuryMultDiv] DEFAULT (' ') NOT NULL,
    [CuryRate]             FLOAT (53)    CONSTRAINT [DF_Book_CuryRate] DEFAULT ((0)) NOT NULL,
    [CuryRateType]         CHAR (6)      CONSTRAINT [DF_Book_CuryRateType] DEFAULT (' ') NOT NULL,
    [CustClassID]          CHAR (6)      CONSTRAINT [DF_Book_CustClassID] DEFAULT (' ') NOT NULL,
    [CustCommClassID]      CHAR (10)     CONSTRAINT [DF_Book_CustCommClassID] DEFAULT (' ') NOT NULL,
    [CustID]               CHAR (15)     CONSTRAINT [DF_Book_CustID] DEFAULT (' ') NOT NULL,
    [CustTerr]             CHAR (10)     CONSTRAINT [DF_Book_CustTerr] DEFAULT (' ') NOT NULL,
    [DiscPct]              FLOAT (53)    CONSTRAINT [DF_Book_DiscPct] DEFAULT ((0)) NOT NULL,
    [EffDate]              SMALLDATETIME CONSTRAINT [DF_Book_EffDate] DEFAULT ('01/01/1900') NOT NULL,
    [EffPeriod]            CHAR (6)      CONSTRAINT [DF_Book_EffPeriod] DEFAULT (' ') NOT NULL,
    [FirstRecord]          SMALLINT      CONSTRAINT [DF_Book_FirstRecord] DEFAULT ((0)) NOT NULL,
    [InvtID]               CHAR (30)     CONSTRAINT [DF_Book_InvtID] DEFAULT (' ') NOT NULL,
    [ItemCommClassID]      CHAR (10)     CONSTRAINT [DF_Book_ItemCommClassID] DEFAULT (' ') NOT NULL,
    [MiscChrgRef]          CHAR (5)      CONSTRAINT [DF_Book_MiscChrgRef] DEFAULT (' ') NOT NULL,
    [NoteID]               INT           CONSTRAINT [DF_Book_NoteID] DEFAULT ((0)) NOT NULL,
    [OrdLineRef]           CHAR (5)      CONSTRAINT [DF_Book_OrdLineRef] DEFAULT (' ') NOT NULL,
    [OrdNbr]               CHAR (15)     CONSTRAINT [DF_Book_OrdNbr] DEFAULT (' ') NOT NULL,
    [Period]               CHAR (6)      CONSTRAINT [DF_Book_Period] DEFAULT (' ') NOT NULL,
    [ProdClassID]          CHAR (6)      CONSTRAINT [DF_Book_ProdClassID] DEFAULT (' ') NOT NULL,
    [ProjectID]            CHAR (16)     CONSTRAINT [DF_Book_ProjectID] DEFAULT (' ') NOT NULL,
    [QtyOrd]               FLOAT (53)    CONSTRAINT [DF_Book_QtyOrd] DEFAULT ((0)) NOT NULL,
    [ReqDate]              SMALLDATETIME CONSTRAINT [DF_Book_ReqDate] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future01]           CHAR (30)     CONSTRAINT [DF_Book_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02]           CHAR (30)     CONSTRAINT [DF_Book_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03]           FLOAT (53)    CONSTRAINT [DF_Book_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04]           FLOAT (53)    CONSTRAINT [DF_Book_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05]           FLOAT (53)    CONSTRAINT [DF_Book_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06]           FLOAT (53)    CONSTRAINT [DF_Book_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07]           SMALLDATETIME CONSTRAINT [DF_Book_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]           SMALLDATETIME CONSTRAINT [DF_Book_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]           INT           CONSTRAINT [DF_Book_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10]           INT           CONSTRAINT [DF_Book_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11]           CHAR (10)     CONSTRAINT [DF_Book_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12]           CHAR (10)     CONSTRAINT [DF_Book_S4Future12] DEFAULT (' ') NOT NULL,
    [SchedRef]             CHAR (5)      CONSTRAINT [DF_Book_SchedRef] DEFAULT (' ') NOT NULL,
    [ShipCustID]           CHAR (15)     CONSTRAINT [DF_Book_ShipCustID] DEFAULT (' ') NOT NULL,
    [ShipLineRef]          CHAR (5)      CONSTRAINT [DF_Book_ShipLineRef] DEFAULT (' ') NOT NULL,
    [ShipperID]            CHAR (15)     CONSTRAINT [DF_Book_ShipperID] DEFAULT (' ') NOT NULL,
    [ShiptoID]             CHAR (10)     CONSTRAINT [DF_Book_ShiptoID] DEFAULT (' ') NOT NULL,
    [SiteID]               CHAR (10)     CONSTRAINT [DF_Book_SiteID] DEFAULT (' ') NOT NULL,
    [SlsperID]             CHAR (10)     CONSTRAINT [DF_Book_SlsperID] DEFAULT (' ') NOT NULL,
    [SlsPrice]             FLOAT (53)    CONSTRAINT [DF_Book_SlsPrice] DEFAULT ((0)) NOT NULL,
    [SlsTerr]              CHAR (10)     CONSTRAINT [DF_Book_SlsTerr] DEFAULT (' ') NOT NULL,
    [TaskID]               CHAR (32)     CONSTRAINT [DF_Book_TaskID] DEFAULT (' ') NOT NULL,
    [UnitDesc]             CHAR (6)      CONSTRAINT [DF_Book_UnitDesc] DEFAULT (' ') NOT NULL,
    [UnitMultDiv]          CHAR (1)      CONSTRAINT [DF_Book_UnitMultDiv] DEFAULT (' ') NOT NULL,
    [User1]                CHAR (30)     CONSTRAINT [DF_Book_User1] DEFAULT (' ') NOT NULL,
    [User10]               SMALLDATETIME CONSTRAINT [DF_Book_User10] DEFAULT ('01/01/1900') NOT NULL,
    [User2]                CHAR (30)     CONSTRAINT [DF_Book_User2] DEFAULT (' ') NOT NULL,
    [User3]                CHAR (30)     CONSTRAINT [DF_Book_User3] DEFAULT (' ') NOT NULL,
    [User4]                CHAR (30)     CONSTRAINT [DF_Book_User4] DEFAULT (' ') NOT NULL,
    [User5]                FLOAT (53)    CONSTRAINT [DF_Book_User5] DEFAULT ((0)) NOT NULL,
    [User6]                FLOAT (53)    CONSTRAINT [DF_Book_User6] DEFAULT ((0)) NOT NULL,
    [User7]                CHAR (10)     CONSTRAINT [DF_Book_User7] DEFAULT (' ') NOT NULL,
    [User8]                CHAR (10)     CONSTRAINT [DF_Book_User8] DEFAULT (' ') NOT NULL,
    [User9]                SMALLDATETIME CONSTRAINT [DF_Book_User9] DEFAULT ('01/01/1900') NOT NULL,
    [WeightedBookCommCost] FLOAT (53)    CONSTRAINT [DF_Book_WeightedBookCommCost] DEFAULT ((0)) NOT NULL,
    [WeightedBookCost]     FLOAT (53)    CONSTRAINT [DF_Book_WeightedBookCost] DEFAULT ((0)) NOT NULL,
    [WeightedBookSls]      FLOAT (53)    CONSTRAINT [DF_Book_WeightedBookSls] DEFAULT ((0)) NOT NULL,
    [tstamp]               ROWVERSION    NOT NULL,
    CONSTRAINT [Book0] PRIMARY KEY CLUSTERED ([CpnyID] ASC, [OrdNbr] ASC, [BookCntr] ASC, [OrdLineRef] ASC, [SchedRef] ASC, [ShipperID] ASC, [ShipLineRef] ASC, [SlsperID] ASC, [ActionFlag] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [Book1]
    ON [dbo].[Book]([CpnyID] ASC, [SlsperID] ASC, [EffDate] ASC, [BookSls] ASC, [BookCost] ASC) WITH (FILLFACTOR = 90);

