CREATE TABLE [dbo].[VTSample_Setup] (
    [LastOrdNbr] CHAR (10)  NOT NULL,
    [SetupID]    CHAR (2)   NOT NULL,
    [tstamp]     ROWVERSION NOT NULL,
    CONSTRAINT [VTSample_Setup0] PRIMARY KEY CLUSTERED ([SetupID] ASC) WITH (FILLFACTOR = 90)
);

