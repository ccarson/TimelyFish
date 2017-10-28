CREATE TABLE [dbo].[cftPMTemp] (
    [EstimatedQty]    SMALLINT      NOT NULL,
    [MovementDate]    SMALLDATETIME NOT NULL,
    [PigTypeID]       CHAR (2)      NULL,
    [SourceContactID] CHAR (10)     NOT NULL,
    [tstamp]          ROWVERSION    NULL
);


GO
CREATE CLUSTERED INDEX [cftPMTempEss]
    ON [dbo].[cftPMTemp]([MovementDate] ASC, [SourceContactID] ASC);

