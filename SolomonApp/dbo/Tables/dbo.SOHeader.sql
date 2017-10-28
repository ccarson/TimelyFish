CREATE TABLE [dbo].[SOHeader] (
    [AddressType]          CHAR (1)      DEFAULT (' ') NOT NULL,
    [AdminHold]            SMALLINT      DEFAULT ((0)) NOT NULL,
    [AppliedToDocRef]      CHAR (15)     DEFAULT (' ') NOT NULL,
    [ApprDetails]          SMALLINT      DEFAULT ((0)) NOT NULL,
    [ApprRMA]              SMALLINT      DEFAULT ((0)) NOT NULL,
    [ApprTech]             SMALLINT      DEFAULT ((0)) NOT NULL,
    [ARAcct]               CHAR (10)     DEFAULT (' ') NOT NULL,
    [ARSub]                CHAR (24)     DEFAULT (' ') NOT NULL,
    [ASID]                 INT           DEFAULT ((0)) NOT NULL,
    [ASID01]               INT           DEFAULT ((0)) NOT NULL,
    [AuthNbr]              CHAR (20)     DEFAULT (' ') NOT NULL,
    [AutoPO]               SMALLINT      DEFAULT ((0)) NOT NULL,
    [AutoPOVendID]         CHAR (15)     DEFAULT (' ') NOT NULL,
    [AwardProbability]     SMALLINT      DEFAULT ((0)) NOT NULL,
    [BalDue]               FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [BIInvoice]            CHAR (1)      DEFAULT (' ') NOT NULL,
    [BillAddr1]            CHAR (60)     DEFAULT (' ') NOT NULL,
    [BillAddr2]            CHAR (60)     DEFAULT (' ') NOT NULL,
    [BillAddrSpecial]      SMALLINT      DEFAULT ((0)) NOT NULL,
    [BillAttn]             CHAR (30)     DEFAULT (' ') NOT NULL,
    [BillCity]             CHAR (30)     DEFAULT (' ') NOT NULL,
    [BillCountry]          CHAR (3)      DEFAULT (' ') NOT NULL,
    [BillName]             CHAR (60)     DEFAULT (' ') NOT NULL,
    [BillPhone]            CHAR (30)     DEFAULT (' ') NOT NULL,
    [BillState]            CHAR (3)      DEFAULT (' ') NOT NULL,
    [BillThruProject]      SMALLINT      DEFAULT ((0)) NOT NULL,
    [BillZip]              CHAR (10)     DEFAULT (' ') NOT NULL,
    [BlktOrdNbr]           CHAR (15)     DEFAULT (' ') NOT NULL,
    [BookCntr]             SMALLINT      DEFAULT ((0)) NOT NULL,
    [BookCntrMisc]         INT           DEFAULT ((0)) NOT NULL,
    [BuildAssyTime]        SMALLINT      DEFAULT ((0)) NOT NULL,
    [BuildAvailDate]       SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [BuildInvtID]          CHAR (30)     DEFAULT (' ') NOT NULL,
    [BuildQty]             FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [BuildQtyUpdated]      FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [BuildSiteID]          CHAR (10)     DEFAULT (' ') NOT NULL,
    [BuyerID]              CHAR (10)     DEFAULT (' ') NOT NULL,
    [BuyerName]            CHAR (60)     DEFAULT (' ') NOT NULL,
    [CancelDate]           SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [Cancelled]            SMALLINT      DEFAULT ((0)) NOT NULL,
    [CancelShippers]       SMALLINT      DEFAULT ((0)) NOT NULL,
    [CertID]               CHAR (2)      DEFAULT (' ') NOT NULL,
    [CertNoteID]           INT           DEFAULT ((0)) NOT NULL,
    [ChainDisc]            CHAR (15)     DEFAULT (' ') NOT NULL,
    [CmmnPct]              FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [ConsolInv]            SMALLINT      DEFAULT ((0)) NOT NULL,
    [ContractNbr]          CHAR (30)     DEFAULT (' ') NOT NULL,
    [CpnyID]               CHAR (10)     DEFAULT (' ') NOT NULL,
    [CreditApprDays]       SMALLINT      DEFAULT ((0)) NOT NULL,
    [CreditApprLimit]      FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [CreditChk]            SMALLINT      DEFAULT ((0)) NOT NULL,
    [CreditHold]           SMALLINT      DEFAULT ((0)) NOT NULL,
    [CreditHoldDate]       SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [Crtd_DateTime]        SMALLDATETIME DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),(0)),(0)))) NOT NULL,
    [Crtd_Prog]            CHAR (8)      DEFAULT (' ') NOT NULL,
    [Crtd_User]            CHAR (10)     DEFAULT (' ') NOT NULL,
    [CuryBalDue]           FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [CuryEffDate]          SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [CuryID]               CHAR (4)      DEFAULT (' ') NOT NULL,
    [CuryMultDiv]          CHAR (1)      DEFAULT (' ') NOT NULL,
    [CuryPremFrtAmtAppld]  FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [CuryRate]             FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [CuryRateType]         CHAR (6)      DEFAULT (' ') NOT NULL,
    [CuryTotFrt]           FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [CuryTotLineDisc]      FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [CuryTotMerch]         FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [CuryTotMisc]          FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [CuryTotOrd]           FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [CuryTotPmt]           FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [CuryTotPremFrt]       FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [CuryTotTax]           FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [CuryTotTxbl]          FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [CuryUnshippedBalance] FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [CuryWholeOrdDisc]     FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [CustGLClassID]        CHAR (4)      DEFAULT (' ') NOT NULL,
    [CustID]               CHAR (15)     DEFAULT (' ') NOT NULL,
    [CustOrdNbr]           CHAR (25)     DEFAULT (' ') NOT NULL,
    [DateCancelled]        SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [Dept]                 CHAR (30)     DEFAULT (' ') NOT NULL,
    [DiscAcct]             CHAR (10)     DEFAULT (' ') NOT NULL,
    [DiscPct]              FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [DiscSub]              CHAR (24)     DEFAULT (' ') NOT NULL,
    [Div]                  CHAR (30)     DEFAULT (' ') NOT NULL,
    [DropShip]             SMALLINT      DEFAULT ((0)) NOT NULL,
    [EDI810]               SMALLINT      DEFAULT ((0)) NOT NULL,
    [EDI856]               SMALLINT      DEFAULT ((0)) NOT NULL,
    [EDIPOID]              CHAR (10)     DEFAULT (' ') NOT NULL,
    [EventCntr]            SMALLINT      DEFAULT ((0)) NOT NULL,
    [FOBID]                CHAR (15)     DEFAULT (' ') NOT NULL,
    [FrtAcct]              CHAR (10)     DEFAULT (' ') NOT NULL,
    [FrtCollect]           SMALLINT      DEFAULT ((0)) NOT NULL,
    [FrtSub]               CHAR (24)     DEFAULT (' ') NOT NULL,
    [FrtTermsID]           CHAR (10)     DEFAULT (' ') NOT NULL,
    [GeoCode]              CHAR (10)     DEFAULT (' ') NOT NULL,
    [InvcDate]             SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [InvcNbr]              CHAR (15)     DEFAULT (' ') NOT NULL,
    [IRDemand]             SMALLINT      DEFAULT ((0)) NOT NULL,
    [LanguageID]           CHAR (4)      DEFAULT (' ') NOT NULL,
    [LineCntr]             SMALLINT      DEFAULT ((0)) NOT NULL,
    [LostSaleID]           CHAR (2)      DEFAULT (' ') NOT NULL,
    [LUpd_DateTime]        SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_Prog]            CHAR (8)      DEFAULT (' ') NOT NULL,
    [LUpd_User]            CHAR (10)     DEFAULT (' ') NOT NULL,
    [MarkFor]              SMALLINT      DEFAULT ((0)) NOT NULL,
    [MiscChrgCntr]         SMALLINT      DEFAULT ((0)) NOT NULL,
    [NextFunctionClass]    CHAR (4)      DEFAULT (' ') NOT NULL,
    [NextFunctionID]       CHAR (8)      DEFAULT (' ') NOT NULL,
    [NoteId]               INT           DEFAULT ((0)) NOT NULL,
    [OrdDate]              SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [OrdNbr]               CHAR (15)     DEFAULT (' ') NOT NULL,
    [OrigOrdNbr]           CHAR (15)     DEFAULT (' ') NOT NULL,
    [PC_Status]            CHAR (1)      DEFAULT (' ') NOT NULL,
    [PerPost]              CHAR (6)      DEFAULT (' ') NOT NULL,
    [PmtCntr]              SMALLINT      DEFAULT ((0)) NOT NULL,
    [PremFrtAmtApplied]    FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [Priority]             SMALLINT      DEFAULT ((0)) NOT NULL,
    [ProjectID]            CHAR (16)     DEFAULT (' ') NOT NULL,
    [QuoteDate]            SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [Released]             SMALLINT      DEFAULT ((0)) NOT NULL,
    [ReleaseValue]         FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [RequireStepAssy]      SMALLINT      DEFAULT ((0)) NOT NULL,
    [RequireStepInsp]      SMALLINT      DEFAULT ((0)) NOT NULL,
    [RlseForInvc]          SMALLINT      DEFAULT ((0)) NOT NULL,
    [S4Future01]           CHAR (30)     DEFAULT (' ') NOT NULL,
    [S4Future02]           CHAR (30)     DEFAULT (' ') NOT NULL,
    [S4Future03]           FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [S4Future04]           FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [S4Future05]           FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [S4Future06]           FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [S4Future07]           SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]           SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]           INT           DEFAULT ((0)) NOT NULL,
    [S4Future10]           INT           DEFAULT ((0)) NOT NULL,
    [S4Future11]           CHAR (10)     DEFAULT (' ') NOT NULL,
    [S4Future12]           CHAR (10)     DEFAULT (' ') NOT NULL,
    [SellingSiteID]        CHAR (10)     DEFAULT (' ') NOT NULL,
    [SFOOrdNbr]            CHAR (15)     DEFAULT (' ') NOT NULL,
    [ShipAddr1]            CHAR (60)     DEFAULT (' ') NOT NULL,
    [ShipAddr2]            CHAR (60)     DEFAULT (' ') NOT NULL,
    [ShipAddrID]           CHAR (10)     DEFAULT (' ') NOT NULL,
    [ShipAddrSpecial]      SMALLINT      DEFAULT ((0)) NOT NULL,
    [ShipAttn]             CHAR (30)     DEFAULT (' ') NOT NULL,
    [ShipCity]             CHAR (30)     DEFAULT (' ') NOT NULL,
    [ShipCmplt]            SMALLINT      DEFAULT ((0)) NOT NULL,
    [ShipCountry]          CHAR (3)      DEFAULT (' ') NOT NULL,
    [ShipCustID]           CHAR (15)     DEFAULT (' ') NOT NULL,
    [ShipGeoCode]          CHAR (10)     DEFAULT (' ') NOT NULL,
    [ShipName]             CHAR (60)     DEFAULT (' ') NOT NULL,
    [ShipPhone]            CHAR (30)     DEFAULT (' ') NOT NULL,
    [ShipSiteID]           CHAR (10)     DEFAULT (' ') NOT NULL,
    [ShipState]            CHAR (3)      DEFAULT (' ') NOT NULL,
    [ShiptoID]             CHAR (10)     DEFAULT (' ') NOT NULL,
    [ShiptoType]           CHAR (1)      DEFAULT (' ') NOT NULL,
    [ShipVendID]           CHAR (15)     DEFAULT (' ') NOT NULL,
    [ShipViaID]            CHAR (15)     DEFAULT (' ') NOT NULL,
    [ShipZip]              CHAR (10)     DEFAULT (' ') NOT NULL,
    [SlsperID]             CHAR (10)     DEFAULT (' ') NOT NULL,
    [SOTypeID]             CHAR (4)      DEFAULT (' ') NOT NULL,
    [Status]               CHAR (1)      DEFAULT (' ') NOT NULL,
    [TaxID00]              CHAR (10)     DEFAULT (' ') NOT NULL,
    [TaxID01]              CHAR (10)     DEFAULT (' ') NOT NULL,
    [TaxID02]              CHAR (10)     DEFAULT (' ') NOT NULL,
    [TaxID03]              CHAR (10)     DEFAULT (' ') NOT NULL,
    [TermsID]              CHAR (2)      DEFAULT (' ') NOT NULL,
    [TotCommCost]          FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [TotCost]              FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [TotFrt]               FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [TotLineDisc]          FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [TotMerch]             FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [TotMisc]              FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [TotOrd]               FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [TotPmt]               FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [TotPremFrt]           FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [TotShipWght]          FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [TotTax]               FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [TotTxbl]              FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [UnshippedBalance]     FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [User1]                CHAR (30)     DEFAULT (' ') NOT NULL,
    [User10]               SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [User2]                CHAR (30)     DEFAULT (' ') NOT NULL,
    [User3]                CHAR (30)     DEFAULT (' ') NOT NULL,
    [User4]                CHAR (30)     DEFAULT (' ') NOT NULL,
    [User5]                FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [User6]                FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [User7]                CHAR (10)     DEFAULT (' ') NOT NULL,
    [User8]                CHAR (10)     DEFAULT (' ') NOT NULL,
    [User9]                SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [VendAddrID]           CHAR (10)     DEFAULT (' ') NOT NULL,
    [WeekendDelivery]      SMALLINT      DEFAULT ((0)) NOT NULL,
    [WholeOrdDisc]         FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [WorkflowID]           INT           DEFAULT ((0)) NOT NULL,
    [WorkflowStatus]       CHAR (1)      DEFAULT (' ') NOT NULL,
    [WSID]                 INT           DEFAULT ((0)) NOT NULL,
    [tstamp]               ROWVERSION    NOT NULL,
    CONSTRAINT [SOHeader0] PRIMARY KEY CLUSTERED ([CpnyID] ASC, [OrdNbr] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [SOHeader1]
    ON [dbo].[SOHeader]([NextFunctionID] ASC, [NextFunctionClass] ASC, [CpnyID] ASC, [OrdNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [SOHeader2]
    ON [dbo].[SOHeader]([BuildInvtID] ASC, [BuildSiteID] ASC, [Status] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [SOHeader3]
    ON [dbo].[SOHeader]([CpnyID] ASC, [SOTypeID] ASC, [Status] ASC) WITH (FILLFACTOR = 90);


GO
CREATE UNIQUE NONCLUSTERED INDEX [SOHeader4]
    ON [dbo].[SOHeader]([CpnyID] ASC, [OrdNbr] ASC, [Status] ASC, [CreditChk] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [SOHeader5]
    ON [dbo].[SOHeader]([CustID] ASC, [Status] ASC, [CpnyID] ASC, [OrdNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [SOHeader6]
    ON [dbo].[SOHeader]([OrdNbr] ASC, [CpnyID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [SOHeader7]
    ON [dbo].[SOHeader]([S4Future02] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [SOHeader8]
    ON [dbo].[SOHeader]([CreditHoldDate] ASC, [CreditHold] ASC, [Status] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [SOHeader9]
    ON [dbo].[SOHeader]([Status] ASC, [CpnyID] ASC, [OrdNbr] ASC, [ShipSiteID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [SOHeader10]
    ON [dbo].[SOHeader]([CustID] ASC, [Status] ASC, [CpnyID] ASC, [SOTypeID] ASC, [UnshippedBalance] ASC, [AdminHold] ASC, [TermsID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [SOHeader11]
    ON [dbo].[SOHeader]([ProjectID] ASC, [Status] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [SOHeader12]
    ON [dbo].[SOHeader]([EDIPOID] ASC, [Cancelled] ASC) WITH (FILLFACTOR = 90);

