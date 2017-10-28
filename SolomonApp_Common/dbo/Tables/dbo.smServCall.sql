CREATE TABLE [dbo].[smServCall] (
    [AdjustLabor]          FLOAT (53)    NOT NULL,
    [AdjustTM]             FLOAT (53)    NOT NULL,
    [AltCustID]            CHAR (15)     NOT NULL,
    [AmountFRTM]           FLOAT (53)    NOT NULL,
    [AmountLabor]          FLOAT (53)    NOT NULL,
    [ASID]                 INT           NOT NULL,
    [AssignEmpID]          CHAR (10)     NOT NULL,
    [BillDay]              CHAR (2)      NOT NULL,
    [BillDayofMonth]       CHAR (2)      NOT NULL,
    [BillFrequency]        CHAR (1)      NOT NULL,
    [BillingType]          CHAR (1)      NOT NULL,
    [BranchID]             CHAR (10)     NOT NULL,
    [CallerName]           CHAR (60)     NOT NULL,
    [CallStatus]           CHAR (10)     NOT NULL,
    [CallType]             CHAR (10)     NOT NULL,
    [chkbChargeCustomer]   SMALLINT      NOT NULL,
    [chkbChargeJobProject] SMALLINT      NOT NULL,
    [chkbChargeSvcContrct] SMALLINT      NOT NULL,
    [chkbNonChargeable]    SMALLINT      NOT NULL,
    [chkbValidateDetail]   SMALLINT      NOT NULL,
    [cmbCODInvoice]        CHAR (1)      NOT NULL,
    [cmbInvoiceType]       CHAR (1)      NOT NULL,
    [Comments]             CHAR (60)     NOT NULL,
    [CompleteDate]         SMALLDATETIME NOT NULL,
    [CompletedNotReview]   CHAR (1)      NOT NULL,
    [CompleteTime]         CHAR (4)      NOT NULL,
    [CompleteUserID]       CHAR (47)     NOT NULL,
    [ContractID]           CHAR (10)     NOT NULL,
    [ContractType]         CHAR (10)     NOT NULL,
    [ControlAmount]        FLOAT (53)    NOT NULL,
    [CostFRTM]             FLOAT (53)    NOT NULL,
    [CostLabor]            FLOAT (53)    NOT NULL,
    [CouponID]             CHAR (10)     NOT NULL,
    [CpnyID]               CHAR (10)     NOT NULL,
    [CreditCardExpDate]    SMALLDATETIME NOT NULL,
    [Crtd_DateTime]        SMALLDATETIME NOT NULL,
    [Crtd_Prog]            CHAR (8)      NOT NULL,
    [Crtd_User]            CHAR (10)     NOT NULL,
    [CustAvgRevenue]       FLOAT (53)    NOT NULL,
    [CustCity]             CHAR (30)     NOT NULL,
    [CustDwelling]         CHAR (10)     NOT NULL,
    [CustGeographicID]     CHAR (10)     NOT NULL,
    [CustMapCoord]         CHAR (10)     NOT NULL,
    [CustMapPage]          CHAR (10)     NOT NULL,
    [CustName]             CHAR (60)     NOT NULL,
    [CustomerId]           CHAR (15)     NOT NULL,
    [CustomerPO]           CHAR (20)     NOT NULL,
    [CustomerSatisfied]    SMALLINT      NOT NULL,
    [CustPhone]            CHAR (15)     NOT NULL,
    [CustPromiseTimeMi]    CHAR (4)      NOT NULL,
    [DiscAmount]           FLOAT (53)    NOT NULL,
    [DiscPercent]          FLOAT (53)    NOT NULL,
    [Duration]             CHAR (4)      NOT NULL,
    [EndDate]              SMALLDATETIME NOT NULL,
    [EndTime]              CHAR (4)      NOT NULL,
    [ExtBatNbr]            CHAR (10)     NOT NULL,
    [ExtRefDate]           SMALLDATETIME NOT NULL,
    [ExtRefnbr]            CHAR (10)     NOT NULL,
    [ExtRefTime]           CHAR (4)      NOT NULL,
    [HrsBilled]            FLOAT (53)    NOT NULL,
    [HrsWorked]            FLOAT (53)    NOT NULL,
    [InvoiceAmount]        FLOAT (53)    NOT NULL,
    [InvoiceFlag]          SMALLINT      NOT NULL,
    [InvoiceHandling]      CHAR (1)      NOT NULL,
    [InvoiceNumber]        CHAR (10)     NOT NULL,
    [InvoiceStatus]        CHAR (1)      NOT NULL,
    [LastInvoiceDate]      SMALLDATETIME NOT NULL,
    [Latitude]             CHAR (10)     NOT NULL,
    [LineCntr]             SMALLINT      NOT NULL,
    [Longitude]            CHAR (10)     NOT NULL,
    [Lupd_DateTime]        SMALLDATETIME NOT NULL,
    [Lupd_Prog]            CHAR (8)      NOT NULL,
    [Lupd_User]            CHAR (10)     NOT NULL,
    [MediaGroupId]         CHAR (10)     NOT NULL,
    [NoteID]               INT           NOT NULL,
    [OrderDate]            SMALLDATETIME NOT NULL,
    [OrdNbr]               CHAR (10)     NOT NULL,
    [OrigCallID]           CHAR (10)     NOT NULL,
    [PaymentMethod]        CHAR (1)      NOT NULL,
    [PaymentNumber]        CHAR (20)     NOT NULL,
    [PerEnt]               CHAR (6)      NOT NULL,
    [PMCode]               CHAR (10)     NOT NULL,
    [PMFlag]               CHAR (1)      NOT NULL,
    [PostToPeriod]         CHAR (6)      NOT NULL,
    [PrimaryFaultCode]     CHAR (10)     NOT NULL,
    [ProcessedBy]          CHAR (30)     NOT NULL,
    [ProcessedDate]        SMALLDATETIME NOT NULL,
    [ProjectID]            CHAR (16)     NOT NULL,
    [PromiseTimeAMPM]      CHAR (1)      NOT NULL,
    [PromiseTimeTOAMPM]    CHAR (1)      NOT NULL,
    [PromTimeFrom]         CHAR (4)      NOT NULL,
    [PromTimeTo]           CHAR (4)      NOT NULL,
    [ReadyToInvoice]       SMALLINT      NOT NULL,
    [RepeatDays]           CHAR (10)     NOT NULL,
    [ReviewedBy]           CHAR (30)     NOT NULL,
    [ReviewedDate]         SMALLDATETIME NOT NULL,
    [RI_ID]                SMALLINT      NOT NULL,
    [RouteID]              CHAR (10)     NOT NULL,
    [SC_ID01]              CHAR (30)     NOT NULL,
    [SC_ID02]              CHAR (30)     NOT NULL,
    [SC_ID03]              CHAR (20)     NOT NULL,
    [SC_ID04]              CHAR (20)     NOT NULL,
    [SC_ID05]              CHAR (10)     NOT NULL,
    [SC_ID06]              CHAR (10)     NOT NULL,
    [SC_ID07]              CHAR (4)      NOT NULL,
    [SC_ID08]              FLOAT (53)    NOT NULL,
    [SC_ID09]              SMALLDATETIME NOT NULL,
    [SC_ID10]              SMALLINT      NOT NULL,
    [SC_ID11]              CHAR (30)     NOT NULL,
    [SC_ID12]              CHAR (30)     NOT NULL,
    [SC_ID13]              CHAR (20)     NOT NULL,
    [SC_ID14]              CHAR (20)     NOT NULL,
    [SC_ID15]              CHAR (10)     NOT NULL,
    [SC_ID16]              CHAR (10)     NOT NULL,
    [SC_ID17]              CHAR (4)      NOT NULL,
    [SC_ID18]              FLOAT (53)    NOT NULL,
    [SC_ID19]              SMALLDATETIME NOT NULL,
    [SC_ID20]              SMALLINT      NOT NULL,
    [SecurityEntryCode]    CHAR (30)     NOT NULL,
    [ServiceCallCompleted] SMALLINT      NOT NULL,
    [ServiceCallDate]      SMALLDATETIME NOT NULL,
    [ServiceCallDateProm]  SMALLDATETIME NOT NULL,
    [ServiceCallDuration]  CHAR (1)      NOT NULL,
    [ServiceCallID]        CHAR (10)     NOT NULL,
    [ServiceCallPriority]  CHAR (1)      NOT NULL,
    [ServiceCallStatus]    CHAR (1)      NOT NULL,
    [ServiceCallTime]      CHAR (4)      NOT NULL,
    [ShiptoId]             CHAR (10)     NOT NULL,
    [SiteAddr1]            CHAR (60)     NOT NULL,
    [SiteAddr2]            CHAR (60)     NOT NULL,
    [SiteCity]             CHAR (30)     NOT NULL,
    [SiteCountry]          CHAR (3)      NOT NULL,
    [SiteFax]              CHAR (30)     NOT NULL,
    [SiteName]             CHAR (60)     NOT NULL,
    [SitePhone]            CHAR (30)     NOT NULL,
    [SiteState]            CHAR (3)      NOT NULL,
    [SiteZip]              CHAR (10)     NOT NULL,
    [SlsperID]             CHAR (10)     NOT NULL,
    [SourceCallID]         CHAR (10)     NOT NULL,
    [SSNoteID]             INT           NOT NULL,
    [StartDate]            SMALLDATETIME NOT NULL,
    [StartTime]            CHAR (4)      NOT NULL,
    [TaxAmt00]             FLOAT (53)    NOT NULL,
    [TaxAmt01]             FLOAT (53)    NOT NULL,
    [TaxAmt02]             FLOAT (53)    NOT NULL,
    [TaxAmt03]             FLOAT (53)    NOT NULL,
    [TaxCntr00]            SMALLINT      NOT NULL,
    [TaxCntr01]            SMALLINT      NOT NULL,
    [TaxCntr02]            SMALLINT      NOT NULL,
    [TaxCntr03]            SMALLINT      NOT NULL,
    [TaxFRTM]              FLOAT (53)    NOT NULL,
    [TaxId00]              CHAR (10)     NOT NULL,
    [TaxId01]              CHAR (10)     NOT NULL,
    [TaxId02]              CHAR (10)     NOT NULL,
    [TaxId03]              CHAR (10)     NOT NULL,
    [TaxLabor]             FLOAT (53)    NOT NULL,
    [TaxTot]               FLOAT (53)    NOT NULL,
    [TermID]               CHAR (2)      NOT NULL,
    [TimeZoneID]           CHAR (10)     NOT NULL,
    [TxblAmt00]            FLOAT (53)    NOT NULL,
    [TxblAmt01]            FLOAT (53)    NOT NULL,
    [TxblAmt02]            FLOAT (53)    NOT NULL,
    [TxblAmt03]            FLOAT (53)    NOT NULL,
    [User1]                CHAR (30)     NOT NULL,
    [User2]                CHAR (30)     NOT NULL,
    [User3]                FLOAT (53)    NOT NULL,
    [USer4]                FLOAT (53)    NOT NULL,
    [User5]                CHAR (10)     NOT NULL,
    [User6]                CHAR (10)     NOT NULL,
    [User7]                SMALLDATETIME NOT NULL,
    [User8]                SMALLDATETIME NOT NULL,
    [User9]                SMALLINT      NOT NULL,
    [UserID]               CHAR (47)     NOT NULL,
    [WrkOrdNbr]            CHAR (10)     NOT NULL,
    [tstamp]               ROWVERSION    NOT NULL,
    CONSTRAINT [smServCall0] PRIMARY KEY CLUSTERED ([ServiceCallID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [smServCall23]
    ON [dbo].[smServCall]([StartDate] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smServCall24]
    ON [dbo].[smServCall]([StartTime] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smServCall3]
    ON [dbo].[smServCall]([InvoiceNumber] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smServCall4]
    ON [dbo].[smServCall]([CustomerId] ASC, [ShiptoId] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smServCall5]
    ON [dbo].[smServCall]([ServiceCallCompleted] ASC, [CustomerId] ASC, [ShiptoId] ASC, [ServiceCallID] ASC, [ServiceCallDateProm] ASC) WITH (FILLFACTOR = 90);


GO
CREATE UNIQUE NONCLUSTERED INDEX [smServCall6]
    ON [dbo].[smServCall]([ServiceCallID] ASC, [ServiceCallCompleted] ASC) WITH (FILLFACTOR = 90);


GO
CREATE UNIQUE NONCLUSTERED INDEX [smServCall7]
    ON [dbo].[smServCall]([CustomerId] ASC, [ServiceCallID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smServCall_CompleteDate]
    ON [dbo].[smServCall]([CompleteDate] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smServcall_Contract1]
    ON [dbo].[smServCall]([ContractID] ASC, [chkbChargeSvcContrct] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smServCall_CustomerPO]
    ON [dbo].[smServCall]([CustomerPO] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smServCall_GDB1]
    ON [dbo].[smServCall]([BranchID] ASC, [ServiceCallCompleted] ASC, [ServiceCallStatus] ASC, [ServiceCallDateProm] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smServCall_GDB2]
    ON [dbo].[smServCall]([CustGeographicID] ASC, [ServiceCallCompleted] ASC, [ServiceCallStatus] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smServCall_InvoiceType]
    ON [dbo].[smServCall]([CpnyID] ASC, [ServiceCallID] ASC, [cmbInvoiceType] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smServCall_Ordnbr]
    ON [dbo].[smServCall]([OrdNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smServCall_PostToPeriod]
    ON [dbo].[smServCall]([PostToPeriod] ASC, [InvoiceFlag] ASC, [InvoiceHandling] ASC, [InvoiceStatus] ASC, [RI_ID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smServCall1]
    ON [dbo].[smServCall]([AssignEmpID] ASC, [CallStatus] ASC, [CallType] ASC, [CustAvgRevenue] ASC, [CustPromiseTimeMi] ASC, [PromiseTimeAMPM] ASC, [ReadyToInvoice] ASC, [ServiceCallDate] ASC, [ServiceCallDateProm] ASC, [ServiceCallID] ASC, [ServiceCallPriority] ASC, [ServiceCallTime] ASC, [PromTimeFrom] ASC, [StartDate] ASC, [StartTime] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smServCall12]
    ON [dbo].[smServCall]([CallStatus] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smServCall13]
    ON [dbo].[smServCall]([CallType] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smServCall14]
    ON [dbo].[smServCall]([CustAvgRevenue] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smServCall15]
    ON [dbo].[smServCall]([CustPromiseTimeMi] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smServCall16]
    ON [dbo].[smServCall]([PromiseTimeAMPM] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smServCall17]
    ON [dbo].[smServCall]([ReadyToInvoice] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smServCall18]
    ON [dbo].[smServCall]([ServiceCallDate] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smServCall2]
    ON [dbo].[smServCall]([ServiceCallDateProm] ASC, [PromTimeFrom] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smServCall20]
    ON [dbo].[smServCall]([ServiceCallPriority] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smServCall21]
    ON [dbo].[smServCall]([ServiceCallTime] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smServCall22]
    ON [dbo].[smServCall]([PromTimeFrom] ASC) WITH (FILLFACTOR = 90);

