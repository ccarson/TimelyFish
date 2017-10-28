CREATE TABLE [dbo].[SOShipHeader] (
    [AccrDocDate]        SMALLDATETIME NOT NULL,
    [AccrPerPost]        CHAR (6)      NOT NULL,
    [AccrRevAcct]        CHAR (10)     NOT NULL,
    [AccrRevSub]         CHAR (24)     NOT NULL,
    [AccrShipRegisterID] CHAR (10)     NOT NULL,
    [AddressType]        CHAR (1)      NOT NULL,
    [AdminHold]          SMALLINT      NOT NULL,
    [AppliedToDocRef]    CHAR (15)     NOT NULL,
    [ARAcct]             CHAR (10)     NOT NULL,
    [ARBatNbr]           CHAR (10)     NOT NULL,
    [ARDocType]          CHAR (2)      NOT NULL,
    [ARSub]              CHAR (24)     NOT NULL,
    [ASID]               INT           NOT NULL,
    [ASID01]             INT           NOT NULL,
    [AuthNbr]            CHAR (20)     NOT NULL,
    [AutoReleaseReturn]  SMALLINT      NOT NULL,
    [BalDue]             FLOAT (53)    NOT NULL,
    [BIInvoice]          CHAR (1)      DEFAULT (' ') NOT NULL,
    [BillAddr1]          CHAR (60)     NOT NULL,
    [BillAddr2]          CHAR (60)     NOT NULL,
    [BillAddrSpecial]    SMALLINT      NOT NULL,
    [BillAttn]           CHAR (30)     NOT NULL,
    [BillCity]           CHAR (30)     NOT NULL,
    [BillCountry]        CHAR (3)      NOT NULL,
    [BillName]           CHAR (60)     NOT NULL,
    [BillPhone]          CHAR (30)     NOT NULL,
    [BillState]          CHAR (3)      NOT NULL,
    [BillThruProject]    SMALLINT      NOT NULL,
    [BillZip]            CHAR (10)     NOT NULL,
    [BlktOrdNbr]         CHAR (15)     NOT NULL,
    [BMICost]            FLOAT (53)    NOT NULL,
    [BMICuryID]          CHAR (4)      NOT NULL,
    [BMIEffDate]         SMALLDATETIME NOT NULL,
    [BMIMultDiv]         CHAR (1)      NOT NULL,
    [BMIRate]            FLOAT (53)    NOT NULL,
    [BMIRtTp]            CHAR (6)      NOT NULL,
    [BookCntr]           SMALLINT      NOT NULL,
    [BookCntrMisc]       INT           NOT NULL,
    [BoxCntr]            SMALLINT      NOT NULL,
    [BuildActQty]        FLOAT (53)    NOT NULL,
    [BuildCmpltDate]     SMALLDATETIME NOT NULL,
    [BuildInvtID]        CHAR (30)     NOT NULL,
    [BuildLotSerCntr]    INT           NOT NULL,
    [BuildQty]           FLOAT (53)    NOT NULL,
    [BuildTotalCost]     FLOAT (53)    NOT NULL,
    [BuyerID]            CHAR (10)     NOT NULL,
    [BuyerName]          CHAR (60)     NOT NULL,
    [CancelBO]           SMALLINT      NOT NULL,
    [Cancelled]          SMALLINT      NOT NULL,
    [CancelOrder]        SMALLINT      NOT NULL,
    [CertID]             CHAR (2)      NOT NULL,
    [CertNoteID]         INT           NOT NULL,
    [ChainDisc]          CHAR (15)     NOT NULL,
    [CmmnPct]            FLOAT (53)    NOT NULL,
    [ConsolInv]          SMALLINT      NOT NULL,
    [ContractNbr]        CHAR (25)     NOT NULL,
    [CpnyID]             CHAR (10)     NOT NULL,
    [CreditApprDays]     SMALLINT      NOT NULL,
    [CreditApprLimit]    FLOAT (53)    NOT NULL,
    [CreditChk]          SMALLINT      NOT NULL,
    [CreditHold]         SMALLINT      NOT NULL,
    [CreditHoldDate]     SMALLDATETIME NOT NULL,
    [Crtd_DateTime]      SMALLDATETIME NOT NULL,
    [Crtd_Prog]          CHAR (8)      NOT NULL,
    [Crtd_User]          CHAR (10)     NOT NULL,
    [CuryBalDue]         FLOAT (53)    NOT NULL,
    [CuryBuildTotCost]   FLOAT (53)    NOT NULL,
    [CuryEffDate]        SMALLDATETIME NOT NULL,
    [CuryID]             CHAR (4)      NOT NULL,
    [CuryMultDiv]        CHAR (1)      NOT NULL,
    [CuryPremFrtAmt]     FLOAT (53)    NOT NULL,
    [CuryRate]           FLOAT (53)    NOT NULL,
    [CuryRateType]       CHAR (6)      NOT NULL,
    [CuryTotFrtCost]     FLOAT (53)    NOT NULL,
    [CuryTotFrtInvc]     FLOAT (53)    NOT NULL,
    [CuryTotInvc]        FLOAT (53)    NOT NULL,
    [CuryTotLineDisc]    FLOAT (53)    NOT NULL,
    [CuryTotMerch]       FLOAT (53)    NOT NULL,
    [CuryTotMisc]        FLOAT (53)    NOT NULL,
    [CuryTotPmt]         FLOAT (53)    NOT NULL,
    [CuryTotTax]         FLOAT (53)    NOT NULL,
    [CuryTotTxbl]        FLOAT (53)    NOT NULL,
    [CuryWholeOrdDisc]   FLOAT (53)    NOT NULL,
    [CustGLClassID]      CHAR (4)      NOT NULL,
    [CustID]             CHAR (15)     NOT NULL,
    [CustOrdNbr]         CHAR (25)     NOT NULL,
    [DateCancelled]      SMALLDATETIME NOT NULL,
    [Dept]               CHAR (30)     NOT NULL,
    [DiscAcct]           CHAR (10)     NOT NULL,
    [DiscPct]            FLOAT (53)    NOT NULL,
    [DiscSub]            CHAR (24)     NOT NULL,
    [Div]                CHAR (30)     NOT NULL,
    [DropShip]           SMALLINT      NOT NULL,
    [EDI810]             SMALLINT      NOT NULL,
    [EDI856]             SMALLINT      NOT NULL,
    [EDIASNProcNbr]      CHAR (10)     NOT NULL,
    [EDIInvcProcNbr]     CHAR (10)     NOT NULL,
    [ETADate]            SMALLDATETIME NOT NULL,
    [FOBID]              CHAR (15)     NOT NULL,
    [FrtAcct]            CHAR (10)     NOT NULL,
    [FrtCollect]         SMALLINT      NOT NULL,
    [FrtSub]             CHAR (24)     NOT NULL,
    [FrtTermsID]         CHAR (10)     NOT NULL,
    [GeoCode]            CHAR (10)     NOT NULL,
    [INBatNbr]           CHAR (10)     NOT NULL,
    [InvcDate]           SMALLDATETIME NOT NULL,
    [InvcNbr]            CHAR (15)     NOT NULL,
    [InvcPrint]          SMALLINT      NOT NULL,
    [LanguageID]         CHAR (4)      NOT NULL,
    [LastAppendDate]     SMALLDATETIME NOT NULL,
    [LastAppendTime]     SMALLDATETIME NOT NULL,
    [LineCntr]           SMALLINT      NOT NULL,
    [LotSerialHold]      SMALLINT      NOT NULL,
    [LUpd_DateTime]      SMALLDATETIME NOT NULL,
    [LUpd_Prog]          CHAR (8)      NOT NULL,
    [LUpd_User]          CHAR (10)     NOT NULL,
    [MarkFor]            SMALLINT      NOT NULL,
    [MiscChrgCntr]       SMALLINT      NOT NULL,
    [NextFunctionClass]  CHAR (4)      NOT NULL,
    [NextFunctionID]     CHAR (8)      NOT NULL,
    [NoteID]             INT           NOT NULL,
    [OKToAppend]         SMALLINT      NOT NULL,
    [OrdDate]            SMALLDATETIME NOT NULL,
    [OrdNbr]             CHAR (15)     NOT NULL,
    [OverridePerPost]    SMALLINT      NOT NULL,
    [PackDate]           SMALLDATETIME NOT NULL,
    [PerClosed]          CHAR (6)      NOT NULL,
    [PerPost]            CHAR (6)      NOT NULL,
    [PickDate]           SMALLDATETIME NOT NULL,
    [PmtCntr]            SMALLINT      NOT NULL,
    [PremFrt]            SMALLINT      NOT NULL,
    [PremFrtAmt]         FLOAT (53)    NOT NULL,
    [Priority]           SMALLINT      NOT NULL,
    [ProjectID]          CHAR (16)     NOT NULL,
    [RelDate]            SMALLDATETIME NOT NULL,
    [ReleaseValue]       FLOAT (53)    NOT NULL,
    [RequireStepAssy]    SMALLINT      NOT NULL,
    [RequireStepInsp]    SMALLINT      NOT NULL,
    [S4Future01]         CHAR (30)     NOT NULL,
    [S4Future02]         CHAR (30)     NOT NULL,
    [S4Future03]         FLOAT (53)    NOT NULL,
    [S4Future04]         FLOAT (53)    NOT NULL,
    [S4Future05]         FLOAT (53)    NOT NULL,
    [S4Future06]         FLOAT (53)    NOT NULL,
    [S4Future07]         SMALLDATETIME NOT NULL,
    [S4Future08]         SMALLDATETIME NOT NULL,
    [S4Future09]         INT           NOT NULL,
    [S4Future10]         INT           NOT NULL,
    [S4Future11]         CHAR (10)     NOT NULL,
    [S4Future12]         CHAR (10)     NOT NULL,
    [SellingSiteID]      CHAR (10)     NOT NULL,
    [ShipAddr1]          CHAR (60)     NOT NULL,
    [ShipAddr2]          CHAR (60)     NOT NULL,
    [ShipAddrID]         CHAR (10)     NOT NULL,
    [ShipAddrSpecial]    SMALLINT      NOT NULL,
    [ShipAttn]           CHAR (30)     NOT NULL,
    [ShipCity]           CHAR (30)     NOT NULL,
    [ShipCmplt]          SMALLINT      NOT NULL,
    [ShipCountry]        CHAR (3)      NOT NULL,
    [ShipCustID]         CHAR (15)     NOT NULL,
    [ShipDateAct]        SMALLDATETIME NOT NULL,
    [ShipDatePlan]       SMALLDATETIME NOT NULL,
    [ShipGeoCode]        CHAR (10)     NOT NULL,
    [ShipName]           CHAR (60)     NOT NULL,
    [ShipperID]          CHAR (15)     NOT NULL,
    [ShipPhone]          CHAR (30)     NOT NULL,
    [ShippingConfirmed]  SMALLINT      NOT NULL,
    [ShippingManifested] SMALLINT      NOT NULL,
    [ShipRegisterID]     CHAR (10)     NOT NULL,
    [ShipSiteID]         CHAR (10)     NOT NULL,
    [ShipState]          CHAR (3)      NOT NULL,
    [ShiptoID]           CHAR (10)     NOT NULL,
    [ShiptoType]         CHAR (1)      NOT NULL,
    [ShipVendAddrID]     CHAR (10)     NOT NULL,
    [ShipVendID]         CHAR (15)     NOT NULL,
    [ShipViaID]          CHAR (15)     NOT NULL,
    [ShipZip]            CHAR (10)     NOT NULL,
    [SiteID]             CHAR (10)     NOT NULL,
    [SlsperID]           CHAR (10)     NOT NULL,
    [SOTypeID]           CHAR (4)      NOT NULL,
    [Status]             CHAR (1)      NOT NULL,
    [TaxID00]            CHAR (10)     NOT NULL,
    [TaxID01]            CHAR (10)     NOT NULL,
    [TaxID02]            CHAR (10)     NOT NULL,
    [TaxID03]            CHAR (10)     NOT NULL,
    [TermsID]            CHAR (2)      NOT NULL,
    [TotBoxes]           SMALLINT      NOT NULL,
    [TotCommCost]        FLOAT (53)    NOT NULL,
    [TotCost]            FLOAT (53)    NOT NULL,
    [TotFrtCost]         FLOAT (53)    NOT NULL,
    [TotFrtInvc]         FLOAT (53)    NOT NULL,
    [TotInvc]            FLOAT (53)    NOT NULL,
    [TotLineDisc]        FLOAT (53)    NOT NULL,
    [TotMerch]           FLOAT (53)    NOT NULL,
    [TotMisc]            FLOAT (53)    NOT NULL,
    [TotPallets]         SMALLINT      NOT NULL,
    [TotPmt]             FLOAT (53)    NOT NULL,
    [TotShipWght]        FLOAT (53)    NOT NULL,
    [TotTax]             FLOAT (53)    NOT NULL,
    [TotTxbl]            FLOAT (53)    NOT NULL,
    [TrackingNbr]        CHAR (25)     NOT NULL,
    [TransitTime]        SMALLINT      NOT NULL,
    [User1]              CHAR (30)     NOT NULL,
    [User10]             SMALLDATETIME NOT NULL,
    [User2]              CHAR (30)     NOT NULL,
    [User3]              CHAR (30)     NOT NULL,
    [User4]              CHAR (30)     NOT NULL,
    [User5]              FLOAT (53)    NOT NULL,
    [User6]              FLOAT (53)    NOT NULL,
    [User7]              CHAR (10)     NOT NULL,
    [User8]              CHAR (10)     NOT NULL,
    [User9]              SMALLDATETIME NOT NULL,
    [WeekendDelivery]    SMALLINT      NOT NULL,
    [WholeOrdDisc]       FLOAT (53)    NOT NULL,
    [WorkflowID]         INT           NOT NULL,
    [WorkflowStatus]     CHAR (1)      NOT NULL,
    [WSID]               INT           NOT NULL,
    [WSID01]             INT           NOT NULL,
    [Zone]               CHAR (6)      NOT NULL,
    [tstamp]             ROWVERSION    NOT NULL,
    CONSTRAINT [SOShipHeader0] PRIMARY KEY CLUSTERED ([CpnyID] ASC, [ShipperID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [SOShipHeader1]
    ON [dbo].[SOShipHeader]([CpnyID] ASC, [OrdNbr] ASC, [ShipperID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [SOShipHeader2]
    ON [dbo].[SOShipHeader]([CpnyID] ASC, [InvcNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [SOShipHeader3]
    ON [dbo].[SOShipHeader]([CpnyID] ASC, [OrdNbr] ASC, [OKToAppend] ASC, [SiteID] ASC, [ShipViaID] ASC, [ShiptoType] ASC, [ShiptoID] ASC, [ShipCustID] ASC, [ShipSiteID] ASC, [ShipVendID] ASC, [ShipAddrID] ASC, [WeekendDelivery] ASC, [MarkFor] ASC, [Status] ASC, [DropShip] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [SOShipHeader4]
    ON [dbo].[SOShipHeader]([Status] ASC, [CreditChk] ASC, [ShipSiteID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [SOShipHeader5]
    ON [dbo].[SOShipHeader]([CustID] ASC, [Status] ASC, [CpnyID] ASC, [ShipperID] ASC, [Cancelled] ASC, [ShipRegisterID] ASC, [InvcNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [SOShipHeader6]
    ON [dbo].[SOShipHeader]([ShipperID] ASC, [CpnyID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [SOShipHeader7]
    ON [dbo].[SOShipHeader]([ShipRegisterID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [SOShipHeader8]
    ON [dbo].[SOShipHeader]([CustID] ASC, [ShipRegisterID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [SOShipHeader9]
    ON [dbo].[SOShipHeader]([Status] ASC, [NextFunctionID] ASC, [NextFunctionClass] ASC, [OrdNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [SOShipHeader10]
    ON [dbo].[SOShipHeader]([Status] ASC, [BuildInvtID] ASC, [SiteID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [SOShipHeader11]
    ON [dbo].[SOShipHeader]([CreditHoldDate] ASC, [CreditHold] ASC, [CpnyID] ASC, [Status] ASC, [SiteID] ASC, [SlsperID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [SOShipHeader12]
    ON [dbo].[SOShipHeader]([INBatNbr] ASC, [CpnyID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [SOShipHeader13]
    ON [dbo].[SOShipHeader]([CpnyID] ASC, [SOTypeID] ASC, [ShipSiteID] ASC, [S4Future02] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [SOShipHeader14]
    ON [dbo].[SOShipHeader]([OrdDate] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [SOShipHeader15]
    ON [dbo].[SOShipHeader]([ShipDateAct] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [SOShipHeader16]
    ON [dbo].[SOShipHeader]([CpnyID] ASC, [SOTypeID] ASC, [CustID] ASC, [OrdDate] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [SOShipHeader17]
    ON [dbo].[SOShipHeader]([CpnyID] ASC, [ShipRegisterID] ASC, [Status] ASC, [ConsolInv] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [SOShipHeader18]
    ON [dbo].[SOShipHeader]([ProjectID] ASC, [Status] ASC) WITH (FILLFACTOR = 90);

