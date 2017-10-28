CREATE TABLE [dbo].[cftPigPhaseSys] (
    [Crtd_DateTime]  SMALLDATETIME NOT NULL,
    [Crtd_Prog]      CHAR (8)      NOT NULL,
    [Crtd_User]      CHAR (10)     NOT NULL,
    [Lupd_DateTime]  SMALLDATETIME NOT NULL,
    [Lupd_Prog]      CHAR (8)      NOT NULL,
    [Lupd_User]      CHAR (10)     NOT NULL,
    [PigProdPhaseID] CHAR (3)      NOT NULL,
    [PigSystemID]    CHAR (2)      NOT NULL,
    [tstamp]         ROWVERSION    NOT NULL,
    CONSTRAINT [cftPigPhaseSys0] PRIMARY KEY CLUSTERED ([PigProdPhaseID] ASC, [PigSystemID] ASC) WITH (FILLFACTOR = 90)
);

