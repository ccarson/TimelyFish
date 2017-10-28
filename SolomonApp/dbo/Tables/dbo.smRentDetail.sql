CREATE TABLE [dbo].[smRentDetail] (
    [BillingDate]   SMALLDATETIME NOT NULL,
    [BillStatus]    CHAR (1)      NOT NULL,
    [BranchID]      CHAR (10)     NOT NULL,
    [CallGenerated] SMALLINT      NOT NULL,
    [CallHandling]  CHAR (1)      NOT NULL,
    [CallPriority]  CHAR (1)      NOT NULL,
    [CallStatus]    CHAR (10)     NOT NULL,
    [CallType]      CHAR (10)     NOT NULL,
    [Condition]     CHAR (30)     NOT NULL,
    [Contact]       CHAR (30)     NOT NULL,
    [Contractid]    CHAR (10)     NOT NULL,
    [CpnyID]        CHAR (10)     NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [CustId]        CHAR (15)     NOT NULL,
    [CustName]      CHAR (60)     NOT NULL,
    [CustOrdNbr]    CHAR (15)     NOT NULL,
    [Equipdescr]    CHAR (50)     NOT NULL,
    [EquipID]       CHAR (10)     NOT NULL,
    [ExtraBilled]   SMALLINT      NOT NULL,
    [ExtraCharge]   FLOAT (53)    NOT NULL,
    [ExtraDescr]    CHAR (30)     NOT NULL,
    [FaultCode]     CHAR (10)     NOT NULL,
    [Frequency]     CHAR (1)      NOT NULL,
    [GenServCall]   SMALLINT      NOT NULL,
    [Handing]       CHAR (1)      NOT NULL,
    [InvoiceLineID] SMALLINT      NOT NULL,
    [InvoiceNbr]    CHAR (10)     NOT NULL,
    [LastBillAmt]   FLOAT (53)    NOT NULL,
    [LineID]        SMALLINT      NOT NULL,
    [Location]      CHAR (50)     NOT NULL,
    [Lupd_DateTIme] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [Multiplier]    FLOAT (53)    NOT NULL,
    [NoteID]        INT           NOT NULL,
    [OrdNbr]        CHAR (10)     NOT NULL,
    [Phone]         CHAR (15)     NOT NULL,
    [PMCode]        CHAR (10)     NOT NULL,
    [PrimaryTech]   CHAR (10)     NOT NULL,
    [ProjectID]     CHAR (16)     NOT NULL,
    [PromiseDate]   SMALLDATETIME NOT NULL,
    [RentalId]      CHAR (10)     NOT NULL,
    [RevAcct]       CHAR (10)     NOT NULL,
    [RevSub]        CHAR (24)     NOT NULL,
    [RI_ID]         SMALLINT      NOT NULL,
    [Serialnbr]     CHAR (30)     NOT NULL,
    [ServCall]      SMALLINT      NOT NULL,
    [SiteID]        CHAR (10)     NOT NULL,
    [SiteName]      CHAR (30)     NOT NULL,
    [SlsPerId]      CHAR (10)     NOT NULL,
    [StartDate]     SMALLDATETIME NOT NULL,
    [TaskId]        CHAR (32)     NOT NULL,
    [TimeEntered]   CHAR (8)      NOT NULL,
    [TimeFrom]      CHAR (4)      NOT NULL,
    [TimeFromAMPM]  CHAR (4)      NOT NULL,
    [TimeTo]        CHAR (4)      NOT NULL,
    [TimeToAMPM]    CHAR (4)      NOT NULL,
    [TransDate]     SMALLDATETIME NOT NULL,
    [TransId]       CHAR (10)     NOT NULL,
    [TransStatus]   CHAR (1)      NOT NULL,
    [transTime]     CHAR (4)      NOT NULL,
    [Traveler]      SMALLINT      NOT NULL,
    [TravelerFlag]  SMALLINT      NOT NULL,
    [Type]          CHAR (1)      NOT NULL,
    [User1]         CHAR (30)     NOT NULL,
    [User2]         CHAR (30)     NOT NULL,
    [User3]         FLOAT (53)    NOT NULL,
    [User4]         FLOAT (53)    NOT NULL,
    [User5]         CHAR (10)     NOT NULL,
    [User6]         CHAR (10)     NOT NULL,
    [User7]         SMALLDATETIME NOT NULL,
    [User8]         SMALLDATETIME NOT NULL,
    [UserID]        CHAR (47)     NOT NULL,
    [Void]          SMALLINT      NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [smRentDetail0] PRIMARY KEY CLUSTERED ([TransId] ASC, [LineID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [smRentDetail_Equip]
    ON [dbo].[smRentDetail]([EquipID] ASC, [TransId] ASC, [LineID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smRentDetail_Code]
    ON [dbo].[smRentDetail]([RentalId] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smRentDetail_History]
    ON [dbo].[smRentDetail]([EquipID] ASC, [StartDate] ASC, [LineID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smRentDetail_Transid]
    ON [dbo].[smRentDetail]([EquipID] ASC, [TransId] ASC, [StartDate] ASC, [LineID] ASC) WITH (FILLFACTOR = 90);

