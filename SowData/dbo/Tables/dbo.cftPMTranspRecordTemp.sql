CREATE TABLE [dbo].[cftPMTranspRecordTemp] (
    [BatchNbr]        CHAR (10)     NOT NULL,
    [DestFarmQty]     SMALLINT      NOT NULL,
    [DocType]         CHAR (2)      NOT NULL,
    [Movementdate]    SMALLDATETIME NOT NULL,
    [OrigRefNbr]      CHAR (10)     NOT NULL,
    [PigTypeID]       CHAR (2)      NOT NULL,
    [RecountQty]      SMALLINT      NOT NULL,
    [RecountRequired] SMALLINT      NOT NULL,
    [RefNbr]          CHAR (10)     NOT NULL,
    [SourceContactID] CHAR (10)     NOT NULL,
    [SourceFarmQty]   SMALLINT      NOT NULL,
    [tstamp]          ROWVERSION    NULL
);


GO
CREATE CLUSTERED INDEX [cftPMTranspRecordTempEss]
    ON [dbo].[cftPMTranspRecordTemp]([SourceContactID] ASC, [Movementdate] ASC);

