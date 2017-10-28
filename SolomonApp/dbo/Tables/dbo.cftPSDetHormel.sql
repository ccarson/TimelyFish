CREATE TABLE [dbo].[cftPSDetHormel] (
    [CarcassValue]  FLOAT (53)    NOT NULL,
    [CarcassWgt]    FLOAT (53)    NOT NULL,
    [GradeCode]     CHAR (2)      NOT NULL,
    [InputFileName] CHAR (30)     NOT NULL,
    [KillDate]      SMALLDATETIME NOT NULL,
    [PurchaseDate]  SMALLDATETIME NOT NULL,
    [ProducerNbr]   CHAR (10)     NOT NULL,
    [RecordID]      INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [SpeciesCode]   CHAR (2)      NOT NULL,
    [TattooNbr]     CHAR (6)      NOT NULL,
    [TrimsFlag]     CHAR (1)      NOT NULL,
    [tstamp]        ROWVERSION    NULL,
    CONSTRAINT [cftPSDetHormel0] PRIMARY KEY CLUSTERED ([RecordID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [cftPSDetHormel_KillDate_Tattoo]
    ON [dbo].[cftPSDetHormel]([KillDate] ASC, [TattooNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxcftPSDetHormel_InputFileName]
    ON [dbo].[cftPSDetHormel]([InputFileName] ASC) WITH (FILLFACTOR = 90);

