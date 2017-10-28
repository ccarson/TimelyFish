CREATE TABLE [dbo].[cftPM] (
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
    CONSTRAINT [PK_cftPM] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE UNIQUE CLUSTERED INDEX [cftPM0]
    ON [dbo].[cftPM]([LineNbr] ASC, [ID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxcftPM_CpnyID]
    ON [dbo].[cftPM]([CpnyID] ASC, [MovementDate] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [idxcftPM_PMTypeID]
    ON [dbo].[cftPM]([PMTypeID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxcftPM_PMSystemID]
    ON [dbo].[cftPM]([PMSystemID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxcftPM_MovementDate]
    ON [dbo].[cftPM]([MovementDate] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [idxcftPM_Highlight]
    ON [dbo].[cftPM]([Highlight] ASC, [PMID] ASC)
    INCLUDE([DestContactID], [MovementDate], [SourceBarnNbr], [TranSubTypeID]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [idxcftPM_PigTypeId]
    ON [dbo].[cftPM]([PigTypeID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxcftPM_SuppressFlg]
    ON [dbo].[cftPM]([SuppressFlg] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxcftPM_TrailerWashFlag]
    ON [dbo].[cftPM]([TrailerWashFlag] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxcftPM_PigTrailerID]
    ON [dbo].[cftPM]([PigTrailerID] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [cftPMDestGroup]
    ON [dbo].[cftPM]([DestPigGroupID] ASC, [MovementDate] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [IX_cftPM_x1]
    ON [dbo].[cftPM]([SourceContactID] ASC)
    INCLUDE([DestContactID], [ID]);


GO
CREATE NONCLUSTERED INDEX [idxcftPM_Highlight_02]
    ON [dbo].[cftPM]([Highlight] ASC)
    INCLUDE([Comment], [DestContactID], [LoadingTime], [MovementDate], [PigTypeID], [PMLoadID], [SourceContactID], [TruckerContactID]);


GO
CREATE NONCLUSTERED INDEX [idxcftPM_Crtd_DateTime]
    ON [dbo].[cftPM]([Crtd_DateTime] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxcftPM_Lupd_DateTime]
    ON [dbo].[cftPM]([Lupd_DateTime] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [idxcftPM_PMLoadID]
    ON [dbo].[cftPM]([PMLoadID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxcftPM_ID]
    ON [dbo].[cftPM]([ID] ASC)
    INCLUDE([TruckerContactID], [ArrivalTime], [DestContactID]) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxcftPMPMID]
    ON [dbo].[cftPM]([PMID] ASC)
    INCLUDE([ActualQty], [ActualWgt], [Lupd_DateTime], [Lupd_Prog], [Lupd_User], [DestContactID], [MovementDate], [PMTypeID], [SourceContactID]) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxcftPM_pxt300_list]
    ON [dbo].[cftPM]([MovementDate] ASC, [PMTypeID] ASC, [PMSystemID] ASC, [Highlight] ASC)
    INCLUDE([SourceContactID], [DestContactID], [TranSubTypeID]) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [idxcftpm_sourcepiggroupid_hi_mv_incl]
    ON [dbo].[cftPM]([SourcePigGroupID] ASC, [Highlight] ASC, [MovementDate] ASC)
    INCLUDE([EstimatedQty], [EstimatedWgt]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [idx_cftPM_PMTypeID_include]
    ON [dbo].[cftPM]([PMTypeID] ASC)
    INCLUDE([MovementDate], [PMID], [SourceContactID], [TranSubTypeID]) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [IX_cftPM_InterstatePigMovements]
    ON [dbo].[cftPM]([Highlight] ASC, [PigTypeID] ASC, [TattooFlag] ASC) WITH (FILLFACTOR = 100);

