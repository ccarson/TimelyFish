CREATE TABLE [dbo].[EDCurrency] (
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [CuryID]        CHAR (10)     NOT NULL,
    [EDCuryID]      CHAR (10)     NOT NULL,
    [LUpd_DateTime] SMALLDATETIME NOT NULL,
    [LUpd_Prog]     CHAR (8)      NOT NULL,
    [LUpd_User]     CHAR (10)     NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [EDCurrency0] PRIMARY KEY CLUSTERED ([CuryID] ASC, [EDCuryID] ASC) WITH (FILLFACTOR = 90)
);

