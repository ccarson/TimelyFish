CREATE TABLE [dbo].[cft_PM_HISTORY] (
    [PMHistoryID]       INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ActualQty]         SMALLINT      NULL,
    [ActualWgt]         SMALLINT      NULL,
    [ArrivalDate]       SMALLDATETIME NULL,
    [ArrivalTime]       SMALLDATETIME NULL,
    [BoardBackColor]    INT           NULL,
    [Comment]           CHAR (100)    NULL,
    [CpnyID]            CHAR (10)     NULL,
    [Crtd_DateTime]     SMALLDATETIME NULL,
    [Crtd_Prog]         CHAR (8)      NULL,
    [Crtd_User]         CHAR (10)     NULL,
    [DeleteFlag]        SMALLINT      NULL,
    [DestBarnNbr]       CHAR (10)     NULL,
    [DestContactID]     CHAR (10)     NULL,
    [DestPigGroupID]    CHAR (10)     NULL,
    [DestProject]       CHAR (16)     NULL,
    [DestRoomNbr]       CHAR (10)     NULL,
    [DestTask]          CHAR (32)     NULL,
    [DestTestStatus]    CHAR (1)      NULL,
    [DisinfectFlg]      SMALLINT      NULL,
    [EstimatedQty]      SMALLINT      NULL,
    [EstimatedWgt]      CHAR (7)      NULL,
    [GiltAge]           CHAR (10)     NULL,
    [Highlight]         INT           NULL,
    [ID]                INT           NULL,
    [LineNbr]           SMALLINT      NULL,
    [LoadingTime]       SMALLDATETIME NULL,
    [Lupd_DateTime]     SMALLDATETIME NULL,
    [Lupd_Prog]         CHAR (8)      NULL,
    [Lupd_User]         CHAR (10)     NULL,
    [MarketSaleTypeID]  CHAR (2)      NULL,
    [MovementDate]      SMALLDATETIME NULL,
    [NonUSOrigin]       SMALLINT      NULL,
    [OrdNbr]            CHAR (10)     NULL,
    [OrigMovementDate]  SMALLDATETIME NULL,
    [PFEUEligible]      SMALLINT      NULL,
    [PigFlowID]         CHAR (3)      NULL,
    [PigGenderTypeID]   CHAR (6)      NULL,
    [PigTrailerID]      CHAR (5)      NULL,
    [PigTypeID]         CHAR (2)      NULL,
    [PkrContactID]      CHAR (6)      NULL,
    [PMID]              CHAR (10)     NULL,
    [PMLoadID]          CHAR (10)     NULL,
    [PMSystemID]        CHAR (2)      NULL,
    [PMTypeID]          CHAR (2)      NULL,
    [PONbr]             CHAR (10)     NULL,
    [SourceBarnNbr]     CHAR (10)     NULL,
    [SourceContactID]   CHAR (10)     NULL,
    [SourcePigGroupID]  CHAR (10)     NULL,
    [SourceProject]     CHAR (16)     NULL,
    [SourceRoomNbr]     CHAR (10)     NULL,
    [SourceTask]        CHAR (32)     NULL,
    [SourceTestStatus]  CHAR (1)      NULL,
    [SuppressFlg]       SMALLINT      NULL,
    [Tailbite]          SMALLINT      NULL,
    [TattooFlag]        SMALLINT      NULL,
    [TrailerWashFlag]   SMALLINT      NULL,
    [TrailerWashStatus] SMALLINT      NULL,
    [TranSubTypeID]     CHAR (2)      NULL,
    [TruckerContactID]  CHAR (6)      NULL,
    [WalkThrough]       SMALLINT      NULL,
    [CreatedBy]         VARCHAR (50)  NULL,
    [CreatedDateTime]   DATETIME      CONSTRAINT [DF_cft_PM_HISTORY_CreatedDateTime] DEFAULT (getdate()) NULL,
    [SentChanges]       BIT           NULL,
    [tstamp]            ROWVERSION    NULL,
    CONSTRAINT [PK__cft_PM_HISTORY__3D12089E] PRIMARY KEY CLUSTERED ([PMHistoryID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [cft_PM_History0]
    ON [dbo].[cft_PM_HISTORY]([LineNbr] ASC, [ID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxcft_PM_History_CpnyID]
    ON [dbo].[cft_PM_HISTORY]([CpnyID] ASC, [MovementDate] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxcft_PM_History_PMTypeID]
    ON [dbo].[cft_PM_HISTORY]([PMTypeID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxcft_PM_History_PMSystemID]
    ON [dbo].[cft_PM_HISTORY]([PMSystemID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxcft_PM_History_MovementDate]
    ON [dbo].[cft_PM_HISTORY]([MovementDate] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxcft_PM_History_Highlight]
    ON [dbo].[cft_PM_HISTORY]([Highlight] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxcft_PM_History_PigTypeId]
    ON [dbo].[cft_PM_HISTORY]([PigTypeID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxcft_PM_History_SuppressFlg]
    ON [dbo].[cft_PM_HISTORY]([SuppressFlg] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxcft_PM_History_TrailerWashFlag]
    ON [dbo].[cft_PM_HISTORY]([TrailerWashFlag] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxcft_PM_History_PigTrailerID]
    ON [dbo].[cft_PM_HISTORY]([PigTrailerID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [cft_PM_HistoryDestGroup]
    ON [dbo].[cft_PM_HISTORY]([DestPigGroupID] ASC, [MovementDate] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxcft_PM_History_PMID]
    ON [dbo].[cft_PM_HISTORY]([PMID] ASC, [SentChanges] ASC) WITH (FILLFACTOR = 90);

