CREATE TABLE [dbo].[cftPMTranspRecord_org] (
    [ActualArriveTime] SMALLDATETIME NOT NULL,
    [ActualLoadTime]   SMALLDATETIME NOT NULL,
    [AvgWgt]           FLOAT (53)    NOT NULL,
    [BatchNbr]         CHAR (10)     NOT NULL,
    [BirthDate1]       CHAR (3)      NOT NULL,
    [BirthDate2]       CHAR (3)      NOT NULL,
    [Crtd_DateTime]    SMALLDATETIME NOT NULL,
    [Crtd_Prog]        CHAR (8)      NOT NULL,
    [Crtd_User]        CHAR (10)     NOT NULL,
    [DateGraded]       SMALLDATETIME NOT NULL,
    [DestBarnNbr]      CHAR (10)     NOT NULL,
    [DestContactID]    CHAR (6)      NOT NULL,
    [DestFarmQty]      SMALLINT      NOT NULL,
    [DestPigGroupID]   CHAR (10)     NOT NULL,
    [DestProject]      CHAR (16)     NOT NULL,
    [DestRoomNbr]      CHAR (10)     NOT NULL,
    [DestTask]         CHAR (32)     NOT NULL,
    [DocType]          CHAR (2)      NOT NULL,
    [Genetics]         CHAR (20)     NOT NULL,
    [Lupd_DateTime]    SMALLDATETIME NOT NULL,
    [Lupd_Prog]        CHAR (8)      NOT NULL,
    [Lupd_User]        CHAR (10)     NOT NULL,
    [Movementdate]     SMALLDATETIME NOT NULL,
    [NoteID]           INT           NOT NULL,
    [OrigRefNbr]       CHAR (10)     NOT NULL,
    [PigGenderTypeID]  CHAR (10)     NOT NULL,
    [PigTrailerID]     CHAR (3)      NOT NULL,
    [PigTypeID]        CHAR (2)      NOT NULL,
    [PMID]             CHAR (6)      NOT NULL,
    [RecountContactID] CHAR (6)      NOT NULL,
    [RecountDate]      SMALLDATETIME NOT NULL,
    [RecountQty]       SMALLINT      NOT NULL,
    [RecountRequired]  SMALLINT      NOT NULL,
    [RefNbr]           CHAR (10)     NOT NULL,
    [SourceBarnNbr]    CHAR (10)     NOT NULL,
    [SourceContactID]  CHAR (6)      NOT NULL,
    [SourceFarmQty]    SMALLINT      NOT NULL,
    [SourcePigGroupID] CHAR (10)     NOT NULL,
    [SourceProject]    CHAR (16)     NOT NULL,
    [SourceRoomNbr]    CHAR (10)     NOT NULL,
    [SourceTask]       CHAR (32)     NOT NULL,
    [SubTypeID]        CHAR (2)      NOT NULL,
    [TotalWgt]         INT           NOT NULL,
    [tstamp]           ROWVERSION    NULL,
    CONSTRAINT [cftPMTranspRecord_org0] PRIMARY KEY CLUSTERED ([BatchNbr] ASC, [RefNbr] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [IX_cftPMTranspRecord_DestPigGroupID]
    ON [dbo].[cftPMTranspRecord_org]([DestPigGroupID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [IX_cftPMTranspRecord_SourcePigGroupID]
    ON [dbo].[cftPMTranspRecord_org]([SourcePigGroupID] ASC) WITH (FILLFACTOR = 90);

