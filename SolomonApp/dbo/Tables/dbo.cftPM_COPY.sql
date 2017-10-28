CREATE TABLE [dbo].[cftPM_COPY] (
    [ActualQty]                   SMALLINT      NOT NULL,
    [ActualWgt]                   SMALLINT      NOT NULL,
    [ArrivalDate]                 SMALLDATETIME NOT NULL,
    [ArrivalTime]                 SMALLDATETIME NOT NULL,
    [BoardBackColor]              INT           NOT NULL,
    [Comment]                     CHAR (100)    NOT NULL,
    [CpnyID]                      CHAR (10)     NOT NULL,
    [Crtd_DateTime]               SMALLDATETIME NOT NULL,
    [Crtd_Prog]                   CHAR (8)      NOT NULL,
    [Crtd_User]                   CHAR (10)     NOT NULL,
    [DeleteFlag]                  SMALLINT      NOT NULL,
    [DestBarnNbr]                 CHAR (10)     NOT NULL,
    [DestContactID]               CHAR (10)     NOT NULL,
    [DestPigGroupID]              CHAR (10)     NOT NULL,
    [DestProject]                 CHAR (16)     NOT NULL,
    [DestRoomNbr]                 CHAR (10)     NOT NULL,
    [DestTask]                    CHAR (32)     NOT NULL,
    [DestTestStatus]              CHAR (1)      NOT NULL,
    [DisinfectFlg]                SMALLINT      NOT NULL,
    [EstimatedQty]                SMALLINT      NOT NULL,
    [EstimatedWgt]                CHAR (7)      NOT NULL,
    [GiltAge]                     CHAR (10)     NOT NULL,
    [Highlight]                   INT           NOT NULL,
    [ID]                          INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [LineNbr]                     SMALLINT      NOT NULL,
    [LoadingTime]                 SMALLDATETIME NOT NULL,
    [Lupd_DateTime]               SMALLDATETIME NOT NULL,
    [Lupd_Prog]                   CHAR (8)      NOT NULL,
    [Lupd_User]                   CHAR (10)     NOT NULL,
    [MarketSaleTypeID]            CHAR (2)      NOT NULL,
    [MovementDate]                SMALLDATETIME NOT NULL,
    [NonUSOrigin]                 SMALLINT      NOT NULL,
    [OrdNbr]                      CHAR (10)     NOT NULL,
    [OrigMovementDate]            SMALLDATETIME NOT NULL,
    [PFEUEligible]                SMALLINT      NOT NULL,
    [PigFlowID]                   CHAR (3)      NOT NULL,
    [PigGenderTypeID]             CHAR (6)      NOT NULL,
    [PigTrailerID]                CHAR (5)      NOT NULL,
    [PigTypeID]                   CHAR (2)      NOT NULL,
    [PkrContactID]                CHAR (6)      NOT NULL,
    [PMID]                        CHAR (10)     NOT NULL,
    [PMLoadID]                    CHAR (10)     NOT NULL,
    [PMSystemID]                  CHAR (2)      NOT NULL,
    [PMTypeID]                    CHAR (2)      NOT NULL,
    [PONbr]                       CHAR (10)     NOT NULL,
    [SourceBarnNbr]               CHAR (10)     NOT NULL,
    [SourceContactID]             CHAR (10)     NOT NULL,
    [SourcePigGroupID]            CHAR (10)     NOT NULL,
    [SourceProject]               CHAR (16)     NOT NULL,
    [SourceRoomNbr]               CHAR (10)     NOT NULL,
    [SourceTask]                  CHAR (32)     NOT NULL,
    [SourceTestStatus]            CHAR (1)      NOT NULL,
    [SuppressFlg]                 SMALLINT      NOT NULL,
    [Tailbite]                    SMALLINT      NOT NULL,
    [TattooFlag]                  SMALLINT      NOT NULL,
    [TrailerDestinationContactID] CHAR (6)      NULL,
    [TrailerSourceContactID]      CHAR (6)      NULL,
    [TrailerWashFlag]             SMALLINT      NOT NULL,
    [TrailerWashStatus]           SMALLINT      NOT NULL,
    [TranSubTypeID]               CHAR (2)      NOT NULL,
    [TruckerContactID]            CHAR (6)      NOT NULL,
    [WalkThrough]                 SMALLINT      NOT NULL,
    [tstamp]                      ROWVERSION    NULL,
    CONSTRAINT [cftPM_COPY0] PRIMARY KEY CLUSTERED ([LineNbr] ASC, [ID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [idxcftPM_COPY_CpnyID]
    ON [dbo].[cftPM_COPY]([CpnyID] ASC, [MovementDate] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxcftPM_COPY_PMTypeID]
    ON [dbo].[cftPM_COPY]([PMTypeID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxcftPM_COPY_PMSystemID]
    ON [dbo].[cftPM_COPY]([PMSystemID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxcftPM_COPY_MovementDate]
    ON [dbo].[cftPM_COPY]([MovementDate] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxcftPM_COPY_Highlight]
    ON [dbo].[cftPM_COPY]([Highlight] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxcftPM_COPY_PigTypeId]
    ON [dbo].[cftPM_COPY]([PigTypeID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxcftPM_COPY_SuppressFlg]
    ON [dbo].[cftPM_COPY]([SuppressFlg] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxcftPM_COPY_TrailerWashFlag]
    ON [dbo].[cftPM_COPY]([TrailerWashFlag] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxcftPM_COPY_PigTrailerID]
    ON [dbo].[cftPM_COPY]([PigTrailerID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [cftPM_COPYDestGroup]
    ON [dbo].[cftPM_COPY]([DestPigGroupID] ASC, [MovementDate] ASC) WITH (FILLFACTOR = 90);

