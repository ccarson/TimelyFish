CREATE TABLE [dbo].[smRentHeader] (
    [Acct]           CHAR (10)     NOT NULL,
    [Basis]          CHAR (2)      NOT NULL,
    [BillCurrent]    FLOAT (53)    NOT NULL,
    [BillDate]       SMALLDATETIME NOT NULL,
    [BillingStatus]  CHAR (1)      NOT NULL,
    [BillLTD]        FLOAT (53)    NOT NULL,
    [BillPTD]        FLOAT (53)    NOT NULL,
    [BillYtd]        FLOAT (53)    NOT NULL,
    [BranchID]       CHAR (10)     NOT NULL,
    [Contact]        CHAR (30)     NOT NULL,
    [ContractID]     CHAR (10)     NOT NULL,
    [CpnyID]         CHAR (10)     NOT NULL,
    [Crtd_DateTime]  SMALLDATETIME NOT NULL,
    [Crtd_Prog]      CHAR (8)      NOT NULL,
    [Crtd_User]      CHAR (10)     NOT NULL,
    [CustId]         CHAR (15)     NOT NULL,
    [CustName]       CHAR (60)     NOT NULL,
    [CustOrdNbr]     CHAR (15)     NOT NULL,
    [DateClosed]     SMALLDATETIME NOT NULL,
    [DateStarted]    SMALLDATETIME NOT NULL,
    [EquipDescr]     CHAR (50)     NOT NULL,
    [EquipID]        CHAR (10)     NOT NULL,
    [Frequency]      CHAR (1)      NOT NULL,
    [Internal]       SMALLINT      NOT NULL,
    [LastDate]       SMALLDATETIME NOT NULL,
    [LineCounter]    SMALLINT      NOT NULL,
    [Location]       CHAR (50)     NOT NULL,
    [Lupd_DateTime]  SMALLDATETIME NOT NULL,
    [Lupd_Prog]      CHAR (8)      NOT NULL,
    [Lupd_User]      CHAR (10)     NOT NULL,
    [ManufID]        CHAR (10)     NOT NULL,
    [MiscChrg]       FLOAT (53)    NOT NULL,
    [MiscChrgBilled] SMALLINT      NOT NULL,
    [MiscDescr]      CHAR (40)     NOT NULL,
    [MiscType]       CHAR (1)      NOT NULL,
    [ModelID]        CHAR (40)     NOT NULL,
    [Multiplier]     FLOAT (53)    NOT NULL,
    [NoteID]         INT           NOT NULL,
    [PerNbr]         CHAR (6)      NOT NULL,
    [Phone]          CHAR (15)     NOT NULL,
    [ProjectID]      CHAR (16)     NOT NULL,
    [RentalID]       CHAR (10)     NOT NULL,
    [RH_ID01]        CHAR (30)     NOT NULL,
    [RH_ID02]        CHAR (30)     NOT NULL,
    [RH_ID03]        CHAR (20)     NOT NULL,
    [RH_ID04]        CHAR (20)     NOT NULL,
    [RH_ID05]        CHAR (10)     NOT NULL,
    [RH_ID06]        CHAR (10)     NOT NULL,
    [RH_ID07]        CHAR (4)      NOT NULL,
    [RH_ID08]        FLOAT (53)    NOT NULL,
    [RH_ID09]        SMALLDATETIME NOT NULL,
    [RH_ID10]        SMALLINT      NOT NULL,
    [SerialNbr]      CHAR (30)     NOT NULL,
    [Siteid]         CHAR (10)     NOT NULL,
    [SiteName]       CHAR (30)     NOT NULL,
    [SlsPerId]       CHAR (10)     NOT NULL,
    [Status]         CHAR (1)      NOT NULL,
    [Sub]            CHAR (24)     NOT NULL,
    [TaskId]         CHAR (32)     NOT NULL,
    [TransDate]      SMALLDATETIME NOT NULL,
    [TransId]        CHAR (10)     NOT NULL,
    [TransTime]      CHAR (4)      NOT NULL,
    [UpdateStatus]   SMALLINT      NOT NULL,
    [User1]          CHAR (30)     NOT NULL,
    [User2]          CHAR (30)     NOT NULL,
    [User3]          FLOAT (53)    NOT NULL,
    [User4]          FLOAT (53)    NOT NULL,
    [User5]          CHAR (10)     NOT NULL,
    [User6]          CHAR (10)     NOT NULL,
    [User7]          SMALLDATETIME NOT NULL,
    [User8]          SMALLDATETIME NOT NULL,
    [UserID]         CHAR (47)     NOT NULL,
    [tstamp]         ROWVERSION    NOT NULL,
    CONSTRAINT [smRentHeader0] PRIMARY KEY CLUSTERED ([TransId] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [smRentHeader_All]
    ON [dbo].[smRentHeader]([EquipID] ASC, [TransId] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smRentHeader_EquipID]
    ON [dbo].[smRentHeader]([EquipID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smRentHeader_CustID]
    ON [dbo].[smRentHeader]([CustId] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smRentHeader_SiteID]
    ON [dbo].[smRentHeader]([Siteid] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smRentHeader_CustName]
    ON [dbo].[smRentHeader]([CustName] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smRentHeader_SiteName]
    ON [dbo].[smRentHeader]([SiteName] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smRentHeader_CustOrdNbr]
    ON [dbo].[smRentHeader]([CustOrdNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smRentHeader_SerialNbr]
    ON [dbo].[smRentHeader]([SerialNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smRentHeader_Model]
    ON [dbo].[smRentHeader]([ModelID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smRentHeader_Manuf]
    ON [dbo].[smRentHeader]([ManufID] ASC, [ModelID] ASC) WITH (FILLFACTOR = 90);

