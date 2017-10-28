CREATE TABLE [dbo].[cftPigTranSys] (
    [Crtd_DateTime]   SMALLDATETIME NOT NULL,
    [Crtd_Prog]       CHAR (8)      NOT NULL,
    [Crtd_User]       CHAR (10)     NOT NULL,
    [DestProdPhaseID] CHAR (3)      NOT NULL,
    [Lupd_DateTime]   SMALLDATETIME NOT NULL,
    [Lupd_Prog]       CHAR (8)      NOT NULL,
    [Lupd_User]       CHAR (10)     NOT NULL,
    [PigSystemID]     CHAR (2)      NOT NULL,
    [SrcProdPhaseID]  CHAR (3)      NOT NULL,
    [TranTypeID]      CHAR (2)      NOT NULL,
    [tstamp]          ROWVERSION    NOT NULL,
    CONSTRAINT [cftPigTranSys0] PRIMARY KEY CLUSTERED ([PigSystemID] ASC, [TranTypeID] ASC) WITH (FILLFACTOR = 90)
);

