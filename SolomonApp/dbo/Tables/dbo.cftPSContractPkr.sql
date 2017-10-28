CREATE TABLE [dbo].[cftPSContractPkr] (
    [Crtd_DateTime] SMALLDATETIME NULL,
    [Crtd_Prog]     CHAR (8)      NULL,
    [Crtd_User]     CHAR (10)     NULL,
    [CtrctNbr]      CHAR (6)      NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NULL,
    [Lupd_Prog]     CHAR (8)      NULL,
    [Lupd_User]     CHAR (10)     NULL,
    [PkrContactID]  CHAR (6)      NOT NULL,
    [tstamp]        ROWVERSION    NULL,
    CONSTRAINT [cftPSContractPkr0] PRIMARY KEY CLUSTERED ([CtrctNbr] ASC, [PkrContactID] ASC) WITH (FILLFACTOR = 90)
);

