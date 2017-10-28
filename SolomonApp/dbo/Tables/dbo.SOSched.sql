CREATE TABLE [dbo].[SOSched] (
    [AutoPO]           SMALLINT      CONSTRAINT [DF_SOSched_AutoPO] DEFAULT ((0)) NOT NULL,
    [AutoPOVendID]     CHAR (15)     CONSTRAINT [DF_SOSched_AutoPOVendID] DEFAULT (' ') NOT NULL,
    [BlktOrdQty]       FLOAT (53)    CONSTRAINT [DF_SOSched_BlktOrdQty] DEFAULT ((0)) NOT NULL,
    [BlktOrdSchedRef]  CHAR (5)      CONSTRAINT [DF_SOSched_BlktOrdSchedRef] DEFAULT (' ') NOT NULL,
    [CancelDate]       SMALLDATETIME CONSTRAINT [DF_SOSched_CancelDate] DEFAULT ('01/01/1900') NOT NULL,
    [CpnyID]           CHAR (10)     CONSTRAINT [DF_SOSched_CpnyID] DEFAULT (' ') NOT NULL,
    [Crtd_DateTime]    SMALLDATETIME CONSTRAINT [DF_SOSched_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [Crtd_Prog]        CHAR (8)      CONSTRAINT [DF_SOSched_Crtd_Prog] DEFAULT (' ') NOT NULL,
    [Crtd_User]        CHAR (10)     CONSTRAINT [DF_SOSched_Crtd_User] DEFAULT (' ') NOT NULL,
    [CuryTaxAmt00]     FLOAT (53)    CONSTRAINT [DF_SOSched_CuryTaxAmt00] DEFAULT ((0)) NOT NULL,
    [CuryTaxAmt01]     FLOAT (53)    CONSTRAINT [DF_SOSched_CuryTaxAmt01] DEFAULT ((0)) NOT NULL,
    [CuryTaxAmt02]     FLOAT (53)    CONSTRAINT [DF_SOSched_CuryTaxAmt02] DEFAULT ((0)) NOT NULL,
    [CuryTaxAmt03]     FLOAT (53)    CONSTRAINT [DF_SOSched_CuryTaxAmt03] DEFAULT ((0)) NOT NULL,
    [CuryTxblAmt00]    FLOAT (53)    CONSTRAINT [DF_SOSched_CuryTxblAmt00] DEFAULT ((0)) NOT NULL,
    [CuryTxblAmt01]    FLOAT (53)    CONSTRAINT [DF_SOSched_CuryTxblAmt01] DEFAULT ((0)) NOT NULL,
    [CuryTxblAmt02]    FLOAT (53)    CONSTRAINT [DF_SOSched_CuryTxblAmt02] DEFAULT ((0)) NOT NULL,
    [CuryTxblAmt03]    FLOAT (53)    CONSTRAINT [DF_SOSched_CuryTxblAmt03] DEFAULT ((0)) NOT NULL,
    [DropShip]         SMALLINT      CONSTRAINT [DF_SOSched_DropShip] DEFAULT ((0)) NOT NULL,
    [FrtCollect]       SMALLINT      CONSTRAINT [DF_SOSched_FrtCollect] DEFAULT ((0)) NOT NULL,
    [Hold]             SMALLINT      CONSTRAINT [DF_SOSched_Hold] DEFAULT ((0)) NOT NULL,
    [LineRef]          CHAR (5)      CONSTRAINT [DF_SOSched_LineRef] DEFAULT (' ') NOT NULL,
    [LotSerCntr]       SMALLINT      CONSTRAINT [DF_SOSched_LotSerCntr] DEFAULT ((0)) NOT NULL,
    [LotSerialEntered] SMALLINT      CONSTRAINT [DF_SOSched_LotSerialEntered] DEFAULT ((0)) NOT NULL,
    [LotSerialReq]     SMALLINT      CONSTRAINT [DF_SOSched_LotSerialReq] DEFAULT ((0)) NOT NULL,
    [LotSerNbr]        CHAR (25)     CONSTRAINT [DF_SOSched_LotSerNbr] DEFAULT (' ') NOT NULL,
    [LUpd_DateTime]    SMALLDATETIME CONSTRAINT [DF_SOSched_LUpd_DateTime] DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_Prog]        CHAR (8)      CONSTRAINT [DF_SOSched_LUpd_Prog] DEFAULT (' ') NOT NULL,
    [LUpd_User]        CHAR (10)     CONSTRAINT [DF_SOSched_LUpd_User] DEFAULT (' ') NOT NULL,
    [MarkFor]          SMALLINT      CONSTRAINT [DF_SOSched_MarkFor] DEFAULT ((0)) NOT NULL,
    [NoteID]           INT           CONSTRAINT [DF_SOSched_NoteID] DEFAULT ((0)) NOT NULL,
    [OrdNbr]           CHAR (15)     CONSTRAINT [DF_SOSched_OrdNbr] DEFAULT (' ') NOT NULL,
    [PremFrt]          SMALLINT      CONSTRAINT [DF_SOSched_PremFrt] DEFAULT ((0)) NOT NULL,
    [PriorityDate]     SMALLDATETIME CONSTRAINT [DF_SOSched_PriorityDate] DEFAULT ('01/01/1900') NOT NULL,
    [PrioritySeq]      INT           CONSTRAINT [DF_SOSched_PrioritySeq] DEFAULT ((0)) NOT NULL,
    [PriorityTime]     SMALLDATETIME CONSTRAINT [DF_SOSched_PriorityTime] DEFAULT ('01/01/1900') NOT NULL,
    [PromDate]         SMALLDATETIME CONSTRAINT [DF_SOSched_PromDate] DEFAULT ('01/01/1900') NOT NULL,
    [QtyCloseShip]     FLOAT (53)    CONSTRAINT [DF_SOSched_QtyCloseShip] DEFAULT ((0)) NOT NULL,
    [QtyOpenShip]      FLOAT (53)    CONSTRAINT [DF_SOSched_QtyOpenShip] DEFAULT ((0)) NOT NULL,
    [QtyOrd]           FLOAT (53)    CONSTRAINT [DF_SOSched_QtyOrd] DEFAULT ((0)) NOT NULL,
    [QtyShip]          FLOAT (53)    CONSTRAINT [DF_SOSched_QtyShip] DEFAULT ((0)) NOT NULL,
    [QtyToInvc]        FLOAT (53)    CONSTRAINT [DF_SOSched_QtyToInvc] DEFAULT ((0)) NOT NULL,
    [ReqDate]          SMALLDATETIME CONSTRAINT [DF_SOSched_ReqDate] DEFAULT ('01/01/1900') NOT NULL,
    [ReqPickDate]      SMALLDATETIME CONSTRAINT [DF_SOSched_ReqPickDate] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future01]       CHAR (30)     CONSTRAINT [DF_SOSched_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02]       CHAR (30)     CONSTRAINT [DF_SOSched_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03]       FLOAT (53)    CONSTRAINT [DF_SOSched_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04]       FLOAT (53)    CONSTRAINT [DF_SOSched_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05]       FLOAT (53)    CONSTRAINT [DF_SOSched_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06]       FLOAT (53)    CONSTRAINT [DF_SOSched_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07]       SMALLDATETIME CONSTRAINT [DF_SOSched_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]       SMALLDATETIME CONSTRAINT [DF_SOSched_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]       INT           CONSTRAINT [DF_SOSched_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10]       INT           CONSTRAINT [DF_SOSched_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11]       CHAR (10)     CONSTRAINT [DF_SOSched_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12]       CHAR (10)     CONSTRAINT [DF_SOSched_S4Future12] DEFAULT (' ') NOT NULL,
    [SchedRef]         CHAR (5)      CONSTRAINT [DF_SOSched_SchedRef] DEFAULT (' ') NOT NULL,
    [ShipAddrID]       CHAR (10)     CONSTRAINT [DF_SOSched_ShipAddrID] DEFAULT (' ') NOT NULL,
    [ShipCustID]       CHAR (15)     CONSTRAINT [DF_SOSched_ShipCustID] DEFAULT (' ') NOT NULL,
    [ShipDate]         SMALLDATETIME CONSTRAINT [DF_SOSched_ShipDate] DEFAULT ('01/01/1900') NOT NULL,
    [ShipName]         CHAR (60)     CONSTRAINT [DF_SOSched_ShipName] DEFAULT (' ') NOT NULL,
    [ShipNow]          SMALLINT      CONSTRAINT [DF_SOSched_ShipNow] DEFAULT ((0)) NOT NULL,
    [ShipSiteID]       CHAR (10)     CONSTRAINT [DF_SOSched_ShipSiteID] DEFAULT (' ') NOT NULL,
    [ShiptoID]         CHAR (10)     CONSTRAINT [DF_SOSched_ShiptoID] DEFAULT (' ') NOT NULL,
    [ShiptoType]       CHAR (1)      CONSTRAINT [DF_SOSched_ShiptoType] DEFAULT (' ') NOT NULL,
    [ShipVendID]       CHAR (15)     CONSTRAINT [DF_SOSched_ShipVendID] DEFAULT (' ') NOT NULL,
    [ShipViaID]        CHAR (15)     CONSTRAINT [DF_SOSched_ShipViaID] DEFAULT (' ') NOT NULL,
    [ShipZip]          CHAR (10)     CONSTRAINT [DF_SOSched_ShipZip] DEFAULT (' ') NOT NULL,
    [SiteID]           CHAR (10)     CONSTRAINT [DF_SOSched_SiteID] DEFAULT (' ') NOT NULL,
    [Status]           CHAR (1)      CONSTRAINT [DF_SOSched_Status] DEFAULT (' ') NOT NULL,
    [TaxAmt00]         FLOAT (53)    CONSTRAINT [DF_SOSched_TaxAmt00] DEFAULT ((0)) NOT NULL,
    [TaxAmt01]         FLOAT (53)    CONSTRAINT [DF_SOSched_TaxAmt01] DEFAULT ((0)) NOT NULL,
    [TaxAmt02]         FLOAT (53)    CONSTRAINT [DF_SOSched_TaxAmt02] DEFAULT ((0)) NOT NULL,
    [TaxAmt03]         FLOAT (53)    CONSTRAINT [DF_SOSched_TaxAmt03] DEFAULT ((0)) NOT NULL,
    [TaxCat]           CHAR (10)     CONSTRAINT [DF_SOSched_TaxCat] DEFAULT (' ') NOT NULL,
    [TaxID00]          CHAR (10)     CONSTRAINT [DF_SOSched_TaxID00] DEFAULT (' ') NOT NULL,
    [TaxID01]          CHAR (10)     CONSTRAINT [DF_SOSched_TaxID01] DEFAULT (' ') NOT NULL,
    [TaxID02]          CHAR (10)     CONSTRAINT [DF_SOSched_TaxID02] DEFAULT (' ') NOT NULL,
    [TaxID03]          CHAR (10)     CONSTRAINT [DF_SOSched_TaxID03] DEFAULT (' ') NOT NULL,
    [TaxIDDflt]        CHAR (10)     CONSTRAINT [DF_SOSched_TaxIDDflt] DEFAULT (' ') NOT NULL,
    [TransitTime]      SMALLINT      CONSTRAINT [DF_SOSched_TransitTime] DEFAULT ((0)) NOT NULL,
    [TxblAmt00]        FLOAT (53)    CONSTRAINT [DF_SOSched_TxblAmt00] DEFAULT ((0)) NOT NULL,
    [TxblAmt01]        FLOAT (53)    CONSTRAINT [DF_SOSched_TxblAmt01] DEFAULT ((0)) NOT NULL,
    [TxblAmt02]        FLOAT (53)    CONSTRAINT [DF_SOSched_TxblAmt02] DEFAULT ((0)) NOT NULL,
    [TxblAmt03]        FLOAT (53)    CONSTRAINT [DF_SOSched_TxblAmt03] DEFAULT ((0)) NOT NULL,
    [User1]            CHAR (30)     CONSTRAINT [DF_SOSched_User1] DEFAULT (' ') NOT NULL,
    [User10]           SMALLDATETIME CONSTRAINT [DF_SOSched_User10] DEFAULT ('01/01/1900') NOT NULL,
    [User2]            CHAR (30)     CONSTRAINT [DF_SOSched_User2] DEFAULT (' ') NOT NULL,
    [User3]            CHAR (30)     CONSTRAINT [DF_SOSched_User3] DEFAULT (' ') NOT NULL,
    [User4]            CHAR (30)     CONSTRAINT [DF_SOSched_User4] DEFAULT (' ') NOT NULL,
    [User5]            FLOAT (53)    CONSTRAINT [DF_SOSched_User5] DEFAULT ((0)) NOT NULL,
    [User6]            FLOAT (53)    CONSTRAINT [DF_SOSched_User6] DEFAULT ((0)) NOT NULL,
    [User7]            CHAR (10)     CONSTRAINT [DF_SOSched_User7] DEFAULT (' ') NOT NULL,
    [User8]            CHAR (10)     CONSTRAINT [DF_SOSched_User8] DEFAULT (' ') NOT NULL,
    [User9]            SMALLDATETIME CONSTRAINT [DF_SOSched_User9] DEFAULT ('01/01/1900') NOT NULL,
    [VendAddrID]       CHAR (10)     CONSTRAINT [DF_SOSched_VendAddrID] DEFAULT (' ') NOT NULL,
    [WeekendDelivery]  SMALLINT      CONSTRAINT [DF_SOSched_WeekendDelivery] DEFAULT ((0)) NOT NULL,
    [tstamp]           ROWVERSION    NOT NULL,
    CONSTRAINT [SOSched0] PRIMARY KEY CLUSTERED ([CpnyID] ASC, [OrdNbr] ASC, [LineRef] ASC, [SchedRef] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [SOSched1]
    ON [dbo].[SOSched]([OrdNbr] ASC, [LineRef] ASC, [SchedRef] ASC, [SiteID] ASC, [CpnyID] ASC, [Status] ASC, [CancelDate] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [SOSched2]
    ON [dbo].[SOSched]([Status] ASC, [SiteID] ASC, [DropShip] ASC, [CancelDate] ASC) WITH (FILLFACTOR = 90);


GO
CREATE UNIQUE NONCLUSTERED INDEX [SOSched3]
    ON [dbo].[SOSched]([OrdNbr] ASC, [LineRef] ASC, [SchedRef] ASC, [CpnyID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [SOSched4]
    ON [dbo].[SOSched]([Status] ASC, [ShipSiteID] ASC, [DropShip] ASC, [CancelDate] ASC) WITH (FILLFACTOR = 90);

