CREATE TABLE [dbo].[cftPSLotHormel] (
    [AvgLRBF]       FLOAT (53)    NOT NULL,
    [CarcassBase]   FLOAT (53)    NOT NULL,
    [CarcassValue]  FLOAT (53)    NOT NULL,
    [CarcassWgt]    FLOAT (53)    NOT NULL,
    [GradeCode]     CHAR (2)      NOT NULL,
    [InputFileName] CHAR (30)     NOT NULL,
    [InsurancePd]   FLOAT (53)    NOT NULL,
    [KillDate]      SMALLDATETIME NOT NULL,
    [LiveWgt]       FLOAT (53)    NOT NULL,
    [NLPC]          FLOAT (53)    NOT NULL,
    [PctRedBox]     FLOAT (53)    NOT NULL,
    [PPC]           FLOAT (53)    NOT NULL,
    [PurchaseCnt]   SMALLINT      NOT NULL,
    [PurchaseDate]  SMALLDATETIME NOT NULL,
    [ProducerNbr]   CHAR (10)     NOT NULL,
    [SpeciesCode]   CHAR (2)      NOT NULL,
    [TattooNbr]     CHAR (6)      NOT NULL,
    [TotLeanVal]    FLOAT (53)    NOT NULL,
    [TotSortDis]    FLOAT (53)    NOT NULL,
    [TrimsFlag]     CHAR (1)      NOT NULL,
    [TruckingPd]    FLOAT (53)    NOT NULL,
    [tstamp]        ROWVERSION    NULL,
    CONSTRAINT [cftPSLotHormel0] PRIMARY KEY CLUSTERED ([PurchaseDate] ASC, [TattooNbr] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [idxcftPSLotHormel_InputFileName]
    ON [dbo].[cftPSLotHormel]([InputFileName] ASC) WITH (FILLFACTOR = 90);

