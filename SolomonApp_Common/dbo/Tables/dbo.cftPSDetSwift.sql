CREATE TABLE [dbo].[cftPSDetSwift] (
    [Comment1]        CHAR (20)     NOT NULL,
    [Comment1Code]    CHAR (4)      NOT NULL,
    [Comment2]        CHAR (20)     NOT NULL,
    [Comment2Code]    CHAR (4)      NOT NULL,
    [Comment3]        CHAR (20)     NOT NULL,
    [Comment3Code]    CHAR (4)      NOT NULL,
    [Comment4]        CHAR (20)     NOT NULL,
    [Comment4Code]    CHAR (4)      NOT NULL,
    [Comment5]        CHAR (20)     NOT NULL,
    [Comment5Code]    CHAR (4)      NOT NULL,
    [ExceptionCode]   CHAR (1)      NOT NULL,
    [Fat]             FLOAT (53)    NOT NULL,
    [FatUOM]          CHAR (6)      NOT NULL,
    [HotWeight]       FLOAT (53)    NOT NULL,
    [HotWeightUOM]    CHAR (6)      NOT NULL,
    [InputFileName]   CHAR (30)     NOT NULL,
    [KillDate]        SMALLDATETIME NOT NULL,
    [KillSeq]         CHAR (6)      NOT NULL,
    [LeanPct]         FLOAT (53)    NOT NULL,
    [LocCodeFarmNbr]  CHAR (3)      NOT NULL,
    [LoinEyeDepth]    FLOAT (53)    NOT NULL,
    [LoinEyeDepthUOM] CHAR (6)      NOT NULL,
    [OurSiteID]       CHAR (3)      NOT NULL,
    [PlantNbr]        CHAR (5)      NOT NULL,
    [ProducerID]      CHAR (9)      NOT NULL,
    [RecordID]        INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ReflectionNbr]   CHAR (2)      NOT NULL,
    [ShiftNbr]        SMALLINT      NOT NULL,
    [TattooNbr]       CHAR (6)      NOT NULL,
    [tstamp]          ROWVERSION    NULL,
    CONSTRAINT [cftPSDetSwift0] PRIMARY KEY CLUSTERED ([RecordID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [cftPSDetSwift_KillDate_Tattoo]
    ON [dbo].[cftPSDetSwift]([KillDate] ASC, [TattooNbr] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IDX_cftPSDetSwift_excode_kdate_incl]
    ON [dbo].[cftPSDetSwift]([ExceptionCode] ASC, [KillDate] ASC)
    INCLUDE([HotWeight], [PlantNbr], [TattooNbr]) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxcftPSDetSwift_InputFileName]
    ON [dbo].[cftPSDetSwift]([InputFileName] ASC) WITH (FILLFACTOR = 90);

