CREATE TABLE [dbo].[cftPSDetTyson] (
    [AvgFatDepth]         FLOAT (53)    NOT NULL,
    [AvgLeanPercent]      FLOAT (53)    NOT NULL,
    [AvgLoinDepth]        FLOAT (53)    NOT NULL,
    [CarcassSort]         SMALLINT      NOT NULL,
    [CarcassValue]        FLOAT (53)    NOT NULL,
    [CarcassValueCwt]     FLOAT (53)    NOT NULL,
    [DiscBaseMeatPercent] FLOAT (53)    NOT NULL,
    [HighWeightRange]     SMALLINT      NOT NULL,
    [HotCarcassWeight]    FLOAT (53)    NOT NULL,
    [HotSkinWeight]       FLOAT (53)    NOT NULL,
    [InputFileName]       CHAR (30)     NULL,
    [KillDate]            SMALLDATETIME NOT NULL,
    [LowWeightRange]      SMALLINT      NOT NULL,
    [PlantCode]           CHAR (10)     NOT NULL,
    [RecordID]            INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Tattoo]              CHAR (10)     NOT NULL,
    [TotalHead]           SMALLINT      NOT NULL,
    [TrimLostInd]         CHAR (10)     NOT NULL,
    [tstamp]              ROWVERSION    NULL,
    CONSTRAINT [cftPSDetTyson0] PRIMARY KEY CLUSTERED ([RecordID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [cftPSDetTyson_KillDate_Tattoo]
    ON [dbo].[cftPSDetTyson]([KillDate] ASC, [Tattoo] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [IDX_cftPSDetTyson_killdate_incl]
    ON [dbo].[cftPSDetTyson]([KillDate] ASC)
    INCLUDE([LowWeightRange], [PlantCode], [Tattoo], [TotalHead]) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxcftPSDetTyson_InputFileName]
    ON [dbo].[cftPSDetTyson]([InputFileName] ASC) WITH (FILLFACTOR = 90);

