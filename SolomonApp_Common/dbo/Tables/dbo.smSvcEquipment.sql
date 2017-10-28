CREATE TABLE [dbo].[smSvcEquipment] (
    [AssetId]          CHAR (15)     NOT NULL,
    [Axles]            SMALLINT      NOT NULL,
    [BaseActCost]      FLOAT (53)    NOT NULL,
    [BranchId]         CHAR (10)     NOT NULL,
    [COGSAcct]         CHAR (10)     NOT NULL,
    [COGSSubAcct]      CHAR (24)     NOT NULL,
    [Condition]        CHAR (20)     NOT NULL,
    [ContactName]      CHAR (60)     NOT NULL,
    [ContactPhone]     CHAR (15)     NOT NULL,
    [ContractID]       CHAR (10)     NOT NULL,
    [ControlCount]     FLOAT (53)    NOT NULL,
    [CpnyID]           CHAR (10)     NOT NULL,
    [Crtd_DateTime]    SMALLDATETIME NOT NULL,
    [Crtd_Prog]        CHAR (8)      NOT NULL,
    [Crtd_User]        CHAR (10)     NOT NULL,
    [CustId]           CHAR (15)     NOT NULL,
    [DateInstalled]    SMALLDATETIME NOT NULL,
    [Descr]            CHAR (60)     NOT NULL,
    [Enhancement]      CHAR (10)     NOT NULL,
    [EnhancementDate]  SMALLDATETIME NOT NULL,
    [EQ_ID01]          CHAR (30)     NOT NULL,
    [EQ_ID02]          CHAR (30)     NOT NULL,
    [EQ_ID03]          CHAR (20)     NOT NULL,
    [EQ_ID04]          CHAR (20)     NOT NULL,
    [EQ_ID05]          CHAR (10)     NOT NULL,
    [EQ_ID06]          CHAR (10)     NOT NULL,
    [EQ_ID07]          CHAR (4)      NOT NULL,
    [EQ_ID08]          FLOAT (53)    NOT NULL,
    [EQ_ID09]          SMALLDATETIME NOT NULL,
    [EQ_ID10]          SMALLINT      NOT NULL,
    [EQ_ID11]          CHAR (30)     NOT NULL,
    [EQ_ID12]          CHAR (30)     NOT NULL,
    [EQ_ID13]          CHAR (20)     NOT NULL,
    [EQ_ID14]          CHAR (20)     NOT NULL,
    [EQ_ID15]          CHAR (10)     NOT NULL,
    [EQ_ID16]          CHAR (10)     NOT NULL,
    [EQ_ID17]          CHAR (4)      NOT NULL,
    [EQ_ID18]          FLOAT (53)    NOT NULL,
    [EQ_ID19]          SMALLDATETIME NOT NULL,
    [EQ_ID20]          SMALLINT      NOT NULL,
    [EquipID]          CHAR (10)     NOT NULL,
    [EquipTypeID]      CHAR (10)     NOT NULL,
    [ExtWarrEndDate]   SMALLDATETIME NOT NULL,
    [ExtWarrStartDate] SMALLDATETIME NOT NULL,
    [FuelType]         CHAR (1)      NOT NULL,
    [FuelTank1]        CHAR (15)     NOT NULL,
    [FuelTank2]        CHAR (15)     NOT NULL,
    [GVW]              FLOAT (53)    NOT NULL,
    [LaborCost]        FLOAT (53)    NOT NULL,
    [LaborSales]       FLOAT (53)    NOT NULL,
    [LastCallDate]     SMALLDATETIME NOT NULL,
    [LicenseNbr]       CHAR (15)     NOT NULL,
    [Location]         CHAR (50)     NOT NULL,
    [LocationID]       CHAR (10)     NOT NULL,
    [Lupd_DateTime]    SMALLDATETIME NOT NULL,
    [Lupd_Prog]        CHAR (8)      NOT NULL,
    [Lupd_User]        CHAR (10)     NOT NULL,
    [ManufId]          CHAR (10)     NOT NULL,
    [MaxMiles]         FLOAT (53)    NOT NULL,
    [MatlCost]         FLOAT (53)    NOT NULL,
    [MatlSales]        FLOAT (53)    NOT NULL,
    [MfgYear]          CHAR (4)      NOT NULL,
    [MiscCost]         FLOAT (53)    NOT NULL,
    [MiscSales]        FLOAT (53)    NOT NULL,
    [ModelId]          CHAR (40)     NOT NULL,
    [NoteId]           INT           NOT NULL,
    [OrdNbr]           CHAR (10)     NOT NULL,
    [ParentId]         CHAR (10)     NOT NULL,
    [PMCode]           CHAR (10)     NOT NULL,
    [PMScheduled]      SMALLINT      NOT NULL,
    [Price]            FLOAT (53)    NOT NULL,
    [PrimaryTech]      CHAR (10)     NOT NULL,
    [PurActCost]       FLOAT (53)    NOT NULL,
    [PurchAmount]      FLOAT (53)    NOT NULL,
    [PurchDate]        SMALLDATETIME NOT NULL,
    [PurchPONbr]       CHAR (10)     NOT NULL,
    [Quantity]         FLOAT (53)    NOT NULL,
    [Rate]             FLOAT (53)    NOT NULL,
    [RateFreq]         CHAR (2)      NOT NULL,
    [RegistrNbr]       CHAR (30)     NOT NULL,
    [Registrdate]      SMALLDATETIME NOT NULL,
    [RegistrSt]        CHAR (15)     NOT NULL,
    [RentCode]         CHAR (10)     NOT NULL,
    [RevAcct]          CHAR (10)     NOT NULL,
    [Revision]         CHAR (10)     NOT NULL,
    [RevisionDate]     SMALLDATETIME NOT NULL,
    [RevSubAcct]       CHAR (24)     NOT NULL,
    [SecondaryTech]    CHAR (10)     NOT NULL,
    [SerialNbr]        CHAR (30)     NOT NULL,
    [SiteId]           CHAR (10)     NOT NULL,
    [Status]           CHAR (1)      NOT NULL,
    [StatusDate]       SMALLDATETIME NOT NULL,
    [TareWeight]       FLOAT (53)    NOT NULL,
    [Type]             CHAR (1)      NOT NULL,
    [User1]            CHAR (30)     NOT NULL,
    [User2]            CHAR (30)     NOT NULL,
    [User3]            FLOAT (53)    NOT NULL,
    [User4]            FLOAT (53)    NOT NULL,
    [User5]            CHAR (10)     NOT NULL,
    [User6]            CHAR (10)     NOT NULL,
    [User7]            SMALLDATETIME NOT NULL,
    [User8]            SMALLDATETIME NOT NULL,
    [VendorID]         CHAR (15)     NOT NULL,
    [VIN]              CHAR (30)     NOT NULL,
    [WarrantyStatus]   CHAR (2)      NOT NULL,
    [WarrEndDate]      SMALLDATETIME NOT NULL,
    [WarrStartDate]    SMALLDATETIME NOT NULL,
    [WtCapacity]       FLOAT (53)    NOT NULL,
    [tstamp]           ROWVERSION    NOT NULL,
    CONSTRAINT [smSvcEquipment0] PRIMARY KEY CLUSTERED ([EquipID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [smSvcEquipment1]
    ON [dbo].[smSvcEquipment]([CustId] ASC, [SiteId] ASC, [EquipID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smSvcEquipment2]
    ON [dbo].[smSvcEquipment]([CustId] ASC, [EquipID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smSvcEquipment3]
    ON [dbo].[smSvcEquipment]([ContractID] ASC, [EquipID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smSvcEquipment4]
    ON [dbo].[smSvcEquipment]([SerialNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smSvcEquipment5]
    ON [dbo].[smSvcEquipment]([CustId] ASC, [SiteId] ASC, [ManufId] ASC, [ModelId] ASC, [EquipID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smSvcEquipment6]
    ON [dbo].[smSvcEquipment]([CpnyID] ASC, [CustId] ASC, [SiteId] ASC, [EquipID] ASC) WITH (FILLFACTOR = 90);

