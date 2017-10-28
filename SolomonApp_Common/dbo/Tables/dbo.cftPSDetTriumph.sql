CREATE TABLE [dbo].[cftPSDetTriumph] (
    [AddDelete]          CHAR (1)      NOT NULL,
    [BackfatDepth]       FLOAT (53)    NOT NULL,
    [CarcassNbr]         INT           NOT NULL,
    [CarcBasePrice]      FLOAT (53)    NULL,
    [CarcBasePriceAmt]   FLOAT (53)    NOT NULL,
    [FixedFactorAmt]     FLOAT (53)    NOT NULL,
    [FixedtFactorPct]    FLOAT (53)    NOT NULL,
    [FixedFactorPerCWT]  FLOAT (53)    NOT NULL,
    [HotWgt]             FLOAT (53)    NOT NULL,
    [InputFileName]      CHAR (30)     NOT NULL,
    [KillDate]           SMALLDATETIME NOT NULL,
    [LeanDiscAmt]        FLOAT (53)    NOT NULL,
    [LeanDiscPerCWT]     FLOAT (53)    NOT NULL,
    [LeanFactor]         FLOAT (53)    NOT NULL,
    [LeanPct]            FLOAT (53)    NOT NULL,
    [LoadNbr]            CHAR (10)     NOT NULL,
    [LoinDepth]          FLOAT (53)    NOT NULL,
    [OrdNbr]             CHAR (10)     NOT NULL,
    [PayAmt]             FLOAT (53)    NOT NULL,
    [PayAmtPerCWT]       FLOAT (53)    NOT NULL,
    [PlantNbr]           CHAR (10)     NOT NULL,
    [RecordID]           INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [SortAmt]            FLOAT (53)    NOT NULL,
    [SortFactor]         FLOAT (53)    NOT NULL,
    [SortPerCWT]         FLOAT (53)    NOT NULL,
    [StdYield]           SMALLINT      NOT NULL,
    [TattooNbr]          CHAR (10)     NOT NULL,
    [TrimArea]           SMALLINT      NOT NULL,
    [ValueFactorAmt]     FLOAT (53)    NOT NULL,
    [ValueFactorPct]     FLOAT (53)    NOT NULL,
    [ValueFactortPerCWT] FLOAT (53)    NOT NULL,
    [tstamp]             ROWVERSION    NULL,
    CONSTRAINT [cftPSDetTriumph0] PRIMARY KEY CLUSTERED ([RecordID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [cftPSDetTriumph_IDX01]
    ON [dbo].[cftPSDetTriumph]([KillDate] ASC, [TattooNbr] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IDX_cftPSDetTriumph_killdate_incl]
    ON [dbo].[cftPSDetTriumph]([KillDate] ASC)
    INCLUDE([HotWgt], [PlantNbr], [TattooNbr]) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxcftPSDetTriumph_InputFileName]
    ON [dbo].[cftPSDetTriumph]([InputFileName] ASC) WITH (FILLFACTOR = 90);

