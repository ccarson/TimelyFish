CREATE TABLE [dbo].[cftPSContrBPHist] (
    [BasePrice]     FLOAT (53)    NOT NULL,
    [BPDate]        SMALLDATETIME NOT NULL,
    [ContrNbr]      CHAR (10)     NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [tstamp]        ROWVERSION    NULL,
    CONSTRAINT [cftPSContrBPHist0] PRIMARY KEY CLUSTERED ([ContrNbr] ASC, [BPDate] ASC) WITH (FILLFACTOR = 90)
);

