CREATE TABLE [dbo].[cftFOHdr] (
    [BatNbr]        CHAR (10)     NOT NULL,
    [ContactID]     CHAR (6)      NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [LoadNbr]       CHAR (6)      NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [MillID]        CHAR (6)      NOT NULL,
    [PerNbr]        CHAR (6)      NOT NULL,
    [RefNbr]        CHAR (10)     NOT NULL,
    [SchedDate]     SMALLDATETIME NOT NULL,
    [SDLoaded]      SMALLDATETIME NOT NULL,
    [SOAct]         CHAR (1)      NOT NULL,
    [SortOrd]       CHAR (1)      NOT NULL,
    [tstamp]        ROWVERSION    NULL,
    CONSTRAINT [cftFOHdr0] PRIMARY KEY CLUSTERED ([BatNbr] ASC, [RefNbr] ASC) WITH (FILLFACTOR = 90)
);

