CREATE TABLE [dbo].[cftPMSetup] (
    [ID]             INT        IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [BaseFuelCharge] FLOAT (53) NOT NULL,
    [LastPPRefNbr]   CHAR (10)  NOT NULL,
    [tstamp]         ROWVERSION NULL,
    CONSTRAINT [cftPMSetup0] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 90)
);

